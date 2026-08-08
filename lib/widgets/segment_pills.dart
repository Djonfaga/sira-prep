import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Segmented pill control — used for TOEFL/IELTS, Practice/Learn, To-Do/Done,
/// Match system/Dark/Light. Selected item gets a slightly darker glass disc
/// with a thin border; colors swap with the theme.
class SegmentPills<T> extends StatelessWidget {
  const SegmentPills({
    super.key,
    required this.items,
    required this.selected,
    required this.onChanged,
    this.icons,
    this.spacing = 6,
  });

  final List<({T value, String label})> items;
  final T selected;
  final ValueChanged<T> onChanged;
  final Map<T, IconData>? icons;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final item in items) ...[
          _Pill(
            label: item.label,
            icon: icons?[item.value],
            selected: item.value == selected,
            onTap: () => onChanged(item.value),
          ),
          if (item != items.last) SizedBox(width: spacing),
        ]
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final shape = BorderRadius.circular(999);
    return Material(
      color: Colors.transparent,
      borderRadius: shape,
      child: InkWell(
        onTap: onTap,
        borderRadius: shape,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          decoration: BoxDecoration(
            borderRadius: shape,
            color: selected ? c.bg.withOpacity(0.55) : Colors.transparent,
            border: Border.all(
              color: selected ? c.borderStrong : Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 16,
                  color: selected ? c.text : c.textMuted,
                ),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: selected ? c.text : c.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
