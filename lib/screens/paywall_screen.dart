import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';

import '../state/billing.dart';
import '../state/entitlements.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';
import '../widgets/glass_card.dart';

/// Why the student hit the paywall. Framing the offer around the thing they
/// were just trying to do converts far better than a generic upgrade pitch.
enum PaywallTrigger {
  general,
  contentLocked,
  mockLocked,
  heartsEmpty,
  aiLimit,
}

extension on PaywallTrigger {
  String get headline => switch (this) {
        PaywallTrigger.general => 'Go further with Pro',
        PaywallTrigger.contentLocked => 'You have finished the free practice',
        PaywallTrigger.mockLocked => 'Unlock every mock exam',
        PaywallTrigger.heartsEmpty => 'Out of hearts for today',
        PaywallTrigger.aiLimit => 'You have used your free AI messages',
      };

  String get sub => switch (this) {
        PaywallTrigger.general =>
          'Unlock the full question bank, every mock exam, and unlimited '
              'coaching.',
        PaywallTrigger.contentLocked =>
          'Free study gives you the first ${FreeTier.itemsPerSkill} items in '
              'every skill. Pro opens the rest of the bank.',
        PaywallTrigger.mockLocked =>
          'Your free full-length mock is done. Pro opens every remaining timed '
              'exam so you can track a real score trend.',
        PaywallTrigger.heartsEmpty =>
          'Free practice gives you ${FreeTier.dailyHearts} hearts a day. They '
              'come back tomorrow, or answer '
              '${FreeTier.correctAnswersForHeartRefill} questions correctly to '
              'refill them now.',
        PaywallTrigger.aiLimit =>
          'Keep working through your weak areas with Sira, your AI coach.',
      };
}

class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key, this.trigger = PaywallTrigger.general});

  final PaywallTrigger trigger;

  static Future<void> show(
    BuildContext context, {
    PaywallTrigger trigger = PaywallTrigger.general,
  }) {
    return Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => PaywallScreen(trigger: trigger),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final billing = context.watch<BillingService>();

    return Scaffold(
      backgroundColor: context.c.bg,
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.close_rounded, color: context.c.textMuted),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                  children: [
                    const _ProBadge(),
                    const SizedBox(height: 20),
                    Text(
                      trigger.headline,
                      textAlign: TextAlign.center,
                      style: t.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      trigger.sub,
                      textAlign: TextAlign.center,
                      style: t.bodyMedium?.copyWith(height: 1.4),
                    ),
                    const SizedBox(height: 24),
                    const _Benefits(),
                    const SizedBox(height: 24),
                    if (billing.isLoading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: CircularProgressIndicator(
                              color: AppPalette.brandBlue),
                        ),
                      )
                    else if (!billing.isAvailable)
                      const _Unavailable()
                    else
                      const _Plans(),
                    if (billing.error != null) ...[
                      const SizedBox(height: 14),
                      Text(
                        billing.error!,
                        textAlign: TextAlign.center,
                        style: t.bodySmall
                            ?.copyWith(color: AppPalette.accentDanger),
                      ),
                    ],
                    const SizedBox(height: 12),
                    Center(
                      child: TextButton(
                        onPressed: billing.purchasePending
                            ? null
                            : () => context.read<BillingService>().restore(),
                        child: const Text(
                          'Restore purchases',
                          style: TextStyle(color: AppPalette.brandBlue),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Subscriptions renew automatically until cancelled. You '
                      'can cancel any time in Google Play. The lifetime unlock '
                      'is a single payment.',
                      textAlign: TextAlign.center,
                      style: t.labelSmall?.copyWith(
                        color: context.c.textFaint,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProBadge extends StatelessWidget {
  const _ProBadge();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 84,
        height: 84,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppPalette.brandBlue, AppPalette.accentSira],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppPalette.brandBlue.withValues(alpha: 0.35),
              blurRadius: 26,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: const Text(
          'PRO',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 22,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}

class _Benefits extends StatelessWidget {
  const _Benefits();

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    // Every claim here must be something the app actually does today. A paid
    // tier that advertises a feature which does not exist is both dishonest and
    // a Play policy problem.
    const items = <(IconData, String, String)>[
      (
        Icons.library_books_outlined,
        'The whole question bank',
        'Every reading passage, lecture, speaking and writing task — not just '
            'the first few.',
      ),
      (
        Icons.timer_outlined,
        'Every full-length mock',
        'All timed exams, so you can watch a real score trend instead of one '
            'data point.',
      ),
      (
        Icons.favorite_rounded,
        'Unlimited practice',
        'No hearts, no daily ceiling. Drill for as long as you want.',
      ),
      (
        Icons.auto_awesome_outlined,
        'Unlimited Sira coaching',
        'Ask your AI coach as much as you need, with no message cap.',
      ),
    ];

    return Column(
      children: [
        for (final (icon, title, body) in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppPalette.brandBlue.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(icon, color: AppPalette.brandBlue, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: t.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 2),
                      Text(body, style: t.bodySmall?.copyWith(height: 1.35)),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Plans extends StatelessWidget {
  const _Plans();

  @override
  Widget build(BuildContext context) {
    final billing = context.watch<BillingService>();

    final yearly = billing.productFor(ProProducts.yearly);
    final monthly = billing.productFor(ProProducts.monthly);
    final lifetime = billing.productFor(ProProducts.lifetime);

    if (yearly == null && monthly == null && lifetime == null) {
      return const _Unavailable();
    }

    return Column(
      children: [
        if (yearly != null)
          _PlanTile(
            product: yearly,
            label: 'Yearly',
            caption: 'Best value for a full prep cycle',
            highlighted: true,
          ),
        if (monthly != null)
          _PlanTile(
            product: monthly,
            label: 'Monthly',
            caption: 'Try it for a month',
          ),
        if (lifetime != null)
          _PlanTile(
            product: lifetime,
            label: 'Lifetime',
            caption: 'One payment, yours forever',
          ),
      ],
    );
  }
}

class _PlanTile extends StatelessWidget {
  const _PlanTile({
    required this.product,
    required this.label,
    required this.caption,
    this.highlighted = false,
  });

  final ProductDetails product;
  final String label;
  final String caption;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final billing = context.watch<BillingService>();
    final pending = billing.purchasePending;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        onTap: pending ? null : () => context.read<BillingService>().buy(product.id),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        label,
                        style: t.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      if (highlighted) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color:
                                AppPalette.accentSuccess.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            'BEST VALUE',
                            style: t.labelSmall?.copyWith(
                              color: AppPalette.accentSuccess,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(caption, style: t.bodySmall),
                ],
              ),
            ),
            if (pending)
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                    strokeWidth: 2.2, color: AppPalette.brandBlue),
              )
            else
              Text(
                // Price comes from Play, already localised to the user's store
                // country and currency — never hardcode it.
                product.price,
                style: t.titleMedium?.copyWith(
                  color: AppPalette.brandBlue,
                  fontWeight: FontWeight.w900,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Unavailable extends StatelessWidget {
  const _Unavailable();

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return GlassCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Icon(Icons.storefront_outlined,
              color: context.c.textFaint, size: 30),
          const SizedBox(height: 10),
          Text(
            'Plans are not available on this device right now.',
            textAlign: TextAlign.center,
            style: t.bodyMedium,
          ),
          const SizedBox(height: 6),
          Text(
            'Everything you have already unlocked stays free to use.',
            textAlign: TextAlign.center,
            style: t.bodySmall?.copyWith(color: context.c.textFaint),
          ),
        ],
      ),
    );
  }
}
