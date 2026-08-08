import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Neutral backdrop that adapts to the active theme — no colored radial
/// washes, so the only "liquid" feeling comes from the glass surfaces drawn
/// on top of it.
class AppBackground extends StatelessWidget {
  const AppBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        Positioned.fill(child: ColoredBox(color: c.bg)),
        // Very faint top-to-bottom shading so the glass surfaces have something
        // to refract against, in both light and dark.
        Positioned.fill(
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    (isDark ? Colors.white : Colors.black).withOpacity(0.02),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
