import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/store.dart';
import '../../state/exam_mode.dart';
import '../../state/user_state.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';
import '../study/skill_list_screen.dart';
import '../study/study_tab.dart' show StudyMode;

/// Dense, single-screen insights for the active exam. The intent is "open the
/// app and immediately understand where you stand and what to do next" — so
/// the screen avoids vertical scrolling and prioritizes per-skill scores,
/// trend deltas, and a single suggested next action.
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final exam = context.watch<ExamModeState>().exam;
    final user = context.watch<UserState>();
    final content = contentFor(exam);
    final insights =
        user.insightsFor(exam, vocabDeckSize: content.vocab.length);

    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _GreetingLine(exam: exam, name: user.name),
            const SizedBox(height: 8),
            _ProjectedHeroCard(insights: insights),
            const SizedBox(height: 8),
            _SectionGrid(insights: insights),
            const SizedBox(height: 8),
            _VocabGrammarRow(insights: insights),
            const SizedBox(height: 8),
            _StreakStrip(insights: insights),
            const SizedBox(height: 8),
            _FocusActionCard(insights: insights),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

// ── Header line ───────────────────────────────────────────────────────────
class _GreetingLine extends StatelessWidget {
  const _GreetingLine({required this.exam, required this.name});
  final Exam exam;
  final String name;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final firstName =
        name.trim().isEmpty ? 'Scholar' : name.trim().split(' ').first;
    return Row(
      children: [
        Text(exam.label, style: t.labelSmall),
        const SizedBox(width: 8),
        Container(width: 2, height: 10, color: context.c.borderStrong),
        const SizedBox(width: 8),
        Expanded(
          child: Text('Hi, $firstName.', style: t.titleLarge),
        ),
      ],
    );
  }
}

// ── Hero projected score ─────────────────────────────────────────────────
class _ProjectedHeroCard extends StatelessWidget {
  const _ProjectedHeroCard({required this.insights});
  final ExamInsights insights;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final pct = (insights.projected / insights.projectedMax).clamp(0.0, 1.0);
    final delta = insights.projectedDelta;
    final deltaText = delta.abs() < 0.5
        ? '— no trend yet, finish a few exercises'
        : (delta > 0
            ? '↑ +${delta.toStringAsFixed(1)} since you started'
            : '↓ ${delta.toStringAsFixed(1)} since you started');

    return GlassCard(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                insights.exam == Exam.ielts
                    ? 'PROJECTED BAND'
                    : 'PROJECTED SCORE',
                style: t.labelSmall,
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    insights.projectedLabel,
                    style: t.displayLarge?.copyWith(
                      fontSize: 44,
                      color: AppPalette.brandBlue,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    ' / ${insights.projectedMaxLabel}',
                    style: t.titleMedium?.copyWith(color: context.c.textMuted),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(deltaText, style: t.bodySmall),
            ],
          ),
          const Spacer(),
          SizedBox(width: 86, height: 86, child: _CircularGauge(value: pct)),
        ],
      ),
    );
  }
}

class _CircularGauge extends StatelessWidget {
  const _CircularGauge({required this.value});
  final double value;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox.expand(
          child: CircularProgressIndicator(
            value: 1,
            strokeWidth: 6,
            color: context.c.border,
            backgroundColor: Colors.transparent,
          ),
        ),
        SizedBox.expand(
          child: CircularProgressIndicator(
            value: value,
            strokeWidth: 6,
            color: AppPalette.brandBlue,
            strokeCap: StrokeCap.round,
            backgroundColor: Colors.transparent,
          ),
        ),
        Text(
          '${(value * 100).round()}%',
          style: TextStyle(
              color: context.c.text,
              fontWeight: FontWeight.w800,
              fontSize: 15),
        ),
      ],
    );
  }
}

// ── 2×2 section grid ──────────────────────────────────────────────────────
class _SectionGrid extends StatelessWidget {
  const _SectionGrid({required this.insights});
  final ExamInsights insights;

  static const _cells = <_SectionCell>[
    _SectionCell(
      module: 'reading',
      label: 'Reading',
      icon: Icons.menu_book_outlined,
      kind: SkillKind.reading,
    ),
    _SectionCell(
      module: 'listening',
      label: 'Listening',
      icon: Icons.headphones_outlined,
      kind: SkillKind.listening,
    ),
    _SectionCell(
      module: 'speaking',
      label: 'Speaking',
      icon: Icons.mic_none_outlined,
      kind: SkillKind.speaking,
    ),
    _SectionCell(
      module: 'writing',
      label: 'Writing',
      icon: Icons.edit_outlined,
      kind: SkillKind.writing,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 1.55,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        for (final cell in _cells) _SectionTile(cell: cell, insights: insights),
      ],
    );
  }
}

class _SectionCell {
  const _SectionCell({
    required this.module,
    required this.label,
    required this.icon,
    required this.kind,
  });
  final String module;
  final String label;
  final IconData icon;
  final SkillKind kind;
}

class _SectionTile extends StatelessWidget {
  const _SectionTile({required this.cell, required this.insights});
  final _SectionCell cell;
  final ExamInsights insights;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final attempts = insights.sectionAttempts[cell.module] ?? 0;
    final delta = insights.sectionDeltas[cell.module] ?? 0;
    final pct = ((insights.sectionScores[cell.module] ?? 0) /
            (insights.projectedMax / 4))
        .clamp(0.0, 1.0);

    return GlassCard(
      radius: 18,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => SkillListScreen(
            kind: cell.kind,
            mode: StudyMode.practice,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(cell.icon, color: AppPalette.brandBlue, size: 16),
              const SizedBox(width: 6),
              Text(cell.label,
                  style: t.labelSmall?.copyWith(letterSpacing: 1)),
              const Spacer(),
              if (delta.abs() > 0.5)
                Text(
                  delta > 0
                      ? '↑${delta.toStringAsFixed(1)}'
                      : '↓${(-delta).toStringAsFixed(1)}',
                  style: t.bodySmall?.copyWith(
                    color: delta > 0
                        ? AppPalette.accentSuccess
                        : AppPalette.accentDanger,
                    fontWeight: FontWeight.w700,
                  ),
                ),
            ],
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                insights.sectionLabel(cell.module),
                style: TextStyle(
                  color: context.c.text,
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                  height: 1,
                ),
              ),
              const SizedBox(width: 2),
              Text(
                ' / ${insights.exam == Exam.ielts ? "9" : "30"}',
                style: t.bodySmall?.copyWith(color: context.c.textFaint),
              ),
              const Spacer(),
              Text(
                '$attempts ${attempts == 1 ? "try" : "tries"}',
                style: t.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: pct,
              minHeight: 4,
              backgroundColor: context.c.border,
              valueColor:
                  const AlwaysStoppedAnimation(AppPalette.brandBlue),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Vocab + Grammar row ───────────────────────────────────────────────────
class _VocabGrammarRow extends StatelessWidget {
  const _VocabGrammarRow({required this.insights});
  final ExamInsights insights;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
          child: GlassCard(
            radius: 18,
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
            child: _StatBlock(
              icon: Icons.translate_rounded,
              label: 'VOCAB LEARNED',
              value: '${insights.vocabLearned}',
              caption: 'of ${insights.vocabTotal}',
              barValue: insights.vocabTotal == 0
                  ? 0
                  : (insights.vocabLearned / insights.vocabTotal)
                      .clamp(0.0, 1.0),
              t: t,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: GlassCard(
            radius: 18,
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
            child: _StatBlock(
              icon: Icons.text_fields_rounded,
              label: 'GRAMMAR',
              value: insights.grammarAccuracy == null
                  ? '—'
                  : '${insights.grammarAccuracy!.round()}%',
              caption: insights.grammarAccuracy == null
                  ? 'no drills yet'
                  : 'recent accuracy',
              barValue: (insights.grammarAccuracy ?? 0) / 100,
              t: t,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatBlock extends StatelessWidget {
  const _StatBlock({
    required this.icon,
    required this.label,
    required this.value,
    required this.caption,
    required this.barValue,
    required this.t,
  });
  final IconData icon;
  final String label;
  final String value;
  final String caption;
  final double barValue;
  final TextTheme t;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Icon(icon, color: AppPalette.brandBlue, size: 16),
            const SizedBox(width: 6),
            Text(label, style: t.labelSmall?.copyWith(letterSpacing: 1)),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: TextStyle(
                color: context.c.text,
                fontWeight: FontWeight.w800,
                fontSize: 20,
                height: 1,
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                caption,
                style: t.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: barValue,
            minHeight: 4,
            backgroundColor: context.c.border,
            valueColor:
                const AlwaysStoppedAnimation(AppPalette.brandBlue),
          ),
        ),
      ],
    );
  }
}

// ── Streak / Hours / Attempts strip ───────────────────────────────────────
class _StreakStrip extends StatelessWidget {
  const _StreakStrip({required this.insights});
  final ExamInsights insights;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    Widget chip({
      required IconData icon,
      required Color color,
      required String value,
      required String label,
    }) {
      return Expanded(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 6),
            Text(value,
                style: t.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(width: 4),
            Flexible(
              child: Text(label,
                  style: t.bodySmall, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      );
    }

    final h = insights.hoursPracticed;
    return GlassCard(
      radius: 18,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      child: Row(
        children: [
          chip(
            icon: Icons.local_fire_department_rounded,
            color: AppPalette.accentWarn,
            value: '${insights.dayStreak}',
            label: 'day streak',
          ),
          chip(
            icon: Icons.access_time_rounded,
            color: AppPalette.brandBlue,
            value: '${h.toStringAsFixed(h < 10 ? 1 : 0)}h',
            label: 'practiced',
          ),
          chip(
            icon: Icons.task_alt_rounded,
            color: AppPalette.accentSuccess,
            value: '${insights.totalAttempts}',
            label: 'attempts',
          ),
        ],
      ),
    );
  }
}

// ── Focus + suggested next action ─────────────────────────────────────────
class _FocusActionCard extends StatelessWidget {
  const _FocusActionCard({required this.insights});
  final ExamInsights insights;

  SkillKind get _kindForFocus {
    switch (insights.focusArea.toLowerCase()) {
      case 'listening':
        return SkillKind.listening;
      case 'speaking':
        return SkillKind.speaking;
      case 'writing':
        return SkillKind.writing;
      default:
        return SkillKind.reading;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return GlassCard(
      radius: 18,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => SkillListScreen(
            kind: _kindForFocus,
            mode: StudyMode.practice,
          ),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.flag_rounded,
              color: AppPalette.accentSira, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text('FOCUS AREA',
                        style: t.labelSmall?.copyWith(
                            color: AppPalette.accentSira, letterSpacing: 1)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(insights.focusArea,
                          style: t.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(insights.focusReason,
                    style: t.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.arrow_forward_rounded,
              color: context.c.textMuted, size: 18),
        ],
      ),
    );
  }
}
