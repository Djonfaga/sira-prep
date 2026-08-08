import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models.dart';
import '../../data/store.dart';
import '../../state/entitlements.dart';
import '../../state/exam_mode.dart';
import '../../state/user_state.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glow_button.dart';
import '../../widgets/icon_tile.dart';
import '../../widgets/section_header.dart';
import '../../widgets/segment_pills.dart';
import '../paywall_screen.dart';
import 'mock_player.dart';

enum _Filter { todo, done }

class MocksTab extends StatefulWidget {
  const MocksTab({super.key});
  @override
  State<MocksTab> createState() => _MocksTabState();
}

class _MocksTabState extends State<MocksTab> {
  _Filter _filter = _Filter.todo;

  @override
  Widget build(BuildContext context) {
    final exam = context.watch<ExamModeState>().exam;
    final user = context.watch<UserState>();
    final ent = context.watch<Entitlements>();
    final content = contentFor(exam);
    final history = user.historyFor(exam);
    final doneIds = history.where((h) => h.module == 'mock').map((h) => h.title).toSet();

    // Gating is keyed to the mock's position in the canonical list, not its
    // position after filtering — otherwise switching the To-Do/Done filter
    // would silently change which exams are unlocked.
    final mocks = <({MockExam mock, bool locked})>[];
    for (var i = 0; i < content.mocks.length; i++) {
      final m = content.mocks[i];
      final done = doneIds.contains(m.title);
      if (_filter == _Filter.done ? done : !done) {
        mocks.add((mock: m, locked: !ent.canAccessMock(i)));
      }
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
      children: [
        SectionHeader(
          eyebrow: exam.label,
          title: 'Mock Exams',
          subtitle: 'Full simulations under real test conditions.',
        ),
        const SizedBox(height: 18),
        SegmentPills<_Filter>(
          items: const [
            (value: _Filter.todo, label: 'To-Do'),
            (value: _Filter.done, label: 'Done'),
          ],
          selected: _filter,
          onChanged: (v) => setState(() => _filter = v),
        ),
        const SizedBox(height: 18),
        if (mocks.isEmpty)
          GlassCard(
            tint: GlassTints.forIndex(2),
            child: Text(
              _filter == _Filter.done
                  ? 'You haven\'t finished a mock yet — switch back to To-Do to start one.'
                  : 'No more pending mocks. Switch to Done to revisit your past results.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          )
        else ...[
          // First 10 mocks render as the full visual card. The remainder are
          // collapsed into a single compact list so the screen does not turn
          // into endless repetition.
          for (var i = 0; i < mocks.length && i < 10; i++) ...[
            _MockCard(
              mock: mocks[i].mock,
              index: i,
              locked: mocks[i].locked,
            ),
            const SizedBox(height: 14),
          ],
          if (mocks.length > 10) ...[
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 6),
              child: Text(
                'MORE MOCKS · ${mocks.length - 10}',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            GlassCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  for (var i = 10; i < mocks.length; i++)
                    _MockListRow(
                      mock: mocks[i].mock,
                      locked: mocks[i].locked,
                      isLast: i == mocks.length - 1,
                    ),
                ],
              ),
            ),
          ],
        ],
      ],
    );
  }
}

class _MockListRow extends StatelessWidget {
  const _MockListRow({
    required this.mock,
    required this.isLast,
    this.locked = false,
  });
  final MockExam mock;
  final bool isLast;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    // Extract trailing number from the id ("t-mock-23") for the row label.
    final m = RegExp(r'(\d+)$').firstMatch(mock.id);
    final num = m == null ? '' : m.group(1)!;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: locked
            ? () => PaywallScreen.show(context,
                trigger: PaywallTrigger.mockLocked)
            : () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => MockPlayer(mock: mock)),
                ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            border: isLast
                ? null
                : Border(bottom: BorderSide(color: context.c.border)),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 28,
                child: Text(
                  num,
                  style: t.titleMedium?.copyWith(
                      color: context.c.textMuted, fontWeight: FontWeight.w700),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(mock.title,
                        style: t.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700, fontSize: 14)),
                    const SizedBox(height: 2),
                    Text(mock.theme,
                        style: t.bodySmall, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                locked ? Icons.lock_outline : Icons.play_arrow_rounded,
                color: locked ? context.c.textMuted : AppPalette.brandBlue,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MockCard extends StatelessWidget {
  const _MockCard({
    required this.mock,
    required this.index,
    this.locked = false,
  });
  final MockExam mock;
  final int index;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Opacity(
      opacity: locked ? 0.6 : 1,
      child: GlassCard(
      tint: locked ? null : GlassTints.forIndex(index + 1),
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconTile(
                  icon: locked
                      ? Icons.lock_outline
                      : Icons.dashboard_outlined,
                  size: 42),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(mock.title, style: t.titleLarge),
                    const SizedBox(height: 2),
                    Text('${mock.sections.length} SECTIONS · ${mock.minutes} MIN',
                        style: t.labelSmall),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            '${mock.theme}. Built to the Jan 21, 2026 test format: '
            '${mock.sections.map((s) => "${s.module} ${s.minutes}m").join(" → ")}.',
            style: t.bodyMedium,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final s in mock.sections) _SectionChip(label: '${s.module} · ${s.minutes}m'),
            ],
          ),
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.centerLeft,
            child: GlowButton(
              label: locked ? 'Unlock with Pro' : 'Start',
              icon: locked
                  ? Icons.lock_open_outlined
                  : Icons.play_arrow_rounded,
              onPressed: locked
                  ? () => PaywallScreen.show(context,
                      trigger: PaywallTrigger.mockLocked)
                  : () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => MockPlayer(mock: mock)),
                      ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}

class _SectionChip extends StatelessWidget {
  const _SectionChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: context.c.border),
      ),
      child: Text(label,
          style: TextStyle(
              color: context.c.text, fontSize: 13, fontWeight: FontWeight.w600)),
    );
  }
}
