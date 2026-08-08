import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../data/models.dart';
import '../../state/exam_mode.dart';
import '../../state/user_state.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_background.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glow_button.dart';

enum _Phase { intro, prep, speak, done }

class SpeakingPlayer extends StatefulWidget {
  const SpeakingPlayer({super.key, required this.task, this.onCompleteRoute});
  final SpeakingTask task;
  final VoidCallback? onCompleteRoute;

  @override
  State<SpeakingPlayer> createState() => _SpeakingPlayerState();
}

class _SpeakingPlayerState extends State<SpeakingPlayer> {
  _Phase _phase = _Phase.intro;
  late int _remaining;
  Timer? _ticker;

  final _stt = stt.SpeechToText();
  bool _sttAvailable = false;
  bool _listening = false;
  String _transcript = '';

  final _tts = FlutterTts()..setLanguage('en-US');

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    _sttAvailable = await _stt.initialize(onStatus: (s) {
      if (s == 'done' || s == 'notListening') {
        setState(() => _listening = false);
      }
    }, onError: (_) => setState(() => _listening = false));
    setState(() {});
  }

  Future<void> _startPrep() async {
    if (widget.task.transcript != null) {
      await _tts.speak(widget.task.transcript!);
    }
    setState(() {
      _phase = _Phase.prep;
      _remaining = widget.task.prepSeconds;
    });
    _runTimer(onDone: _startSpeaking);
  }

  void _runTimer({required VoidCallback onDone}) {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() => _remaining--);
      if (_remaining <= 0) {
        t.cancel();
        onDone();
      }
    });
  }

  Future<void> _startSpeaking() async {
    setState(() {
      _phase = _Phase.speak;
      _remaining = widget.task.speakSeconds;
      _transcript = '';
    });
    if (_sttAvailable) {
      _stt.listen(
        onResult: (r) {
          setState(() => _transcript = r.recognizedWords);
        },
        listenFor: Duration(seconds: widget.task.speakSeconds),
        partialResults: true,
      );
      setState(() => _listening = true);
    }
    _runTimer(onDone: _finish);
  }

  void _finish() {
    if (_listening) _stt.stop();
    setState(() {
      _phase = _Phase.done;
      _listening = false;
    });
    final exam = context.read<ExamModeState>().exam;
    // Rough self-evaluation: score by word count vs. expected pace.
    final words = _transcript.trim().isEmpty
        ? 0
        : _transcript.trim().split(RegExp(r'\s+')).length;
    final expected = (widget.task.speakSeconds * 2.2).round(); // ~2 words/sec
    final ratio = expected == 0 ? 0.0 : (words / expected).clamp(0.0, 1.4);
    final percent = (ratio * 100).clamp(0, 100).round();
    context.read<UserState>().recordActivity(
          HistoryItem(
            exam: exam,
            module: 'speaking',
            title: 'Speaking · ${widget.task.type}',
            percent: percent,
            date: DateTime.now(),
          ),
        );
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _stt.stop();
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final task = widget.task;

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.type, style: t.labelSmall),
                    const SizedBox(height: 6),
                    Text('Speaking', style: t.displayMedium),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: GlassCard(
                          tint: GlassTints.forIndex(4),
                          padding: const EdgeInsets.all(18),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('PROMPT', style: t.labelSmall),
                                const SizedBox(height: 8),
                                Text(task.prompt,
                                    style: t.bodyLarge?.copyWith(
                                        color: context.c.text, height: 1.5)),
                                if (task.reading != null) ...[
                                  const SizedBox(height: 18),
                                  Text('READING', style: t.labelSmall),
                                  const SizedBox(height: 8),
                                  Text(task.reading!,
                                      style: t.bodyMedium?.copyWith(
                                          color: context.c.textMuted)),
                                ],
                                if (_phase == _Phase.speak ||
                                    _phase == _Phase.done) ...[
                                  const SizedBox(height: 18),
                                  Text('YOUR RESPONSE', style: t.labelSmall),
                                  const SizedBox(height: 8),
                                  Text(
                                    _transcript.isEmpty
                                        ? '(listening…)'
                                        : _transcript,
                                    style: t.bodyMedium?.copyWith(
                                        color: context.c.text,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      _PhaseBar(phase: _phase, remaining: _remaining, task: task),
                      const SizedBox(height: 14),
                      if (_phase == _Phase.intro)
                        GlowButton(
                          label: task.transcript != null
                              ? 'Play prompt & start'
                              : 'Start prep',
                          icon: Icons.play_arrow_rounded,
                          expand: true,
                          onPressed: _startPrep,
                        ),
                      if (_phase == _Phase.done) ...[
                        GlowButton(
                          label: 'Done',
                          icon: Icons.check_rounded,
                          expand: true,
                          onPressed: () {
                            if (widget.onCompleteRoute != null) {
                              widget.onCompleteRoute!();
                            } else {
                              Navigator.of(context).maybePop();
                            }
                          },
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

class _PhaseBar extends StatelessWidget {
  const _PhaseBar({required this.phase, required this.remaining, required this.task});
  final _Phase phase;
  final int remaining;
  final SpeakingTask task;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    Color color;
    String label;
    int total;
    if (phase == _Phase.prep) {
      color = AppPalette.brandBlue;
      label = 'PREP';
      total = task.prepSeconds;
    } else if (phase == _Phase.speak) {
      color = AppPalette.accentDanger;
      label = 'SPEAK';
      total = task.speakSeconds;
    } else {
      color = context.c.borderStrong;
      label = phase == _Phase.intro ? 'READY' : 'DONE';
      total = 1;
    }
    final progress = phase == _Phase.intro || phase == _Phase.done
        ? 1.0
        : (1 - (remaining / total)).clamp(0.0, 1.0);

    return GlassCard(
      tint: phase == _Phase.speak ? GlassTints.forIndex(4) : GlassTints.forIndex(3),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(label,
                  style: t.labelSmall?.copyWith(color: color, letterSpacing: 1.4)),
              const Spacer(),
              Text(
                phase == _Phase.intro || phase == _Phase.done
                    ? '--:--'
                    : '00:${remaining.toString().padLeft(2, '0')}',
                style: t.headlineMedium?.copyWith(color: color, fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: Colors.white.withValues(alpha: 0.07),
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ],
      ),
    );
  }
}
