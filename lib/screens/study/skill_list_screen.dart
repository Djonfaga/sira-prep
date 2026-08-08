import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/store.dart';
import '../../state/exam_mode.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_background.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/icon_tile.dart';
import 'listening_player.dart';
import 'reading_player.dart';
import 'speaking_player.dart';
import 'study_tab.dart' show StudyMode;
import 'writing_player.dart';

enum SkillKind { reading, listening, speaking, writing }

class SkillListScreen extends StatelessWidget {
  const SkillListScreen({super.key, required this.kind, required this.mode});
  final SkillKind kind;
  final StudyMode mode;

  String get _eyebrow {
    switch (kind) {
      case SkillKind.reading:
        return 'READING';
      case SkillKind.listening:
        return 'LISTENING';
      case SkillKind.speaking:
        return 'SPEAKING';
      case SkillKind.writing:
        return 'WRITING';
    }
  }

  IconData get _icon {
    switch (kind) {
      case SkillKind.reading:
        return Icons.menu_book_outlined;
      case SkillKind.listening:
        return Icons.headphones_outlined;
      case SkillKind.speaking:
        return Icons.mic_none_outlined;
      case SkillKind.writing:
        return Icons.edit_outlined;
    }
  }

  List<_Item> _items(BuildContext context) {
    final exam = context.read<ExamModeState>().exam;
    final c = contentFor(exam);
    switch (kind) {
      case SkillKind.reading:
        return c.reading
            .map((p) => _Item(
                  id: p.id,
                  title: p.title,
                  onOpen: (ctx) => Navigator.of(ctx).push(
                      MaterialPageRoute(builder: (_) => ReadingPlayer(passage: p))),
                ))
            .toList();
      case SkillKind.listening:
        return c.listening
            .map((l) => _Item(
                  id: l.id,
                  title: l.title,
                  onOpen: (ctx) => Navigator.of(ctx).push(
                      MaterialPageRoute(builder: (_) => ListeningPlayer(lecture: l))),
                ))
            .toList();
      case SkillKind.speaking:
        return c.speaking
            .map((s) => _Item(
                  id: s.id,
                  title: s.type,
                  onOpen: (ctx) => Navigator.of(ctx).push(
                      MaterialPageRoute(builder: (_) => SpeakingPlayer(task: s))),
                ))
            .toList();
      case SkillKind.writing:
        return c.writing
            .map((w) => _Item(
                  id: w.id,
                  title: w.type,
                  onOpen: (ctx) => Navigator.of(ctx).push(
                      MaterialPageRoute(builder: (_) => WritingPlayer(task: w))),
                ))
            .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final items = _items(context);
    return Scaffold(
      backgroundColor: context.c.bg,
      body: AppBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.maybePop(context),
                      icon: Icon(Icons.close_rounded,
                          color: context.c.text),
                    ),
                    const SizedBox(width: 4),
                    Text('Close', style: t.titleMedium),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Row(
                  children: [
                    Icon(_icon, color: AppPalette.brandBlue, size: 24),
                    const SizedBox(width: 8),
                    Text(_eyebrow, style: t.labelSmall),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                    '${items.length} ${items.length == 1 ? "ITEM" : "ITEMS"}',
                    style: t.labelSmall),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final item = items[i];
                    return GlassCard(
                      tint: GlassTints.forIndex(i),
                      onTap: () => item.onOpen(context),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      child: Row(
                        children: [
                          IconTile(icon: _icon, size: 42),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.title, style: t.titleMedium),
                                const SizedBox(height: 3),
                                Text('START EXERCISE',
                                    style: t.labelSmall),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_rounded,
                              color: context.c.textMuted, size: 20),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Item {
  _Item({required this.id, required this.title, required this.onOpen});
  final String id;
  final String title;
  final void Function(BuildContext) onOpen;
}
