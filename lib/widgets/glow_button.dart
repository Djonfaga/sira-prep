import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Bright blue gradient pill with a soft cyan halo glow.
/// Matches the "Start" / "Continue with Google" buttons in the screenshots.
class GlowButton extends StatelessWidget {
  const GlowButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.danger = false,
    this.expand = false,
    this.compact = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool danger;
  final bool expand;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null;
    final start = danger ? const Color(0xFFFF8585) : const Color(0xFFB7D3FF);
    final end = danger ? const Color(0xFFE45050) : AppPalette.brandBlue;
    final glow = danger ? AppPalette.accentDanger : AppPalette.brandBlue;
    final fg = danger ? Colors.white : const Color(0xFF0A1430);

    final inner = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 16 : 22,
        vertical: compact ? 10 : 14,
      ),
      child: Row(
        mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: compact ? 18 : 20, color: fg),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: TextStyle(
              color: fg,
              fontSize: compact ? 14 : 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );

    return Opacity(
      opacity: disabled ? 0.5 : 1,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          boxShadow: disabled
              ? []
              : [
                  BoxShadow(
                    color: glow.withOpacity(0.55),
                    blurRadius: 28,
                    spreadRadius: -4,
                  ),
                  BoxShadow(
                    color: glow.withOpacity(0.35),
                    blurRadius: 50,
                    spreadRadius: -10,
                  ),
                ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(999),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(999),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [start, end],
                ),
              ),
              child: inner,
            ),
          ),
        ),
      ),
    );
  }
}
