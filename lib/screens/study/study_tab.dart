import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/store.dart';
import '../../state/exam_mode.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/icon_tile.dart';
import '../../widgets/section_header.dart';
import '../../widgets/segment_pills.dart';
import 'grammar_hub.dart';
import 'skill_list_screen.dart';
import 'vocab_hub.dart';

enum StudyMode { practice, learn }

class StudyTab extends StatefulWidget {
  const StudyTab({super.key});
  @override
  State<StudyTab> createState() => _StudyTabState();
}

class _StudyTabState extends State<StudyTab> {
  StudyMode _mode = StudyMode.practice;

  @override
  Widget build(BuildContext context) {
    final exam = context.watch<ExamModeState>().exam;
    final content = contentFor(exam);

    final tiles = <_StudyTile>[
      _StudyTile(
        title: 'Reading',
        sub: 'Passages and inference checks',
        icon: Icons.menu_book_outlined,
        count: '${content.reading.length}',
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) =>
                SkillListScreen(kind: SkillKind.reading, mode: _mode))),
      ),
      _StudyTile(
        title: 'Listening',
        sub: 'Lectures and conversations',
        icon: Icons.headphones_outlined,
        count: '${content.listening.length}',
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) =>
                SkillListScreen(kind: SkillKind.listening, mode: _mode))),
      ),
      _StudyTile(
        title: 'Speaking',
        sub: 'Paced short-response drills',
        icon: Icons.mic_none_outlined,
        count: '${content.speaking.length}',
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) =>
                SkillListScreen(kind: SkillKind.speaking, mode: _mode))),
      ),
      _StudyTile(
        title: 'Writing',
        sub: 'Discussion + Integrated tasks',
        icon: Icons.edit_outlined,
        count: '${content.writing.length}',
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) =>
                SkillListScreen(kind: SkillKind.writing, mode: _mode))),
      ),
      _StudyTile(
        title: 'Grammar',
        sub: 'Rule-by-rule drills',
        icon: Icons.text_fields_rounded,
        count: '${content.grammar.length}',
        onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const GrammarHub())),
      ),
      _StudyTile(
        title: 'Vocabulary',
        sub: 'Word card + spaced repetition',
        icon: Icons.translate_rounded,
        count: '${content.vocab.length}',
        onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const VocabHub())),
      ),
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
      children: [
        SectionHeader(
          eyebrow: exam.label,
          title: 'Study',
          subtitle:
              'Skill drills, vocabulary, and grammar — all on the same study route.',
        ),
        const SizedBox(height: 16),
        SegmentPills<StudyMode>(
          items: const [
            (value: StudyMode.practice, label: 'Practice'),
            (value: StudyMode.learn, label: 'Learn'),
          ],
          icons: const {
            StudyMode.practice: Icons.menu_book_outlined,
            StudyMode.learn: Icons.school_outlined,
          },
          selected: _mode,
          onChanged: (m) => setState(() => _mode = m),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.05,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: [for (final tile in tiles) _StudyCard(tile: tile)],
        ),
      ],
    );
  }
}

class _StudyTile {
  _StudyTile({
    required this.title,
    required this.sub,
    required this.icon,
    required this.count,
    required this.onTap,
  });
  final String title;
  final String sub;
  final IconData icon;
  final String count;
  final VoidCallback onTap;
}

class _StudyCard extends StatelessWidget {
  const _StudyCard({required this.tile});
  final _StudyTile tile;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return GlassCard(
      radius: 20,
      padding: const EdgeInsets.all(14),
      onTap: tile.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconTile(icon: tile.icon, size: 38),
              const Spacer(),
              Text(tile.count, style: t.bodySmall),
            ],
          ),
          const Spacer(),
          Text(tile.title, style: t.titleLarge?.copyWith(fontSize: 18)),
          const SizedBox(height: 4),
          Text(tile.sub,
              style: t.bodySmall, maxLines: 2, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
