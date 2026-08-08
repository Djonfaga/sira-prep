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
import '../study/listening_player.dart';
import '../study/reading_player.dart';
import '../study/speaking_player.dart';
import '../study/writing_player.dart';

/// Plays a full mock. Each [MockSection] declares an [itemCount] — the number
/// of passages / lectures / tasks to chain — so a TOEFL Reading section
/// actually plays 2 passages and a TOEFL Listening section plays 5 items
/// (3 lectures + 2 conversations), matching the Jan 21, 2026 test format.
///
/// Different mocks use different slices of the content list (offset by the
/// mock's index), so Mock 1 plays passages 1–2, Mock 2 plays passages 3–4,
/// and so on — wrapping around when the content list is exhausted.
class MockPlayer extends StatefulWidget {
  const MockPlayer({super.key, required this.mock});
  final MockExam mock;

  @override
  State<MockPlayer> createState() => _MockPlayerState();
}

class _MockPlayerState extends State<MockPlayer> {
  int _sectionIndex = 0;
  int _itemIndex = 0;

  void _advance() {
    final section = widget.mock.sections[_sectionIndex];
    if (_itemIndex + 1 < section.itemCount) {
      setState(() => _itemIndex++);
    } else {
      setState(() {
        _sectionIndex++;
        _itemIndex = 0;
      });
    }
  }

  /// Pick item N from list, wrapping around. Different mocks offset their
  /// starting item so Mock 2's passages differ from Mock 1's.
  T _pick<T>(List<T> source, int index) {
    return source[index % source.length];
  }

  int _mockOffset() {
    // Use the trailing number in the mock id (e.g. "t-mock-7" -> 7) so the
    // offset is stable across rebuilds and per-mock unique.
    final m = RegExp(r'(\d+)$').firstMatch(widget.mock.id);
    return m == null ? 0 : int.parse(m.group(1)!);
  }

  Widget _playerFor(String module, ExamContent c) {
    final offset = _mockOffset();
    final section = widget.mock.sections[_sectionIndex];
    final start = offset * section.itemCount + _itemIndex;
    switch (module) {
      case 'Reading':
        return ReadingPlayer(
          passage: _pick(c.reading, start),
          onCompleteRoute: _advance,
        );
      case 'Listening':
        return ListeningPlayer(
          lecture: _pick(c.listening, start),
          onCompleteRoute: _advance,
        );
      case 'Writing':
        return WritingPlayer(
          task: _pick(c.writing, start),
          onCompleteRoute: _advance,
        );
      case 'Speaking':
        return SpeakingPlayer(
          task: _pick(c.speaking, start),
          onCompleteRoute: _advance,
        );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final sections = widget.mock.sections;
    final exam = context.read<ExamModeState>().exam;
    final content = contentFor(exam);

    if (_sectionIndex >= sections.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<UserState>().recordActivity(
              HistoryItem(
                exam: exam,
                module: 'mock',
                title: widget.mock.title,
                percent: 100,
                date: DateTime.now(),
              ),
            );
      });
      return _MockSummary(mock: widget.mock);
    }

    final current = sections[_sectionIndex];
    // Each player widget owns its own state and is keyed by section+item so
    // moving to the next item rebuilds it from scratch (fresh timer, no
    // leaked transcript, no stale answers).
    final playerKey = ValueKey('mock-${widget.mock.id}-s$_sectionIndex-i$_itemIndex');

    return Scaffold(
      backgroundColor: context.c.bg,
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 6, 16, 0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: Icon(Icons.close_rounded, color: context.c.text),
                    ),
                    Expanded(
                      child: Text(
                        '${widget.mock.title} · ${current.module}',
                        style: t.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      'Item ${_itemIndex + 1}/${current.itemCount} · Section ${_sectionIndex + 1}/${sections.length}',
                      style: t.bodySmall,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: KeyedSubtree(
                  key: playerKey,
                  child: _playerFor(current.module, content),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MockSummary extends StatelessWidget {
  const _MockSummary({required this.mock});
  final MockExam mock;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final totalItems =
        mock.sections.fold<int>(0, (a, s) => a + s.itemCount);
    return Scaffold(
      backgroundColor: context.c.bg,
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: GlassCard(
                tint: GlassTints.forIndex(3),
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const IconTile(
                      icon: Icons.emoji_events_outlined,
                      size: 64,
                      color: AppPalette.accentSira,
                    ),
                    const SizedBox(height: 18),
                    Text('Mock complete', style: t.headlineMedium),
                    const SizedBox(height: 6),
                    Text(
                      mock.title,
                      style: t.bodyLarge?.copyWith(color: AppPalette.brandBlue),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '$totalItems items across ${mock.sections.length} sections · ${mock.minutes} min target',
                      style: t.bodySmall,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Your results were saved to your activity feed. '
                      'Open Home to see where to focus next.',
                      textAlign: TextAlign.center,
                      style: t.bodyMedium,
                    ),
                    const SizedBox(height: 22),
                    GlowButton(
                      label: 'Back to mocks',
                      icon: Icons.arrow_back_rounded,
                      onPressed: () => Navigator.of(context).maybePop(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
