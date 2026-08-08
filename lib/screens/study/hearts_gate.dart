import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/entitlements.dart';
import '../paywall_screen.dart';

/// Shared heart accounting for the immediate-feedback drills.
///
/// Only Grammar and Vocabulary use this. The Reading, Listening, Speaking,
/// Writing and Mock players are timed exam simulations: they withhold grading
/// until the end by design, so there is no moment at which a heart could
/// honestly be spent, and interrupting a timed section would corrupt the score
/// the student is trying to track. Hearts gate practice, never a simulated exam.
abstract final class HeartsGate {
  /// Records one graded answer against the free tier's allowance.
  ///
  /// Returns true when the session may continue, false when the student has
  /// just run out of hearts — in which case the paywall has already been shown
  /// and the caller should end the session.
  static Future<bool> registerAnswer(
    BuildContext context, {
    required bool correct,
  }) async {
    final ent = context.read<Entitlements>();
    if (ent.isPro) return true;

    if (correct) {
      ent.registerCorrectAnswer();
      return true;
    }

    ent.loseHeart();
    if (ent.hasHearts) return true;

    if (!context.mounted) return false;
    await PaywallScreen.show(context, trigger: PaywallTrigger.heartsEmpty);
    // Upgrading during the paywall restores the session rather than ending it.
    return ent.hasHearts;
  }
}
