import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models.dart';
import '../../state/exam_mode.dart';
import '../../state/user_state.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_background.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glow_button.dart';

class ReadingPlayer extends StatefulWidget {
  const ReadingPlayer({super.key, required this.passage, this.onCompleteRoute});
  final Passage passage;
  final VoidCallback? onCompleteRoute;

  @override
  State<ReadingPlayer> createState() => _ReadingPlayerState();
}

class _ReadingPlayerState extends State<ReadingPlayer> {
  int _question = -1; // -1 = passage view
  final _selected = <int, int>{}; // question idx -> chosen option idx

  void _next() {
    setState(() {
      _question++;
    });
  }

  void _select(int qIdx, int optIdx) {
    setState(() => _selected[qIdx] = optIdx);
  }

  int get _correct {
    var n = 0;
    for (var i = 0; i < widget.passage.questions.length; i++) {
      final picked = _selected[i];
      if (picked == null) continue;
      if (widget.passage.questions[i].options[picked] ==
          widget.passage.questions[i].answer) n++;
    }
    return n;
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final questions = widget.passage.questions;
    final passage = widget.passage;
    final exam = context.read<ExamModeState>().exam;
    final isDone = _question >= questions.length;
    final isPassage = _question < 0;

    return Scaffold(
      backgroundColor: context.c.bg,
      body: AppBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 6, 16, 0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: Icon(Icons.close_rounded, color: context.c.text),
                    ),
                    Text('Close', style: t.titleMedium),
                    const Spacer(),
                    if (!isPassage && !isDone)
                      Text('${_question + 1} / ${questions.length}',
                          style: t.bodyMedium),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 12),
                child: Text(passage.title, style: t.displayMedium),
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: isPassage
                      ? _PassageView(key: const ValueKey('passage'), passage: passage, onStart: _next)
                      : isDone
                          ? _ResultView(
                              key: const ValueKey('done'),
                              correct: _correct,
                              total: questions.length,
                              onClose: () {
                                // record activity then pop
                                final percent =
                                    (_correct * 100 / questions.length).round();
                                context.read<UserState>().recordActivity(
                                      HistoryItem(
                                        exam: exam,
                                        module: 'reading',
                                        title: passage.title,
                                        percent: percent,
                                        date: DateTime.now(),
                                      ),
                                    );
                                if (widget.onCompleteRoute != null) {
                                  widget.onCompleteRoute!();
                                } else {
                                  Navigator.of(context).maybePop();
                                }
                              },
                            )
                          : _QuestionView(
                              key: ValueKey('q$_question'),
                              question: questions[_question],
                              selectedIndex: _selected[_question],
                              onSelect: (i) => _select(_question, i),
                              onNext: _next,
                            ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PassageView extends StatelessWidget {
  const _PassageView({super.key, required this.passage, required this.onStart});
  final Passage passage;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GlassCard(
              tint: GlassTints.forIndex(0),
              padding: const EdgeInsets.all(18),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PASSAGE', style: t.labelSmall),
                    const SizedBox(height: 12),
                    Text(
                      passage.body,
                      style: t.bodyLarge?.copyWith(
                          color: context.c.text, height: 1.55),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          GlowButton(
            label: 'Begin questions',
            icon: Icons.play_arrow_rounded,
            expand: true,
            onPressed: onStart,
          ),
        ],
      ),
    );
  }
}

class _QuestionView extends StatelessWidget {
  const _QuestionView({
    super.key,
    required this.question,
    required this.selectedIndex,
    required this.onSelect,
    required this.onNext,
  });

  final MCQuestion question;
  final int? selectedIndex;
  final ValueChanged<int> onSelect;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              children: [
                Text(question.question,
                    style: t.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 16),
                for (var i = 0; i < question.options.length; i++) ...[
                  _OptionTile(
                    label: question.options[i],
                    selected: selectedIndex == i,
                    onTap: () => onSelect(i),
                  ),
                  const SizedBox(height: 10),
                ],
              ],
            ),
          ),
          GlowButton(
            label: selectedIndex == null ? 'Select an answer' : 'Continue',
            icon: Icons.arrow_forward_rounded,
            expand: true,
            onPressed: selectedIndex == null ? null : onNext,
          ),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final shape = BorderRadius.circular(16);
    return Material(
      color: Colors.transparent,
      borderRadius: shape,
      child: InkWell(
        onTap: onTap,
        borderRadius: shape,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: shape,
            color: selected
                ? AppPalette.brandBlue.withValues(alpha: 0.15)
                : Colors.white.withValues(alpha: 0.025),
            border: Border.all(
              color: selected ? AppPalette.brandBlue : context.c.border,
              width: selected ? 1.4 : 1,
            ),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected ? AppPalette.brandBlue : context.c.borderStrong,
                    width: 2,
                  ),
                ),
                child: selected
                    ? const Center(
                        child: Icon(Icons.check_rounded,
                            color: AppPalette.brandBlue, size: 14),
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: context.c.text,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultView extends StatelessWidget {
  const _ResultView({super.key, required this.correct, required this.total, required this.onClose});
  final int correct;
  final int total;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final pct = (correct * 100 / total).round();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: GlassCard(
          tint: GlassTints.forIndex(3),
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle_outline,
                  color: AppPalette.accentSuccess, size: 56),
              const SizedBox(height: 16),
              Text('Exercise complete', style: t.headlineMedium),
              const SizedBox(height: 6),
              Text('$correct / $total · $pct%',
                  style: t.displayMedium?.copyWith(color: AppPalette.brandBlue)),
              const SizedBox(height: 18),
              GlowButton(
                label: 'Done',
                icon: Icons.check_rounded,
                onPressed: onClose,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
