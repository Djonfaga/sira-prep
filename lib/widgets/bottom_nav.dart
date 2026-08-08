import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

enum NavTab { home, sira, mocks, study }

extension NavTabX on NavTab {
  String get label => switch (this) {
        NavTab.home => 'Home',
        NavTab.sira => 'Sira',
        NavTab.mocks => 'Mocks',
        NavTab.study => 'Study',
      };

  IconData get icon => switch (this) {
        NavTab.home => Icons.explore_outlined,
        NavTab.sira => Icons.auto_awesome_outlined,
        NavTab.mocks => Icons.adjust_rounded,
        NavTab.study => Icons.school_outlined,
      };
}

/// Floating bottom navigation pill with 4 tabs. The active tab gets a darker
/// glass well with a thin border. Adapts to the active theme.
class BottomNav extends StatelessWidget {
  const BottomNav({super.key, required this.current, required this.onChanged});

  final NavTab current;
  final ValueChanged<NavTab> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final shape = BorderRadius.circular(28);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: ClipRRect(
          borderRadius: shape,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                borderRadius: shape,
                color: c.glassFillStrong,
                border: Border.all(color: c.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.5 : 0.1),
                    blurRadius: 30,
                    offset: const Offset(0, 18),
                    spreadRadius: -8,
                  ),
                ],
              ),
              child: Row(
                children: [
                  for (final tab in NavTab.values)
                    Expanded(
                      child: _NavSlot(
                        tab: tab,
                        active: tab == current,
                        onTap: () => onChanged(tab),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavSlot extends StatelessWidget {
  const _NavSlot({required this.tab, required this.active, required this.onTap});

  final NavTab tab;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final shape = BorderRadius.circular(20);
    final fg = active ? c.text : c.textMuted;
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Material(
        color: Colors.transparent,
        borderRadius: shape,
        child: InkWell(
          onTap: onTap,
          borderRadius: shape,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              borderRadius: shape,
              color: active ? c.bg.withOpacity(0.55) : Colors.transparent,
              border: Border.all(
                color: active ? c.borderStrong : Colors.transparent,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(tab.icon, color: fg, size: 22),
                const SizedBox(height: 4),
                Text(
                  tab.label,
                  style: TextStyle(
                    color: fg,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
