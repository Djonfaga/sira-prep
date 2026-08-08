import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Rounded square holding an outline icon — matches the small accent tiles
/// found inside cards (book, headphones, mic, edit, shield, etc.).
class IconTile extends StatelessWidget {
  const IconTile({
    super.key,
    required this.icon,
    this.color = AppPalette.brandBlue,
    this.size = 44,
    this.iconScale = 0.55,
  });

  final IconData icon;
  final Color color;
  final double size;
  final double iconScale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(size * 0.28),
        border: Border.all(color: color.withValues(alpha: 0.28), width: 1),
      ),
      child: Icon(icon, color: color, size: size * iconScale),
    );
  }
}
