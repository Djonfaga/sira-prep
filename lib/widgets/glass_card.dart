import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Translucent surface with a subtle 1-px border and an optional radial tint.
/// Reads color tokens from the active theme so it looks correct in both light
/// and dark mode.
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.radius = 22,
    this.tint,
    this.onTap,
    this.borderColor,
    this.tintAlignment = Alignment.center,
    this.height,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;

  final Color? tint;
  final Alignment tintAlignment;
  final Color? borderColor;
  final double? height;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final radii = BorderRadius.circular(radius);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final content = Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: radii,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: const SizedBox.shrink(),
            ),
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: radii,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        Colors.white.withOpacity(0.05),
                        Colors.white.withOpacity(0.015),
                      ]
                    : [
                        Colors.white.withOpacity(0.85),
                        Colors.white.withOpacity(0.55),
                      ],
              ),
            ),
          ),
        ),
        if (tint != null && tint!.alpha > 0)
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: radii,
                  gradient: RadialGradient(
                    center: tintAlignment,
                    radius: 1.1,
                    colors: [tint!, tint!.withOpacity(0)],
                  ),
                ),
              ),
            ),
          ),
        Padding(padding: padding, child: child),
      ],
    );

    final card = Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: radii,
        border: Border.all(color: borderColor ?? c.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.45 : 0.08),
            blurRadius: 30,
            offset: const Offset(0, 18),
            spreadRadius: -8,
          ),
        ],
      ),
      child: ClipRRect(borderRadius: radii, child: content),
    );

    if (onTap == null) return card;

    return Material(
      color: Colors.transparent,
      borderRadius: radii,
      child: InkWell(
        onTap: onTap,
        borderRadius: radii,
        splashColor: (isDark ? Colors.white : Colors.black).withOpacity(0.04),
        highlightColor: (isDark ? Colors.white : Colors.black).withOpacity(0.02),
        child: card,
      ),
    );
  }
}
