import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
import '../../widgets/segment_pills.dart';
import 'vocab_player.dart';
import 'vocab_read_screen.dart';

enum _VocabTab { read, practice }

class VocabHub extends StatefulWidget {
  const VocabHub({super.key});
  @override
  State<VocabHub> createState() => _VocabHubState();
}

class _VocabHubState extends State<VocabHub> {
  _VocabTab _tab = _VocabTab.read;

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
                padding: const EdgeInsets.fromLTRB(8, 6, 16, 0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: Icon(Icons.close_rounded, color: context.c.text),
                    ),
                    Text('Vocabulary', style: t.titleLarge),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                child: SegmentPills<_VocabTab>(
                  items: const [
                    (value: _VocabTab.read, label: 'Read'),
                    (value: _VocabTab.practice, label: 'Practice'),
                  ],
                  icons: const {
                    _VocabTab.read: Icons.menu_book_outlined,
                    _VocabTab.practice: Icons.style_outlined,
                  },
                  selected: _tab,
                  onChanged: (v) => setState(() => _tab = v),
                ),
              ),
              Expanded(
                child: _tab == _VocabTab.read
                    ? const VocabReadList()
                    : const _VocabPracticeLanding(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VocabPracticeLanding extends StatelessWidget {
  const _VocabPracticeLanding();

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final exam = context.watch<ExamModeState>().exam;
    final user = context.watch<UserState>();
    final deck = contentFor(exam).vocab;
    final chunk = UserState.chunkSize;

    final sets = <List<VocabCard>>[];
    for (var i = 0; i < deck.length; i += chunk) {
      sets.add(deck.sublist(i, (i + chunk).clamp(0, deck.length)));
    }

    final due = user.dueVocabWords(deck.map((c) => c.word).toList()).length;
    final learned = user.vocabLearnedCount;
    final completedCount = List.generate(sets.length, (i) => i)
        .where((i) => user.isSetCompleted(exam, 'vocab', i))
        .length;
    final nextIdx = user.nextSetIndex(exam, 'vocab', sets.length);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
      children: [
        GlassCard(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const IconTile(icon: Icons.style_outlined, size: 44),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('REVIEW SETS',
                            style: t.labelSmall
                                ?.copyWith(letterSpacing: 1.4)),
                        const SizedBox(height: 4),
                        Text(
                          '${sets.length} ${sets.length == 1 ? "set" : "sets"} · up to $chunk cards each',
                          style: t.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  _Stat(label: 'DUE NOW', value: '$due'),
                  const SizedBox(width: 10),
                  _Stat(label: 'LEARNED', value: '$learned'),
                  const SizedBox(width: 10),
                  _Stat(
                    label: 'SETS DONE',
                    value: '$completedCount / ${sets.length}',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GlowButton(
                label: completedCount == sets.length
                    ? 'Replay set 1'
                    : 'Continue · set ${nextIdx + 1}',
                icon: Icons.play_arrow_rounded,
                expand: true,
                onPressed: sets.isEmpty
                    ? null
                    : () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => VocabPlayer(
                              cards: sets[nextIdx],
                              setIndex: nextIdx,
                            ),
                          ),
                        ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        for (var i = 0; i < sets.length; i++) ...[
          _SetRow(
            label: 'Set ${i + 1}',
            sub: '${sets[i].length} cards · ${_preview(sets[i])}',
            completedAt: user.setCompletedAt(exam, 'vocab', i),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => VocabPlayer(
                  cards: sets[i],
                  setIndex: i,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ],
    );
  }

  /// A short text preview of which words live in the set — gives a sense
  /// of what to expect before tapping in.
  String _preview(List<VocabCard> set) {
    final first = set.take(3).map((c) => c.word).join(', ');
    return first + (set.length > 3 ? '…' : '');
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: context.c.glassFill,
          border: Border.all(color: context.c.border),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: t.labelSmall?.copyWith(
                    color: context.c.textFaint, letterSpacing: 1.2)),
            const SizedBox(height: 4),
            Text(value,
                style: TextStyle(
                    color: context.c.text,
                    fontWeight: FontWeight.w800,
                    fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class _SetRow extends StatelessWidget {
  const _SetRow({
    required this.label,
    required this.sub,
    required this.completedAt,
    required this.onTap,
  });
  final String label;
  final String sub;
  final DateTime? completedAt;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final done = completedAt != null;
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: done
                  ? AppPalette.accentSuccess.withOpacity(0.18)
                  : AppPalette.brandBlue.withOpacity(0.18),
              border: Border.all(
                color: done
                    ? AppPalette.accentSuccess.withOpacity(0.55)
                    : AppPalette.brandBlue.withOpacity(0.55),
              ),
            ),
            child: Icon(
              done ? Icons.check_rounded : Icons.play_arrow_rounded,
              size: 18,
              color: done
                  ? AppPalette.accentSuccess
                  : AppPalette.brandBlue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: t.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(
                  done
                      ? 'Completed · ${DateFormat.MMMd().format(completedAt!)} · $sub'
                      : sub,
                  style: t.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded,
              color: context.c.textMuted, size: 22),
        ],
      ),
    );
  }
}
