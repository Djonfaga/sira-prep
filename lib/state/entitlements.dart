import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// What the free tier gets, and what Pro unlocks.
///
/// The structure is the model the category leader uses, and the same one
/// Vocablo ships: the free tier is generous enough to prove the app works and
/// to build a streak, but the things a committed student needs daily — the full
/// question bank, unlimited practice, full mocks, and the AI coach — are what
/// you pay for. Business models are not protectable and this one is well proven
/// for study apps.
///
/// The mechanics are identical to Vocablo's. The *thresholds* are not, and
/// cannot be: Vocablo gates a 6,035-word dictionary at word 500, which is
/// meaningless in an app whose largest module holds 30 reading passages. Each
/// number below is the same idea re-scaled to this content set — a complete,
/// genuinely useful slice of every module, with the bulk behind Pro.
class FreeTier {
  const FreeTier._();

  /// Free students get the first [itemsPerSkill] items of each of Reading,
  /// Listening, Speaking and Writing. Every module is sampled, so the free tier
  /// demonstrates the whole app rather than one corner of it.
  static const int itemsPerSkill = 3;

  /// Vocabulary review sets (20 cards each) available free.
  static const int vocabSets = 1;

  /// Grammar drill sets (20 items each) available free.
  static const int grammarSets = 1;

  /// Full timed mock exams available free. One is enough to show what the
  /// flagship feature is; it is also the single strongest reason to upgrade.
  static const int mockExams = 1;

  /// Practice hearts per day. A wrong answer costs one; at zero, practice
  /// pauses until tomorrow (or until they are earned back — see
  /// [correctAnswersForHeartRefill]).
  static const int dailyHearts = 3;

  /// Answering this many questions correctly refills hearts immediately, so an
  /// engaged free user is never hard-blocked — they are nudged toward the app's
  /// core loop rather than toward the store page.
  ///
  /// Vocablo refills after 100 newly learned words. That threshold would be
  /// unreachable here, because the free tier holds only 20 vocabulary cards, so
  /// the counter is driven by correct answers in *any* module instead. Same
  /// mechanic, same intent, reachable content.
  static const int correctAnswersForHeartRefill = 20;

  /// Lifetime cap on AI coach messages for free users.
  static const int aiMessageLimit = 20;
}

/// Play Console product identifiers. These strings must match the products
/// created in the Play Console exactly, or purchases silently fail to resolve.
class ProProducts {
  const ProProducts._();

  static const String monthly = 'siraprep_pro_monthly';
  static const String yearly = 'siraprep_pro_yearly';
  static const String lifetime = 'siraprep_pro_lifetime';

  /// Subscriptions are queried separately from one-off products by the plugin.
  static const Set<String> subscriptions = {monthly, yearly};
  static const Set<String> nonConsumables = {lifetime};
  static const Set<String> all = {monthly, yearly, lifetime};
}

/// Tracks Pro status and the free tier's consumable allowances.
///
/// Persisted locally so the app works offline and starts instantly. The store
/// remains the source of truth: [BillingService] re-validates on every launch
/// and calls [setPro], which can revoke as well as grant (e.g. a lapsed or
/// refunded subscription).
class Entitlements extends ChangeNotifier {
  Entitlements(this._prefs);

  final SharedPreferences _prefs;

  static const _proKey = 'pro.active';
  static const _proSourceKey = 'pro.source';
  static const _heartsUsedKey = 'pro.heartsUsedToday';
  static const _heartsDateKey = 'pro.heartsDate';
  static const _correctKey = 'pro.correctSinceRefill';
  static const _aiUsedKey = 'pro.aiMessagesUsed';

  bool _pro = false;
  String? _proSource;
  int _heartsUsedToday = 0;
  int _correctSinceRefill = 0;
  int _aiMessagesUsed = 0;
  String _heartsDate = _today();

  static String _today() {
    final d = DateTime.now();
    return '${d.year.toString().padLeft(4, '0')}-'
        '${d.month.toString().padLeft(2, '0')}-'
        '${d.day.toString().padLeft(2, '0')}';
  }

  // ── Persistence ──────────────────────────────────────────────────────────
  void load() {
    _pro = _prefs.getBool(_proKey) ?? false;
    _proSource = _prefs.getString(_proSourceKey);
    _heartsUsedToday = _prefs.getInt(_heartsUsedKey) ?? 0;
    _correctSinceRefill = _prefs.getInt(_correctKey) ?? 0;
    _aiMessagesUsed = _prefs.getInt(_aiUsedKey) ?? 0;
    _heartsDate = _prefs.getString(_heartsDateKey) ?? _today();
  }

  Future<void> _persist() async {
    await _prefs.setBool(_proKey, _pro);
    if (_proSource == null) {
      await _prefs.remove(_proSourceKey);
    } else {
      await _prefs.setString(_proSourceKey, _proSource!);
    }
    await _prefs.setInt(_heartsUsedKey, _heartsUsedToday);
    await _prefs.setInt(_correctKey, _correctSinceRefill);
    await _prefs.setInt(_aiUsedKey, _aiMessagesUsed);
    await _prefs.setString(_heartsDateKey, _heartsDate);
  }

  // ── Pro ──────────────────────────────────────────────────────────────────
  bool get isPro => _pro;

  /// Which product granted Pro, for display on the settings screen.
  String? get proSource => _proSource;

  /// Human-readable plan name for the settings screen.
  String get planLabel {
    if (!_pro) return 'Free';
    switch (_proSource) {
      case ProProducts.monthly:
        return 'Pro · Monthly';
      case ProProducts.yearly:
        return 'Pro · Yearly';
      case ProProducts.lifetime:
        return 'Pro · Lifetime';
      default:
        return 'Pro';
    }
  }

  /// Grants or revokes Pro. Called by [BillingService] after it validates
  /// purchases with the store — including on launch, so an expired
  /// subscription correctly loses access.
  void setPro(bool value, {String? source}) {
    if (_pro == value && _proSource == source) return;
    _pro = value;
    _proSource = value ? source : null;
    _persist();
    notifyListeners();
  }

  // ── Content gating ───────────────────────────────────────────────────────

  /// Whether a Reading/Listening/Speaking/Writing item at [index] is unlocked.
  bool canAccessSkillItem(int index) => _pro || index < FreeTier.itemsPerSkill;

  /// Whether a vocabulary review set at [index] is unlocked.
  bool canAccessVocabSet(int index) => _pro || index < FreeTier.vocabSets;

  /// Whether a grammar drill set at [index] is unlocked.
  bool canAccessGrammarSet(int index) => _pro || index < FreeTier.grammarSets;

  /// Whether a full mock exam at [index] is unlocked.
  bool canAccessMock(int index) => _pro || index < FreeTier.mockExams;

  // ── Hearts ───────────────────────────────────────────────────────────────

  void _rolloverIfNewDay() {
    final today = _today();
    if (_heartsDate != today) {
      _heartsDate = today;
      _heartsUsedToday = 0;
      _persist();
    }
  }

  int get heartsRemaining {
    if (_pro) return FreeTier.dailyHearts;
    _rolloverIfNewDay();
    return (FreeTier.dailyHearts - _heartsUsedToday)
        .clamp(0, FreeTier.dailyHearts);
  }

  bool get hasHearts => _pro || heartsRemaining > 0;

  /// Spends a heart on a wrong answer. No-op for Pro.
  void loseHeart() {
    if (_pro) return;
    _rolloverIfNewDay();
    if (_heartsUsedToday >= FreeTier.dailyHearts) return;
    _heartsUsedToday += 1;
    _persist();
    notifyListeners();
  }

  /// Correct answers still needed before hearts refill.
  int get correctAnswersUntilRefill =>
      (FreeTier.correctAnswersForHeartRefill - _correctSinceRefill)
          .clamp(0, FreeTier.correctAnswersForHeartRefill);

  /// Records a correct answer; refills hearts once the threshold is reached.
  void registerCorrectAnswer() {
    if (_pro) return;
    _correctSinceRefill += 1;
    if (_correctSinceRefill >= FreeTier.correctAnswersForHeartRefill) {
      _correctSinceRefill = 0;
      _heartsUsedToday = 0;
    }
    _persist();
    notifyListeners();
  }

  // ── AI coach ─────────────────────────────────────────────────────────────

  int get aiMessagesRemaining => _pro
      ? 1 << 30
      : (FreeTier.aiMessageLimit - _aiMessagesUsed)
          .clamp(0, FreeTier.aiMessageLimit);

  bool get canSendAiMessage => _pro || aiMessagesRemaining > 0;

  void registerAiMessage() {
    if (_pro) return;
    _aiMessagesUsed += 1;
    _persist();
    notifyListeners();
  }

  /// Test/debug helper — clears every consumable allowance.
  @visibleForTesting
  void resetAllowances() {
    _heartsUsedToday = 0;
    _correctSinceRefill = 0;
    _aiMessagesUsed = 0;
    _heartsDate = _today();
    _persist();
    notifyListeners();
  }
}
