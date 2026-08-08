import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'exam_mode.dart';

/// One row in the user's recent activity feed.
class HistoryItem {
  HistoryItem({
    required this.exam,
    required this.module,
    required this.title,
    required this.percent,
    required this.date,
  });

  final Exam exam;
  final String module; // 'reading' | 'listening' | 'speaking' | 'writing' | 'mock' | 'grammar' | 'vocab'
  final String title;
  final int percent; // 0..100
  final DateTime date;

  Map<String, dynamic> toJson() => {
        'exam': exam == Exam.ielts ? 'ielts' : 'toefl',
        'module': module,
        'title': title,
        'percent': percent,
        'date': date.toIso8601String(),
      };

  factory HistoryItem.fromJson(Map<String, dynamic> j) => HistoryItem(
        exam: j['exam'] == 'ielts' ? Exam.ielts : Exam.toefl,
        module: j['module'] as String,
        title: j['title'] as String,
        percent: (j['percent'] as num).toInt(),
        date: DateTime.parse(j['date'] as String),
      );
}

/// SRS bucket for a single vocabulary word.
/// box 0 = brand new, box 5 = mastered (review every 30+ days).
class VocabProgress {
  VocabProgress({
    required this.word,
    required this.box,
    required this.nextReview,
    required this.lastReview,
  });

  final String word;
  int box;
  DateTime nextReview;
  DateTime lastReview;

  bool get learned => box >= 3;
  bool get mastered => box >= 5;

  Map<String, dynamic> toJson() => {
        'word': word,
        'box': box,
        'nextReview': nextReview.toIso8601String(),
        'lastReview': lastReview.toIso8601String(),
      };

  factory VocabProgress.fromJson(Map<String, dynamic> j) => VocabProgress(
        word: j['word'] as String,
        box: (j['box'] as num).toInt(),
        nextReview: DateTime.parse(j['nextReview'] as String),
        lastReview: DateTime.parse(j['lastReview'] as String),
      );
}

/// Snapshot of insights for one exam, ready to render on Home.
class ExamInsights {
  ExamInsights({
    required this.exam,
    required this.projected,
    required this.projectedMax,
    required this.projectedDelta,
    required this.sectionScores,
    required this.sectionDeltas,
    required this.sectionAttempts,
    required this.dayStreak,
    required this.hoursPracticed,
    required this.totalAttempts,
    required this.vocabLearned,
    required this.vocabTotal,
    required this.grammarAccuracy,
    required this.focusArea,
    required this.focusReason,
  });

  final Exam exam;

  /// Projected overall: 0..120 for TOEFL, 0..90 for IELTS (band × 10).
  final double projected;
  final double projectedMax;
  final double projectedDelta;

  /// Per-skill score 0..30 (TOEFL) or 0..90 IELTS (band × 10).
  final Map<String, double> sectionScores; // module -> score
  final Map<String, double> sectionDeltas;
  final Map<String, int> sectionAttempts;

  final int dayStreak;
  final double hoursPracticed;
  final int totalAttempts;

  final int vocabLearned;
  final int vocabTotal;

  /// 0..100. Null when the user hasn't done any grammar drills yet.
  final double? grammarAccuracy;

  final String focusArea; // 'Reading' / 'Listening' / etc.
  final String focusReason;

  /// Display-formatted overall score, e.g. "92" for TOEFL or "7.0" for IELTS.
  String get projectedLabel {
    if (exam == Exam.ielts) {
      // Round to nearest 0.5, IELTS-style.
      final band = (projected / 10);
      final rounded = (band * 2).round() / 2;
      return rounded.toStringAsFixed(1);
    }
    return projected.round().toString();
  }

  String sectionLabel(String module) {
    final v = sectionScores[module] ?? 0;
    if (exam == Exam.ielts) {
      final band = v / 10;
      final rounded = (band * 2).round() / 2;
      return rounded.toStringAsFixed(1);
    }
    return v.round().toString();
  }

  String get projectedMaxLabel => exam == Exam.ielts ? '9.0' : '120';
}

class UserState extends ChangeNotifier {
  UserState(this._prefs);

  final SharedPreferences _prefs;
  static const _onboardedKey = 'user.onboarded';
  static const _nameKey = 'user.name';
  static const _emailKey = 'user.email';
  static const _historyKey = 'user.history';
  static const _vocabKey = 'user.vocab';
  static const _setsKey = 'user.completedSets';

  /// Standard "chunk" size for both Grammar drills and Vocabulary reviews.
  /// Pedagogical sweet-spot — small enough to finish in one sitting, large
  /// enough to feel like a meaningful session.
  static const int chunkSize = 20;

  bool _onboarded = false;
  String _name = '';
  String _email = '';
  final List<HistoryItem> _history = [];

  /// SRS bucket per word — shared across exams (vocab is exam-agnostic in our
  /// current dataset; per-exam buckets can be added later if needed).
  final Map<String, VocabProgress> _vocab = {};

  /// Completed-set marker keyed by "<exam>:<module>:<setIdx>", e.g.
  /// "toefl:grammar:0". Value is the completion time.
  final Map<String, DateTime> _completedSets = {};

  bool get onboarded => _onboarded;
  String get name => _name;
  String get email => _email;
  List<HistoryItem> get history => List.unmodifiable(_history);
  Map<String, VocabProgress> get vocab => Map.unmodifiable(_vocab);

  /// Recent activity for the currently selected exam only.
  List<HistoryItem> historyFor(Exam exam) =>
      _history.where((h) => h.exam == exam).toList();

  int totalAttempts(Exam exam) => historyFor(exam).length;

  double totalHours(Exam exam) {
    final list = historyFor(exam);
    final mins = list.fold<double>(
        0,
        (a, b) => a +
            (b.module == 'mock'
                ? 30
                : (b.module == 'vocab' || b.module == 'grammar' ? 1.0 : 2.0)));
    return mins / 60.0;
  }

  int dayStreak(Exam exam) {
    final dates = historyFor(exam).map((h) {
      final d = h.date;
      return DateTime(d.year, d.month, d.day);
    }).toSet();
    if (dates.isEmpty) return 0;
    var streak = 0;
    var cursor = DateTime.now();
    cursor = DateTime(cursor.year, cursor.month, cursor.day);
    while (dates.contains(cursor)) {
      streak++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return streak;
  }

  /// Returns the skill (module) with the lowest mean score among the four
  /// core skills, or 'Reading' as a default.
  String? focusArea(Exam exam) {
    final list = historyFor(exam);
    if (list.isEmpty) return 'Reading';
    final byModule = <String, List<int>>{};
    for (final h in list) {
      if (!{'reading', 'listening', 'speaking', 'writing'}.contains(h.module)) continue;
      byModule.putIfAbsent(h.module, () => []).add(h.percent);
    }
    if (byModule.isEmpty) return 'Reading';
    final means = byModule
        .map((k, v) => MapEntry(k, v.reduce((a, b) => a + b) / v.length));
    final worst = means.entries.reduce((a, b) => a.value < b.value ? a : b).key;
    return _capitalize(worst);
  }

  String _capitalize(String s) =>
      s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';

  /// Average accuracy (0..100) for one module across recent attempts.
  double averageFor(Exam exam, String module, {int recent = 6}) {
    final items = historyFor(exam)
        .where((h) => h.module == module)
        .take(recent)
        .toList();
    if (items.isEmpty) return 0;
    return items.fold<double>(0, (a, b) => a + b.percent) / items.length;
  }

  double _deltaFor(Exam exam, String module) {
    final items =
        historyFor(exam).where((h) => h.module == module).toList();
    if (items.length < 2) return 0;
    final half = (items.length / 2).floor();
    final recent = items.sublist(0, half);
    final earlier = items.sublist(half, (half * 2).clamp(0, items.length));
    if (earlier.isEmpty) return 0;
    final r = recent.fold<double>(0, (a, b) => a + b.percent) / recent.length;
    final e = earlier.fold<double>(0, (a, b) => a + b.percent) / earlier.length;
    return r - e;
  }

  /// Vocab learned (box ≥ 3) — call site can compare against the total deck
  /// size to render "1,200 / 5,000".
  int get vocabLearnedCount =>
      _vocab.values.where((p) => p.learned).length;

  /// Grammar accuracy averaged across all grammar attempts (0..100).
  /// Returns null when there are zero grammar attempts.
  double? grammarAccuracyFor(Exam exam) {
    final items =
        historyFor(exam).where((h) => h.module == 'grammar').toList();
    if (items.isEmpty) return null;
    return items.fold<double>(0, (a, b) => a + b.percent) / items.length;
  }

  /// Composite insights bundle ready for the Home view.
  ExamInsights insightsFor(Exam exam, {required int vocabDeckSize}) {
    final modules = ['reading', 'listening', 'speaking', 'writing'];
    final sectionScores = <String, double>{};
    final sectionDeltas = <String, double>{};
    final sectionAttempts = <String, int>{};

    final maxPerSection = exam == Exam.ielts ? 90.0 : 30.0;

    for (final m in modules) {
      final acc = averageFor(exam, m);
      sectionScores[m] = (acc / 100) * maxPerSection;
      sectionDeltas[m] = (_deltaFor(exam, m) / 100) * maxPerSection;
      sectionAttempts[m] = historyFor(exam).where((h) => h.module == m).length;
    }

    final projected = sectionScores.values.fold<double>(0, (a, b) => a + b);
    final projectedDelta =
        sectionDeltas.values.fold<double>(0, (a, b) => a + b) /
            modules.length; // average delta in section units
    final projectedMax = maxPerSection * modules.length;

    final focusKey =
        focusArea(exam)?.toLowerCase() ?? 'reading';
    final focusAccuracy = averageFor(exam, focusKey);
    final focusReason = focusAccuracy == 0
        ? 'No attempts yet — start with one passage.'
        : 'Recent accuracy ${focusAccuracy.round()}% · keep building this skill.';

    return ExamInsights(
      exam: exam,
      projected: projected,
      projectedMax: projectedMax,
      projectedDelta: projectedDelta,
      sectionScores: sectionScores,
      sectionDeltas: sectionDeltas,
      sectionAttempts: sectionAttempts,
      dayStreak: dayStreak(exam),
      hoursPracticed: totalHours(exam),
      totalAttempts: totalAttempts(exam),
      vocabLearned: vocabLearnedCount,
      vocabTotal: vocabDeckSize,
      grammarAccuracy: grammarAccuracyFor(exam),
      focusArea: _capitalize(focusKey),
      focusReason: focusReason,
    );
  }

  // ── Persistence ──────────────────────────────────────────────────────────
  void load() {
    _onboarded = _prefs.getBool(_onboardedKey) ?? false;
    _name = _prefs.getString(_nameKey) ?? '';
    _email = _prefs.getString(_emailKey) ?? '';
    final raw = _prefs.getString(_historyKey);
    if (raw != null && raw.isNotEmpty) {
      try {
        final list =
            (jsonDecode(raw) as List<dynamic>).cast<Map<String, dynamic>>();
        _history
          ..clear()
          ..addAll(list.map(HistoryItem.fromJson));
      } catch (_) {}
    }
    final vraw = _prefs.getString(_vocabKey);
    if (vraw != null && vraw.isNotEmpty) {
      try {
        final list =
            (jsonDecode(vraw) as List<dynamic>).cast<Map<String, dynamic>>();
        _vocab.clear();
        for (final j in list) {
          final p = VocabProgress.fromJson(j);
          _vocab[p.word] = p;
        }
      } catch (_) {}
    }
    final sraw = _prefs.getString(_setsKey);
    if (sraw != null && sraw.isNotEmpty) {
      try {
        final m = (jsonDecode(sraw) as Map<String, dynamic>);
        _completedSets.clear();
        m.forEach((k, v) {
          _completedSets[k] = DateTime.parse(v as String);
        });
      } catch (_) {}
    }
  }

  Future<void> _persist() async {
    await _prefs.setBool(_onboardedKey, _onboarded);
    await _prefs.setString(_nameKey, _name);
    await _prefs.setString(_emailKey, _email);
    await _prefs.setString(
      _historyKey,
      jsonEncode(_history.map((h) => h.toJson()).toList()),
    );
    await _prefs.setString(
      _vocabKey,
      jsonEncode(_vocab.values.map((v) => v.toJson()).toList()),
    );
    await _prefs.setString(
      _setsKey,
      jsonEncode(_completedSets
          .map((k, v) => MapEntry(k, v.toIso8601String()))),
    );
  }

  void completeOnboarding({required String name, Exam? exam}) {
    _name = name.trim();
    _onboarded = true;
    _persist();
    notifyListeners();
  }

  void setName(String name) {
    _name = name.trim();
    _persist();
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email.trim();
    _persist();
    notifyListeners();
  }

  void recordActivity(HistoryItem item) {
    _history.insert(0, item);
    if (_history.length > 200) _history.removeRange(200, _history.length);
    _persist();
    notifyListeners();
  }

  // ── Set chunking ─────────────────────────────────────────────────────────
  String _setKey(Exam exam, String module, int idx) =>
      '${exam == Exam.ielts ? "ielts" : "toefl"}:$module:$idx';

  bool isSetCompleted(Exam exam, String module, int setIdx) =>
      _completedSets.containsKey(_setKey(exam, module, setIdx));

  DateTime? setCompletedAt(Exam exam, String module, int setIdx) =>
      _completedSets[_setKey(exam, module, setIdx)];

  void markSetCompleted(Exam exam, String module, int setIdx) {
    _completedSets[_setKey(exam, module, setIdx)] = DateTime.now();
    _persist();
    notifyListeners();
  }

  /// Returns the index of the next not-yet-finished set for the given module,
  /// or 0 if every set has been finished (so the user can replay).
  int nextSetIndex(Exam exam, String module, int totalSets) {
    for (var i = 0; i < totalSets; i++) {
      if (!isSetCompleted(exam, module, i)) return i;
    }
    return 0;
  }

  // ── Vocab SRS ────────────────────────────────────────────────────────────
  VocabProgress? vocabFor(String word) => _vocab[word];

  void recordVocab(String word, {required bool gotIt}) {
    final now = DateTime.now();
    final cur = _vocab[word];
    final newBox = gotIt
        ? ((cur?.box ?? 0) + 1).clamp(0, 5)
        : ((cur?.box ?? 0) - 1).clamp(0, 5);
    // Leitner-style intervals: box 0 = 0 days (immediate), 1 = 1 day, 2 = 3
    // days, 3 = 7, 4 = 14, 5 = 30 days.
    const intervals = <int, int>{0: 0, 1: 1, 2: 3, 3: 7, 4: 14, 5: 30};
    final next = now.add(Duration(days: intervals[newBox] ?? 1));
    _vocab[word] = VocabProgress(
      word: word,
      box: newBox,
      nextReview: next,
      lastReview: now,
    );
    _persist();
    notifyListeners();
  }

  /// Words due for review now (nextReview ≤ now). Falls back to "all unseen"
  /// when nothing is due yet so the player always has something to show.
  List<String> dueVocabWords(List<String> deck) {
    final now = DateTime.now();
    final due = <String>[];
    for (final w in deck) {
      final p = _vocab[w];
      if (p == null) {
        due.add(w); // never seen → due
      } else if (!p.nextReview.isAfter(now)) {
        due.add(w);
      }
    }
    return due;
  }

  void resetExam(Exam exam) {
    _history.removeWhere((h) => h.exam == exam);
    final prefix = '${exam == Exam.ielts ? "ielts" : "toefl"}:';
    _completedSets.removeWhere((k, _) => k.startsWith(prefix));
    _persist();
    notifyListeners();
  }

  void resetAll() {
    _history.clear();
    _onboarded = false;
    _name = '';
    _email = '';
    _vocab.clear();
    _completedSets.clear();
    _persist();
    notifyListeners();
  }
}
