import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data/models.dart';
import '../../data/store.dart';
import '../../state/entitlements.dart';
import '../../state/exam_mode.dart';
import '../../state/user_state.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_background.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glow_button.dart';
import '../../widgets/icon_tile.dart';
import '../../widgets/segment_pills.dart';
import '../paywall_screen.dart';
import 'grammar_player.dart';
import 'grammar_read_screen.dart';

enum _GrammarTab { read, practice }

class GrammarHub extends StatefulWidget {
  const GrammarHub({super.key});
  @override
  State<GrammarHub> createState() => _GrammarHubState();
}

class _GrammarHubState extends State<GrammarHub> {
  _GrammarTab _tab = _GrammarTab.read;

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
                    Text('Grammar', style: t.titleLarge),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                child: SegmentPills<_GrammarTab>(
                  items: const [
                    (value: _GrammarTab.read, label: 'Read'),
                    (value: _GrammarTab.practice, label: 'Practice'),
                  ],
                  icons: const {
                    _GrammarTab.read: Icons.menu_book_outlined,
                    _GrammarTab.practice: Icons.fact_check_outlined,
                  },
                  selected: _tab,
                  onChanged: (v) => setState(() => _tab = v),
                ),
              ),
              Expanded(
                child: _tab == _GrammarTab.read
                    ? const GrammarReadList()
                    : const _GrammarPracticeLanding(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GrammarPracticeLanding extends StatelessWidget {
  const _GrammarPracticeLanding();

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final exam = context.watch<ExamModeState>().exam;
    final user = context.watch<UserState>();
    final ent = context.watch<Entitlements>();
    final all = contentFor(exam).grammar;
    final chunk = UserState.chunkSize;
    final sets = <List<GrammarItem>>[];
    for (var i = 0; i < all.length; i += chunk) {
      sets.add(all.sublist(i, (i + chunk).clamp(0, all.length)));
    }
    final accuracy = user.grammarAccuracyFor(exam);
    final completedCount = List.generate(sets.length, (i) => i)
        .where((i) => user.isSetCompleted(exam, 'grammar', i))
        .length;
    final nextIdx = user.nextSetIndex(exam, 'grammar', sets.length);

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
                  const IconTile(icon: Icons.fact_check_outlined, size: 44),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('DRILL SETS',
                            style: t.labelSmall
                                ?.copyWith(letterSpacing: 1.4)),
                        const SizedBox(height: 4),
                        Text(
                          ent.isPro
                              ? '${sets.length} ${sets.length == 1 ? "set" : "sets"} · up to $chunk questions each'
                              : '${sets.length} sets · ${FreeTier.grammarSets} free · up to $chunk questions each',
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
                  _Stat(
                    label: 'ACCURACY',
                    value:
                        accuracy == null ? '—' : '${accuracy.round()}%',
                  ),
                  const SizedBox(width: 10),
                  _Stat(
                    label: 'DONE',
                    value: '$completedCount / ${sets.length}',
                  ),
                  const SizedBox(width: 10),
                  _Stat(
                    label: 'QUESTIONS',
                    value: '${all.length}',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GlowButton(
                label: !ent.canAccessGrammarSet(nextIdx)
                    ? 'Unlock all ${sets.length} sets'
                    : completedCount == sets.length
                        ? 'Restart set 1'
                        : 'Continue · set ${nextIdx + 1}',
                icon: !ent.canAccessGrammarSet(nextIdx)
                    ? Icons.lock_open_outlined
                    : Icons.play_arrow_rounded,
                expand: true,
                onPressed: sets.isEmpty
                    ? null
                    : !ent.canAccessGrammarSet(nextIdx)
                        ? () => PaywallScreen.show(context,
                            trigger: PaywallTrigger.contentLocked)
                        : () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => GrammarPlayer(
                                  items: sets[nextIdx],
                                  setIndex: nextIdx,
                                ),
                              ),
                            ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        for (var i = 0; i < sets.length; i++) ...[
          _SetRow(
            label: 'Set ${i + 1}',
            sub:
                '${sets[i].length} ${sets[i].length == 1 ? "question" : "questions"}',
            completedAt: user.setCompletedAt(exam, 'grammar', i),
            locked: !ent.canAccessGrammarSet(i),
            onTap: !ent.canAccessGrammarSet(i)
                ? () => PaywallScreen.show(context,
                    trigger: PaywallTrigger.contentLocked)
                : () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => GrammarPlayer(
                          items: sets[i],
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
    this.locked = false,
  });
  final String label;
  final String sub;
  final DateTime? completedAt;
  final VoidCallback onTap;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final done = completedAt != null;
    final accent = locked
        ? context.c.textMuted
        : done
            ? AppPalette.accentSuccess
            : AppPalette.brandBlue;
    return Opacity(
      opacity: locked ? 0.55 : 1,
      child: GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: accent.withValues(alpha: 0.18),
              border: Border.all(color: accent.withValues(alpha: 0.55)),
            ),
            child: Icon(
              locked
                  ? Icons.lock_outline
                  : done
                      ? Icons.check_rounded
                      : Icons.play_arrow_rounded,
              size: 18,
              color: accent,
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
                  locked
                      ? 'Pro · $sub'
                      : done
                          ? 'Completed · ${DateFormat.MMMd().format(completedAt!)}'
                          : sub,
                  style: t.bodySmall,
                ),
              ],
            ),
          ),
          Icon(
            locked ? Icons.lock_outline : Icons.chevron_right_rounded,
            color: context.c.textMuted,
            size: 22,
          ),
        ],
      ),
      ),
    );
  }
}
