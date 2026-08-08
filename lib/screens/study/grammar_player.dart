import 'package:flutter/material.dart';
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
import 'hearts_gate.dart';

/// Quick-fire grammar quiz. Plays a slice of at most [UserState.chunkSize]
/// items so each session stays inside the pedagogical sweet-spot. The
/// session is anchored to a [setIndex] so completion can be recorded
/// against that specific set on the practice landing.
class GrammarPlayer extends StatefulWidget {
  const GrammarPlayer({super.key, this.items, this.setIndex});

  /// Items to play. When null, the player runs the entire content list —
  /// used by the mock exam flow and any other legacy caller.
  final List<GrammarItem>? items;
  final int? setIndex;

  @override
  State<GrammarPlayer> createState() => _GrammarPlayerState();
}

class _GrammarPlayerState extends State<GrammarPlayer> {
  late final List<GrammarItem> _queue;
  late final Exam _exam;
  int _index = 0;
  int? _picked;
  bool _reveal = false;
  int _correct = 0;
  final Map<String, int> _ruleHits = {};
  final Map<String, int> _ruleAttempts = {};

  @override
  void initState() {
    super.initState();
    _exam = context.read<ExamModeState>().exam;
    _queue = List<GrammarItem>.from(
        widget.items ?? contentFor(_exam).grammar);
  }

  Future<void> _select(int idx) async {
    if (_reveal) return;
    final item = _queue[_index];
    final right = item.options[idx] == item.answer;
    setState(() {
      _picked = idx;
      _reveal = true;
      _ruleAttempts[item.rule] = (_ruleAttempts[item.rule] ?? 0) + 1;
      if (right) {
        _correct++;
        _ruleHits[item.rule] = (_ruleHits[item.rule] ?? 0) + 1;
      }
    });

    // A wrong answer costs a free-tier heart. Out of hearts ends the session
    // with the score so far recorded, so nothing the student did is lost.
    final mayContinue =
        await HeartsGate.registerAnswer(context, correct: right);
    if (!mayContinue && mounted) _finish();
  }

  void _next() {
    setState(() {
      _picked = null;
      _reveal = false;
      _index++;
    });
  }

  void _finish() {
    final user = context.read<UserState>();
    if (_queue.isNotEmpty) {
      final pct = (_correct * 100 / _queue.length).round();
      final setLabel = widget.setIndex == null
          ? 'Grammar drills'
          : 'Grammar set ${widget.setIndex! + 1}';
      user.recordActivity(HistoryItem(
        exam: _exam,
        module: 'grammar',
        title: setLabel,
        percent: pct,
        date: DateTime.now(),
      ));
      if (widget.setIndex != null) {
        user.markSetCompleted(_exam, 'grammar', widget.setIndex!);
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
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 6, 16, 4),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: _finish,
                      icon: Icon(Icons.close_rounded, color: context.c.text),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('GRAMMAR',
                              style: t.labelSmall?.copyWith(letterSpacing: 1.4)),
                          Text(
                            _queue.isEmpty
                                ? 'No drills available'
                                : '${(_index + 1).clamp(1, _queue.length)} / ${_queue.length} questions',
                            style: t.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    Text('Score $_correct',
                        style: t.bodyMedium?.copyWith(
                            color: AppPalette.brandBlue,
                            fontWeight: FontWeight.w700)),
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
                Text('Grammar drills coming soon', style: t.headlineMedium),
                const SizedBox(height: 18),
                GlowButton(
                    label: 'Done',
                    onPressed: () => Navigator.of(context).maybePop()),
              ],
            ),
          ),
        ),
      );
    }
    if (_index >= _queue.length) {
      return _Summary(
        correct: _correct,
        total: _queue.length,
        ruleHits: _ruleHits,
        ruleAttempts: _ruleAttempts,
        onDone: _finish,
      );
    }

    final item = _queue[_index];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
            child: ListView(
              children: [
                GlassCard(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          color: AppPalette.brandBlue.withValues(alpha: 0.15),
                          border: Border.all(
                              color: AppPalette.brandBlue.withValues(alpha: 0.45)),
                        ),
                        child: Text(item.rule.toUpperCase(),
                            style: const TextStyle(
                                color: AppPalette.brandBlue,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.2)),
                      ),
                      const SizedBox(height: 14),
                      Text(item.question,
                          style: t.titleLarge?.copyWith(height: 1.4)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                for (var i = 0; i < item.options.length; i++) ...[
                  _OptionTile(
                    label: item.options[i],
                    state: _stateFor(i),
                    onTap: () => _select(i),
                  ),
                  const SizedBox(height: 10),
                ],
                if (_reveal) ...[
                  const SizedBox(height: 4),
                  GlassCard(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.lightbulb_outline,
                            color: AppPalette.accentWarn, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(item.explanation,
                              style: t.bodyMedium?.copyWith(height: 1.45)),
                        ),
                      ],
                    ),
                  ),
                ]
              ],
            ),
          ),
          if (_reveal)
            GlowButton(
              label: _index + 1 >= _queue.length ? 'Finish' : 'Next',
              icon: Icons.arrow_forward_rounded,
              expand: true,
              onPressed: _next,
            ),
        ],
      ),
    );
  }

  _OptionState _stateFor(int i) {
    if (!_reveal) return _OptionState.idle;
    final item = _queue[_index];
    if (item.options[i] == item.answer) return _OptionState.correct;
    if (_picked == i) return _OptionState.wrong;
    return _OptionState.idle;
  }
}

enum _OptionState { idle, correct, wrong }

class _OptionTile extends StatelessWidget {
  const _OptionTile(
      {required this.label, required this.state, required this.onTap});
  final String label;
  final _OptionState state;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final shape = BorderRadius.circular(16);
    Color border;
    Color bg;
    IconData? icon;
    Color iconColor = context.c.textMuted;
    switch (state) {
      case _OptionState.correct:
        border = AppPalette.accentSuccess;
        bg = AppPalette.accentSuccess.withValues(alpha: 0.12);
        icon = Icons.check_circle_outline;
        iconColor = AppPalette.accentSuccess;
        break;
      case _OptionState.wrong:
        border = AppPalette.accentDanger;
        bg = AppPalette.accentDanger.withValues(alpha: 0.12);
        icon = Icons.cancel_outlined;
        iconColor = AppPalette.accentDanger;
        break;
      case _OptionState.idle:
        border = context.c.border;
        bg = context.c.glassFill;
        icon = null;
        break;
    }
    return Material(
      color: Colors.transparent,
      borderRadius: shape,
      child: InkWell(
        onTap: state == _OptionState.idle ? onTap : null,
        borderRadius: shape,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: shape,
            color: bg,
            border: Border.all(color: border, width: state == _OptionState.idle ? 1 : 1.4),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(label,
                    style: TextStyle(
                        color: context.c.text,
                        fontSize: 15,
                        height: 1.35)),
              ),
              if (icon != null) Icon(icon, color: iconColor, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({
    required this.correct,
    required this.total,
    required this.ruleHits,
    required this.ruleAttempts,
    required this.onDone,
  });
  final int correct;
  final int total;
  final Map<String, int> ruleHits;
  final Map<String, int> ruleAttempts;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final rules = ruleAttempts.keys.toList()..sort();
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      children: [
        GlassCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const IconTile(icon: Icons.task_alt_rounded, size: 56),
              const SizedBox(height: 12),
              Text('Drills complete', style: t.headlineMedium),
              const SizedBox(height: 6),
              Text('$correct / $total · ${(correct * 100 / total).round()}%',
                  style: t.displayMedium?.copyWith(
                      color: AppPalette.brandBlue, fontSize: 32)),
            ],
          ),
        ),
        const SizedBox(height: 14),
        if (rules.isNotEmpty)
          GlassCard(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('BY RULE', style: t.labelSmall?.copyWith(letterSpacing: 1.2)),
                const SizedBox(height: 10),
                for (final r in rules) ...[
                  _RuleRow(
                    rule: r,
                    hits: ruleHits[r] ?? 0,
                    attempts: ruleAttempts[r]!,
                  ),
                  const SizedBox(height: 12),
                ],
              ],
            ),
          ),
        const SizedBox(height: 16),
        GlowButton(
            label: 'Done',
            icon: Icons.check_rounded,
            expand: true,
            onPressed: onDone),
      ],
    );
  }
}

class _RuleRow extends StatelessWidget {
  const _RuleRow({required this.rule, required this.hits, required this.attempts});
  final String rule;
  final int hits;
  final int attempts;
  @override
  Widget build(BuildContext context) {
    final pct = (hits / attempts).clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(rule, style: const TextStyle(fontWeight: FontWeight.w600))),
            Text('$hits / $attempts',
                style: TextStyle(
                    color: context.c.textMuted,
                    fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: pct,
            minHeight: 4,
            backgroundColor: context.c.border,
            valueColor: const AlwaysStoppedAnimation(AppPalette.brandBlue),
          ),
        ),
      ],
    );
  }
}
