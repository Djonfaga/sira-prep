import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

import '../../data/models.dart';
import '../../data/store.dart';
import '../../state/exam_mode.dart';
import '../../state/user_state.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_background.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glow_button.dart';
import '../../widgets/icon_tile.dart';

/// Vocabulary review session inspired by WordUp: word + part-of-speech +
/// definition + example sentence + TTS pronunciation, with "Know it" /
/// "Still learning" buttons that feed a Leitner-style spaced-repetition
/// schedule. Picks the words due today (or first-time words) from the
/// content deck for the active exam.
class VocabPlayer extends StatefulWidget {
  const VocabPlayer({super.key, this.cards, this.setIndex});

  /// Specific cards to play. When null, the player pulls every word due
  /// today from the deck.
  final List<VocabCard>? cards;
  final int? setIndex;

  @override
  State<VocabPlayer> createState() => _VocabPlayerState();
}

class _VocabPlayerState extends State<VocabPlayer> {
  late final FlutterTts _tts;
  late final List<VocabCard> _queue;
  late final Exam _exam;
  int _index = 0;
  bool _revealed = false;
  int _knownThisSession = 0;
  int _stillLearningThisSession = 0;

  @override
  void initState() {
    super.initState();
    _tts = FlutterTts()
      ..setLanguage('en-US')
      ..setSpeechRate(0.45);
    _exam = context.read<ExamModeState>().exam;

    if (widget.cards != null) {
      _queue = List<VocabCard>.from(widget.cards!);
    } else {
      final deck = contentFor(_exam).vocab;
      final user = context.read<UserState>();
      final dueWords =
          user.dueVocabWords(deck.map((v) => v.word).toList()).toSet();
      final dueCards =
          deck.where((c) => dueWords.contains(c.word)).toList();
      _queue = dueCards.isEmpty ? List<VocabCard>.from(deck) : dueCards;
    }
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  VocabCard? get _current =>
      _index >= 0 && _index < _queue.length ? _queue[_index] : null;

  Future<void> _speak() async {
    final c = _current;
    if (c == null) return;
    await _tts.stop();
    await _tts.speak(c.word);
  }

  void _record({required bool gotIt}) {
    final card = _current;
    if (card == null) return;
    final user = context.read<UserState>();
    user.recordVocab(card.word, gotIt: gotIt);
    setState(() {
      if (gotIt) {
        _knownThisSession++;
      } else {
        _stillLearningThisSession++;
      }
      _revealed = false;
      _index++;
    });
  }

  void _flip() => setState(() => _revealed = !_revealed);

  void _finishSession() {
    final user = context.read<UserState>();
    if (_queue.isNotEmpty) {
      final pct = (_knownThisSession * 100 / _queue.length).round();
      final title = widget.setIndex == null
          ? 'Vocabulary session'
          : 'Vocabulary set ${widget.setIndex! + 1}';
      user.recordActivity(HistoryItem(
        exam: _exam,
        module: 'vocab',
        title: title,
        percent: pct,
        date: DateTime.now(),
      ));
      if (widget.setIndex != null) {
        user.markSetCompleted(_exam, 'vocab', widget.setIndex!);
      }
    }
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: context.c.bg,
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 6, 16, 4),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: _finishSession,
                      icon: Icon(Icons.close_rounded, color: context.c.text),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('VOCABULARY',
                              style: t.labelSmall?.copyWith(letterSpacing: 1.4)),
                          Text(
                            _queue.isEmpty
                                ? 'Nothing due — well done'
                                : '${_index.clamp(0, _queue.length)} / ${_queue.length} cards',
                            style: t.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    _SessionStat(
                      knownCount: _knownThisSession,
                      stillCount: _stillLearningThisSession,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Expanded(child: _body(t)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(TextTheme t) {
    if (_queue.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: GlassCard(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const IconTile(icon: Icons.celebration_outlined, size: 56),
                const SizedBox(height: 14),
                Text('All caught up', style: t.headlineMedium),
                const SizedBox(height: 6),
                Text(
                  'No vocabulary cards are due right now. Come back tomorrow — '
                  'spaced repetition keeps words from fading.',
                  style: t.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),
                GlowButton(
                  label: 'Back to Study',
                  icon: Icons.arrow_back_rounded,
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (_index >= _queue.length) {
      return _SessionSummary(
        known: _knownThisSession,
        still: _stillLearningThisSession,
        onDone: _finishSession,
      );
    }

    final card = _queue[_index];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Progress
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: (_index + 1) / _queue.length,
              minHeight: 4,
              backgroundColor: context.c.border,
              valueColor: const AlwaysStoppedAnimation(AppPalette.brandBlue),
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: _WordCard(
              card: card,
              revealed: _revealed,
              onTap: _flip,
              onPronounce: _speak,
              t: t,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _ChoiceButton(
                  icon: Icons.refresh_rounded,
                  label: 'Still learning',
                  color: AppPalette.accentDanger,
                  onTap: () => _record(gotIt: false),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ChoiceButton(
                  icon: Icons.check_rounded,
                  label: 'I know it',
                  color: AppPalette.accentSuccess,
                  onTap: () => _record(gotIt: true),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WordCard extends StatelessWidget {
  const _WordCard({
    required this.card,
    required this.revealed,
    required this.onTap,
    required this.onPronounce,
    required this.t,
  });
  final VocabCard card;
  final bool revealed;
  final VoidCallback onTap;
  final VoidCallback onPronounce;
  final TextTheme t;

  String get _definition =>
      card.definition ?? 'Means ${card.answer.toLowerCase()}.';

  String get _example {
    if (card.example != null && card.example!.isNotEmpty) return card.example!;
    // Cheap auto-example so existing data still feels populated; the JSON
    // schema upgrades cleanly when authored examples come in.
    return 'In context: a $_pos $_kw can be hard to grasp at first.'
        .replaceAll('$_kw', card.word.toLowerCase());
  }

  String get _kw => card.word.toLowerCase();
  String get _pos => card.partOfSpeech ?? '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  card.word,
                  style: t.displayLarge?.copyWith(
                    fontSize: 36,
                    color: AppPalette.brandBlue,
                  ),
                ),
                const Spacer(),
                Material(
                  color: Colors.transparent,
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: onPronounce,
                    customBorder: const CircleBorder(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppPalette.brandBlue.withOpacity(0.15),
                        border: Border.all(
                            color: AppPalette.brandBlue.withOpacity(0.45)),
                      ),
                      child: const Icon(Icons.volume_up_rounded,
                          color: AppPalette.brandBlue, size: 20),
                    ),
                  ),
                ),
              ],
            ),
            if (card.partOfSpeech != null) ...[
              const SizedBox(height: 4),
              Text(card.partOfSpeech!.toUpperCase(),
                  style: t.labelSmall?.copyWith(letterSpacing: 1.4)),
            ],
            const SizedBox(height: 18),
            AnimatedCrossFade(
              firstChild: _hiddenSide(context),
              secondChild: _revealedSide(context),
              crossFadeState: revealed
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 220),
              sizeCurve: Curves.easeOut,
            ),
          ],
        ),
      ),
    );
  }

  Widget _hiddenSide(BuildContext context) {
    final c = context.c;
    return Container(
      key: const ValueKey('hidden'),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: c.glassFill,
        border: Border.all(color: c.border),
      ),
      child: Column(
        children: [
          Text('Tap to reveal definition',
              style: TextStyle(color: c.textMuted, fontSize: 14)),
          const SizedBox(height: 10),
          Icon(Icons.keyboard_double_arrow_down_rounded,
              color: c.textFaint),
        ],
      ),
    );
  }

  Widget _revealedSide(BuildContext context) {
    final c = context.c;
    return Column(
      key: const ValueKey('shown'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('MEANING',
            style: TextStyle(
              color: c.textFaint,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.4,
            )),
        const SizedBox(height: 6),
        Text(_definition, style: TextStyle(color: c.text, fontSize: 18, height: 1.4)),
        const SizedBox(height: 16),
        Text('EXAMPLE',
            style: TextStyle(
              color: c.textFaint,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.4,
            )),
        const SizedBox(height: 6),
        Text(_example,
            style: TextStyle(
              color: c.text,
              fontSize: 15,
              height: 1.5,
              fontStyle: FontStyle.italic,
            )),
      ],
    );
  }
}

class _ChoiceButton extends StatelessWidget {
  const _ChoiceButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            border: Border.all(color: color.withOpacity(0.45), width: 1.4),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(height: 4),
              Text(label,
                  style: TextStyle(
                      color: color, fontWeight: FontWeight.w700, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}

class _SessionStat extends StatelessWidget {
  const _SessionStat({required this.knownCount, required this.stillCount});
  final int knownCount;
  final int stillCount;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _chip(Icons.check_rounded, AppPalette.accentSuccess, '$knownCount'),
        const SizedBox(width: 6),
        _chip(Icons.refresh_rounded, AppPalette.accentDanger, '$stillCount'),
      ],
    );
  }

  Widget _chip(IconData icon, Color color, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 4),
          Text(value,
              style: TextStyle(
                  color: color, fontSize: 12, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _SessionSummary extends StatelessWidget {
  const _SessionSummary({
    required this.known,
    required this.still,
    required this.onDone,
  });
  final int known;
  final int still;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: GlassCard(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const IconTile(icon: Icons.task_alt_rounded, size: 56),
              const SizedBox(height: 14),
              Text('Session complete', style: t.headlineMedium),
              const SizedBox(height: 6),
              Text('$known known · $still still learning',
                  style: t.bodyLarge),
              const SizedBox(height: 18),
              GlowButton(
                label: 'Done',
                icon: Icons.check_rounded,
                onPressed: onDone,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
