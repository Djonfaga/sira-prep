import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models.dart';
import '../../state/exam_mode.dart';
import '../../state/user_state.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_background.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glow_button.dart';

class WritingPlayer extends StatefulWidget {
  const WritingPlayer({super.key, required this.task, this.onCompleteRoute});
  final WritingTask task;
  final VoidCallback? onCompleteRoute;

  @override
  State<WritingPlayer> createState() => _WritingPlayerState();
}

class _WritingPlayerState extends State<WritingPlayer> {
  final _controller = TextEditingController();
  int _remaining = 0;
  Timer? _ticker;
  bool _submitted = false;
  int _score = 0;

  static const _transitions = [
    'however', 'therefore', 'furthermore', 'moreover', 'consequently',
    'nevertheless', 'thus', 'for instance', 'for example', 'in conclusion',
    'on the other hand', 'specifically', 'additionally', 'firstly', 'secondly',
    'finally', 'in contrast', 'similarly', 'indeed', 'meanwhile', 'because',
    'since', 'although', 'while', 'whereas', 'nonetheless',
    'conversely', 'subsequently', 'accordingly',
  ];

  @override
  void initState() {
    super.initState();
    _remaining = widget.task.minutes * 60;
    _ticker = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() => _remaining--);
      if (_remaining <= 0) {
        t.cancel();
        _submit();
      }
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _controller.dispose();
    super.dispose();
  }

  int _countWords(String s) =>
      s.trim().isEmpty ? 0 : s.trim().split(RegExp(r'\s+')).length;

  int _countTransitions(String s) {
    final lower = s.toLowerCase();
    var n = 0;
    for (final m in _transitions) {
      final r = RegExp('\\b${RegExp.escape(m)}\\b');
      n += r.allMatches(lower).length;
    }
    return n;
  }

  void _submit() {
    _ticker?.cancel();
    final text = _controller.text;
    final words = _countWords(text);
    final trans = _countTransitions(text);
    final lengthScore = (words.clamp(0, 280) / 280) * 50; // up to 50
    final transScore = (trans.clamp(0, 8) / 8) * 25; // up to 25
    final sentences = text.split(RegExp(r'[.!?]+')).where((s) => s.trim().isNotEmpty).length;
    final avg = sentences == 0 ? 0 : words / sentences;
    final complexity = (avg >= 14 && avg <= 24) ? 25.0 : (avg > 9 ? 18.0 : 8.0);
    final pct = (lengthScore + transScore + complexity).round();

    setState(() {
      _submitted = true;
      _score = pct;
    });
    final exam = context.read<ExamModeState>().exam;
    context.read<UserState>().recordActivity(
          HistoryItem(
            exam: exam,
            module: 'writing',
            title: 'Writing · ${widget.task.type}',
            percent: pct,
            date: DateTime.now(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final task = widget.task;
    final mins = (_remaining / 60).floor();
    final secs = (_remaining % 60).toString().padLeft(2, '0');
    final words = _countWords(_controller.text);

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
                    Text('$mins:$secs · $words words', style: t.bodyMedium),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.type, style: t.labelSmall),
                    const SizedBox(height: 6),
                    Text('Writing', style: t.displayMedium),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                  child: _submitted
                      ? _ResultCard(score: _score, words: words, onClose: () {
                          if (widget.onCompleteRoute != null) {
                            widget.onCompleteRoute!();
                          } else {
                            Navigator.of(context).maybePop();
                          }
                        })
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            GlassCard(
                              tint: GlassTints.forIndex(0),
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('PROMPT', style: t.labelSmall),
                                  const SizedBox(height: 6),
                                  Text(task.prompt,
                                      style: t.bodyMedium?.copyWith(
                                          color: context.c.text)),
                                  if (task.reading != null) ...[
                                    const SizedBox(height: 12),
                                    Text('READING', style: t.labelSmall),
                                    const SizedBox(height: 6),
                                    Text(task.reading!, style: t.bodySmall),
                                  ],
                                  if (task.discussionPosts.isNotEmpty) ...[
                                    const SizedBox(height: 12),
                                    Text('DISCUSSION', style: t.labelSmall),
                                    const SizedBox(height: 6),
                                    for (final p in task.discussionPosts) ...[
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(p.name,
                                                style: t.bodySmall?.copyWith(
                                                    color: AppPalette.brandBlue,
                                                    fontWeight: FontWeight.w700)),
                                            Text(p.text, style: t.bodySmall),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ],
                                ],
                              ),
                            ),
                            const SizedBox(height: 14),
                            Expanded(
                              child: GlassCard(
                                tint: GlassTints.forIndex(2),
                                padding: const EdgeInsets.all(14),
                                child: TextField(
                                  controller: _controller,
                                  expands: true,
                                  maxLines: null,
                                  minLines: null,
                                  onChanged: (_) => setState(() {}),
                                  textAlignVertical: TextAlignVertical.top,
                                  style: TextStyle(
                                      color: context.c.text,
                                      fontSize: 15,
                                      height: 1.4),
                                  cursorColor: AppPalette.brandBlue,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Write your response here…',
                                    hintStyle:
                                        TextStyle(color: context.c.textFaint),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            GlowButton(
                              label: 'Submit response',
                              icon: Icons.send_rounded,
                              expand: true,
                              onPressed: _controller.text.trim().isEmpty
                                  ? null
                                  : _submit,
                            ),
                          ],
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

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.score, required this.words, required this.onClose});
  final int score;
  final int words;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Center(
      child: GlassCard(
        tint: GlassTints.forIndex(3),
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.task_alt_rounded,
                color: AppPalette.accentSuccess, size: 56),
            const SizedBox(height: 16),
            Text('Response submitted', style: t.headlineMedium),
            const SizedBox(height: 6),
            Text('$score / 100',
                style: t.displayMedium?.copyWith(color: AppPalette.brandBlue)),
            Text('$words words', style: t.bodyMedium),
            const SizedBox(height: 18),
            GlowButton(label: 'Done', icon: Icons.check_rounded, onPressed: onClose),
          ],
        ),
      ),
    );
  }
}
