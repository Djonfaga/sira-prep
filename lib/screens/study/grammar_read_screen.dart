import 'package:flutter/material.dart';

import '../../data/grammar_guide.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_background.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/grammar_visuals.dart';
import '../../widgets/icon_tile.dart';

/// List of grammar reference topics. Tapping a card pushes the detail view.
class GrammarReadList extends StatelessWidget {
  const GrammarReadList({super.key});

  IconData _iconFor(String section) {
    switch (section) {
      case 'Verbs':
        return Icons.bolt_outlined;
      case 'Mood & modality':
        return Icons.psychology_outlined;
      case 'Clauses':
        return Icons.account_tree_outlined;
      case 'Noun phrase':
        return Icons.label_outline;
      case 'Word order':
        return Icons.linear_scale_rounded;
      case 'Style & structure':
        return Icons.format_align_left_rounded;
      case 'Cohesion':
        return Icons.link_rounded;
      case 'Mechanics':
        return Icons.format_quote_rounded;
    }
    return Icons.menu_book_outlined;
  }

  @override
  Widget build(BuildContext context) {
    // Group topics by section so the list is scannable.
    final bySection = <String, List<GrammarTopic>>{};
    for (final t in grammarGuide) {
      bySection.putIfAbsent(t.section, () => []).add(t);
    }
    final sections = bySection.keys.toList();

    final theme = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
      children: [
        GlassCard(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const IconTile(icon: Icons.menu_book_outlined, size: 40),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('GRAMMAR REFERENCE',
                        style: theme.labelSmall?.copyWith(letterSpacing: 1.2)),
                    const SizedBox(height: 4),
                    Text(
                      '${grammarGuide.length} core topics with examples, '
                      'diagrams, and source citations.',
                      style: theme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        for (final section in sections) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 0, 8),
            child: Text(section.toUpperCase(),
                style: theme.labelSmall?.copyWith(letterSpacing: 1.4)),
          ),
          for (final topic in bySection[section]!) ...[
            _TopicCard(topic: topic, icon: _iconFor(section)),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 6),
        ],
      ],
    );
  }
}

class _TopicCard extends StatelessWidget {
  const _TopicCard({required this.topic, required this.icon});
  final GrammarTopic topic;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => GrammarTopicScreen(topic: topic)),
      ),
      child: Row(
        children: [
          IconTile(icon: icon, size: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(topic.title,
                    style:
                        t.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(
                  topic.summary,
                  style: t.bodySmall,
                  maxLines: 2,
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

// ── Topic detail ─────────────────────────────────────────────────────────
class GrammarTopicScreen extends StatelessWidget {
  const GrammarTopicScreen({super.key, required this.topic});
  final GrammarTopic topic;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: context.c.bg,
      body: AppBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 6, 16, 0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon:
                          Icon(Icons.close_rounded, color: context.c.text),
                    ),
                    Text('Close', style: t.titleMedium),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                  children: [
                    Text(topic.section.toUpperCase(),
                        style: t.labelSmall?.copyWith(letterSpacing: 1.4)),
                    const SizedBox(height: 4),
                    Text(topic.title, style: t.displayMedium),
                    const SizedBox(height: 12),
                    Text(topic.summary,
                        style: t.bodyLarge?.copyWith(
                            color: context.c.textMuted, height: 1.55)),
                    const SizedBox(height: 18),
                    for (final rule in topic.rules) ...[
                      _RuleSection(rule: rule),
                      const SizedBox(height: 18),
                    ],
                    const SizedBox(height: 4),
                    GlassCard(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.bookmark_border,
                                  color: AppPalette.brandBlue, size: 18),
                              const SizedBox(width: 6),
                              Text('SOURCES',
                                  style: t.labelSmall?.copyWith(
                                      letterSpacing: 1.4)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          for (final src in topic.sources) ...[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Text('· $src',
                                  style: t.bodySmall?.copyWith(height: 1.45)),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RuleSection extends StatelessWidget {
  const _RuleSection({required this.rule});
  final GrammarRule rule;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(rule.title,
              style: t.titleLarge?.copyWith(
                  fontSize: 17, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Text(rule.explanation,
              style: t.bodyMedium?.copyWith(height: 1.55, fontSize: 14)),
          if (rule.visual != GrammarVisual.none) ...[
            const SizedBox(height: 14),
            GrammarVisualWidget(kind: rule.visual),
          ],
          if (rule.examples.isNotEmpty) ...[
            const SizedBox(height: 14),
            for (final ex in rule.examples) ...[
              _ExampleLine(example: ex),
              const SizedBox(height: 8),
            ],
          ],
        ],
      ),
    );
  }
}

class _ExampleLine extends StatelessWidget {
  const _ExampleLine({required this.example});
  final GrammarExample example;
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final color = example.correct
        ? AppPalette.accentSuccess
        : AppPalette.accentDanger;
    final icon = example.correct
        ? Icons.check_circle_outline
        : Icons.cancel_outlined;
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        border: Border.all(color: color.withOpacity(0.45)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(example.text,
                    style: TextStyle(
                        color: context.c.text,
                        fontSize: 14,
                        height: 1.45,
                        fontStyle: example.correct
                            ? FontStyle.normal
                            : FontStyle.italic)),
                if (example.note != null) ...[
                  const SizedBox(height: 4),
                  Text(example.note!,
                      style: t.bodySmall?.copyWith(
                          color: context.c.textMuted, height: 1.4)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
