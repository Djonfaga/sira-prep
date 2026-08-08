import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

import '../../data/models.dart';
import '../../state/exam_mode.dart';
import '../../state/user_state.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_background.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glow_button.dart';

class ListeningPlayer extends StatefulWidget {
  const ListeningPlayer({super.key, required this.lecture, this.onCompleteRoute});
  final Lecture lecture;
  final VoidCallback? onCompleteRoute;

  @override
  State<ListeningPlayer> createState() => _ListeningPlayerState();
}

class _ListeningPlayerState extends State<ListeningPlayer> {
  late final FlutterTts _tts;
  bool _isPlaying = false;
  bool _hasPlayed = false;
  int _question = 0;
  final _selected = <int, int>{};

  @override
  void initState() {
    super.initState();
    _tts = FlutterTts()
      ..setLanguage('en-US')
      ..setSpeechRate(0.45)
      ..setPitch(1.0);
    _tts.setStartHandler(() => setState(() => _isPlaying = true));
    _tts.setCompletionHandler(() {
      setState(() {
        _isPlaying = false;
        _hasPlayed = true;
      });
    });
    _tts.setCancelHandler(() => setState(() => _isPlaying = false));
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  Future<void> _togglePlay() async {
    if (_isPlaying) {
      await _tts.stop();
    } else {
      await _tts.speak(widget.lecture.transcript);
    }
  }

  int get _correct {
    var n = 0;
    for (var i = 0; i < widget.lecture.questions.length; i++) {
      final picked = _selected[i];
      if (picked == null) continue;
      if (widget.lecture.questions[i].options[picked] ==
          widget.lecture.questions[i].answer) n++;
    }
    return n;
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final lecture = widget.lecture;
    final exam = context.read<ExamModeState>().exam;
    final showQuestions = _hasPlayed;
    final allDone = _question >= lecture.questions.length;

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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 12),
                child: Text(lecture.title, style: t.displayMedium),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                  child: Column(
                    children: [
                      GlassCard(
                        tint: GlassTints.forIndex(1),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text('LECTURE AUDIO',
                                style: t.labelSmall),
                            const SizedBox(height: 16),
                            _PlayButton(
                              isPlaying: _isPlaying,
                              onTap: _togglePlay,
                            ),
                            const SizedBox(height: 14),
                            Text(
                              _isPlaying
                                  ? 'Listening…'
                                  : _hasPlayed
                                      ? 'Replay or move on to questions.'
                                      : 'Tap to start the lecture.',
                              style: t.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (showQuestions && !allDone) ...[
                        Expanded(
                          child: _QuestionList(
                            question: lecture.questions[_question],
                            selectedIndex: _selected[_question],
                            onSelect: (i) =>
                                setState(() => _selected[_question] = i),
                          ),
                        ),
                        GlowButton(
                          label: _selected[_question] == null
                              ? 'Select an answer'
                              : 'Continue',
                          icon: Icons.arrow_forward_rounded,
                          expand: true,
                          onPressed: _selected[_question] == null
                              ? null
                              : () => setState(() => _question++),
                        ),
                      ] else if (showQuestions && allDone) ...[
                        const SizedBox(height: 4),
                        Expanded(
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
                                  Text('Lecture complete',
                                      style: t.headlineMedium),
                                  const SizedBox(height: 6),
                                  Text(
                                      '$_correct / ${lecture.questions.length} · ${(_correct * 100 / lecture.questions.length).round()}%',
                                      style: t.displayMedium?.copyWith(
                                          color: AppPalette.brandBlue)),
                                  const SizedBox(height: 18),
                                  GlowButton(
                                    label: 'Done',
                                    icon: Icons.check_rounded,
                                    onPressed: () {
                                      final pct = (_correct *
                                              100 /
                                              lecture.questions.length)
                                          .round();
                                      context.read<UserState>().recordActivity(
                                            HistoryItem(
                                              exam: exam,
                                              module: 'listening',
                                              title: lecture.title,
                                              percent: pct,
                                              date: DateTime.now(),
                                            ),
                                          );
                                      if (widget.onCompleteRoute != null) {
                                        widget.onCompleteRoute!();
                                      } else {
                                        Navigator.of(context).maybePop();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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

class _PlayButton extends StatelessWidget {
  const _PlayButton({required this.isPlaying, required this.onTap});
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 86,
        height: 86,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFB7D3FF), AppPalette.brandBlue],
          ),
          boxShadow: [
            BoxShadow(
              color: AppPalette.brandBlue.withValues(alpha: isPlaying ? 0.7 : 0.5),
              blurRadius: 28,
              spreadRadius: isPlaying ? 0 : -2,
            ),
          ],
        ),
        child: Icon(
          isPlaying ? Icons.stop_rounded : Icons.play_arrow_rounded,
          color: const Color(0xFF0A1430),
          size: 36,
        ),
      ),
    );
  }
}

class _QuestionList extends StatelessWidget {
  const _QuestionList({
    required this.question,
    required this.selectedIndex,
    required this.onSelect,
  });
  final MCQuestion question;
  final int? selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return ListView(
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
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile(
      {required this.label, required this.selected, required this.onTap});
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
        child: Container(
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
          child: Text(label,
              style: TextStyle(color: context.c.text, fontSize: 15)),
        ),
      ),
    );
  }
}
