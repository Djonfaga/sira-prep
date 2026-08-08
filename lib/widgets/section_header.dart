import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Small caps eyebrow + large display title + optional subtitle.
/// Used at the top of every primary screen.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
  });

  final String eyebrow;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final c = context.c;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(eyebrow.toUpperCase(), style: t.labelSmall),
        const SizedBox(height: 6),
        Text(title, style: t.displayMedium),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(subtitle!, style: t.bodyLarge?.copyWith(color: c.textMuted)),
        ],
      ],
    );
  }
}
