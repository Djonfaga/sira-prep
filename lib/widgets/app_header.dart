import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/paywall_screen.dart';
import '../state/entitlements.dart';
import '../theme/app_theme.dart';

/// Floating header pill: [hamburger | logo + "Sira Prep"].
///
/// The TOEFL/IELTS switch lives only in Settings — switching exam is rare and
/// shouldn't take persistent header real-estate.
class AppHeader extends StatelessWidget {
  const AppHeader({super.key, this.onMenu});

  final VoidCallback? onMenu;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final shape = BorderRadius.circular(999);

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
        child: Row(
          children: [
            _CircleButton(icon: Icons.menu_rounded, onTap: onMenu),
            const SizedBox(width: 10),
            Expanded(
              child: ClipRRect(
                borderRadius: shape,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: shape,
                      color: c.glassFillStrong,
                      border: Border.all(color: c.border),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          const _LogoBadge(),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Sira Prep',
                              style: TextStyle(
                                color: c.text,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.3,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const _StatusPill(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Free users see hearts remaining; Pro users see a PRO badge instead. Tapping
/// either opens the paywall, which doubles as the "what am I on?" screen.
class _StatusPill extends StatelessWidget {
  const _StatusPill();

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final ent = context.watch<Entitlements>();
    final pro = ent.isPro;
    final hearts = ent.heartsRemaining;
    final empty = !pro && hearts == 0;
    final accent = pro
        ? AppPalette.accentSira
        : empty
            ? c.textMuted
            : AppPalette.accentDanger;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: () => PaywallScreen.show(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: accent.withValues(alpha: 0.14),
            border: Border.all(color: accent.withValues(alpha: 0.45)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                pro ? Icons.workspace_premium_outlined : Icons.favorite_rounded,
                size: 15,
                color: accent,
              ),
              const SizedBox(width: 5),
              Text(
                pro ? 'PRO' : '$hearts',
                style: TextStyle(
                  color: accent,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Material(
          color: c.glassFillStrong,
          shape: CircleBorder(side: BorderSide(color: c.border)),
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: SizedBox(
              width: 44,
              height: 44,
              child: Icon(Icons.menu_rounded, color: c.text, size: 20),
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoBadge extends StatelessWidget {
  const _LogoBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFB7D3FF), AppPalette.brandBlue],
        ),
        boxShadow: [
          BoxShadow(
            color: AppPalette.brandBlue.withValues(alpha: 0.45),
            blurRadius: 14,
            spreadRadius: -2,
          ),
        ],
        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/icon.png', fit: BoxFit.cover),
      ),
    );
  }
}
