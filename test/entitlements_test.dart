import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toeflsix/state/entitlements.dart';

/// The free tier is the product's revenue model, so its boundaries are worth
/// pinning down. Every test here describes a rule a paying or non-paying user
/// would actually notice.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Entitlements ent;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    ent = Entitlements(prefs)..load();
  });

  group('content gating', () {
    test('free users get the first N items of each skill and no more', () {
      expect(ent.canAccessSkillItem(0), isTrue);
      expect(ent.canAccessSkillItem(FreeTier.itemsPerSkill - 1), isTrue);
      expect(ent.canAccessSkillItem(FreeTier.itemsPerSkill), isFalse);
      expect(ent.canAccessSkillItem(29), isFalse);
    });

    test('free users get one vocab set, one grammar set, one mock', () {
      expect(ent.canAccessVocabSet(0), isTrue);
      expect(ent.canAccessVocabSet(1), isFalse);
      expect(ent.canAccessGrammarSet(0), isTrue);
      expect(ent.canAccessGrammarSet(1), isFalse);
      expect(ent.canAccessMock(0), isTrue);
      expect(ent.canAccessMock(1), isFalse);
    });

    test('Pro unlocks every module', () {
      ent.setPro(true, source: ProProducts.yearly);
      expect(ent.canAccessSkillItem(999), isTrue);
      expect(ent.canAccessVocabSet(999), isTrue);
      expect(ent.canAccessGrammarSet(999), isTrue);
      expect(ent.canAccessMock(999), isTrue);
    });
  });

  group('hearts', () {
    test('a wrong answer costs a heart and zero blocks practice', () {
      expect(ent.heartsRemaining, FreeTier.dailyHearts);
      for (var i = 0; i < FreeTier.dailyHearts; i++) {
        expect(ent.hasHearts, isTrue);
        ent.loseHeart();
      }
      expect(ent.heartsRemaining, 0);
      expect(ent.hasHearts, isFalse);
    });

    test('hearts never go negative', () {
      for (var i = 0; i < FreeTier.dailyHearts + 5; i++) {
        ent.loseHeart();
      }
      expect(ent.heartsRemaining, 0);
    });

    test('enough correct answers refill hearts, so free users are never '
        'hard-blocked', () {
      for (var i = 0; i < FreeTier.dailyHearts; i++) {
        ent.loseHeart();
      }
      expect(ent.hasHearts, isFalse);

      for (var i = 0; i < FreeTier.correctAnswersForHeartRefill - 1; i++) {
        ent.registerCorrectAnswer();
      }
      expect(ent.hasHearts, isFalse, reason: 'not yet at the threshold');

      ent.registerCorrectAnswer();
      expect(ent.heartsRemaining, FreeTier.dailyHearts);
      expect(ent.hasHearts, isTrue);
    });

    test('the refill threshold is reachable inside the free tier', () {
      // The free tier holds one 20-card vocab set and one 20-question grammar
      // set. A threshold above that would make the refill unreachable and turn
      // "practice pauses" into "practice ends", which the paywall copy does
      // not claim.
      expect(FreeTier.correctAnswersForHeartRefill, lessThanOrEqualTo(20));
    });

    test('Pro ignores hearts entirely', () {
      ent.setPro(true, source: ProProducts.lifetime);
      for (var i = 0; i < 20; i++) {
        ent.loseHeart();
      }
      expect(ent.hasHearts, isTrue);
    });
  });

  group('AI coach', () {
    test('free messages are capped, then blocked', () {
      for (var i = 0; i < FreeTier.aiMessageLimit; i++) {
        expect(ent.canSendAiMessage, isTrue);
        ent.registerAiMessage();
      }
      expect(ent.aiMessagesRemaining, 0);
      expect(ent.canSendAiMessage, isFalse);
    });

    test('Pro is uncapped', () {
      ent.setPro(true, source: ProProducts.monthly);
      for (var i = 0; i < FreeTier.aiMessageLimit + 10; i++) {
        ent.registerAiMessage();
      }
      expect(ent.canSendAiMessage, isTrue);
    });
  });

  group('Pro state', () {
    test('revoking Pro re-locks content and clears the source', () {
      ent.setPro(true, source: ProProducts.monthly);
      expect(ent.isPro, isTrue);

      // BillingService calls this on launch when a subscription has lapsed.
      ent.setPro(false);
      expect(ent.isPro, isFalse);
      expect(ent.proSource, isNull);
      expect(ent.canAccessMock(1), isFalse);
    });

    test('plan label names the purchased product', () {
      expect(ent.planLabel, 'Free');
      ent.setPro(true, source: ProProducts.yearly);
      expect(ent.planLabel, 'Pro · Yearly');
      ent.setPro(true, source: ProProducts.lifetime);
      expect(ent.planLabel, 'Pro · Lifetime');
    });

    test('entitlement survives a restart', () async {
      ent.setPro(true, source: ProProducts.lifetime);
      for (var i = 0; i < 5; i++) {
        ent.registerAiMessage();
      }
      // _persist is async and fire-and-forget; let it land before re-reading.
      await Future<void>.delayed(Duration.zero);

      final prefs = await SharedPreferences.getInstance();
      final reloaded = Entitlements(prefs)..load();
      expect(reloaded.isPro, isTrue);
      expect(reloaded.proSource, ProProducts.lifetime);
    });
  });

  group('Play product ids', () {
    test('ids are distinct and correctly split by purchase type', () {
      expect(ProProducts.all.length, 3, reason: 'no duplicate ids');
      expect(ProProducts.subscriptions,
          containsAll([ProProducts.monthly, ProProducts.yearly]));
      expect(ProProducts.nonConsumables, contains(ProProducts.lifetime));
      expect(
        ProProducts.subscriptions.intersection(ProProducts.nonConsumables),
        isEmpty,
        reason: 'a product queried as both types resolves as neither',
      );
    });

    test('ids carry the app prefix so they cannot collide with another app '
        'in the same Play account', () {
      for (final id in ProProducts.all) {
        expect(id, startsWith('siraprep_'));
      }
    });
  });
}
