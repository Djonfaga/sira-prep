import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'entitlements.dart';

/// Google Play billing for Sira Prep Pro.
///
/// Owns the purchase stream, resolves product details for the paywall, and is
/// the only thing allowed to flip [Entitlements.setPro].
///
/// **Verification:** purchases are validated on-device. That is enough to gate
/// features honestly for ordinary users, but it is spoofable on a rooted
/// device. Before scaling paid users, move validation server-side — a small
/// endpoint that checks the purchase token against the Play Developer API is
/// the natural home. Tracked in PLAY_LAUNCH_CHECKLIST.md.
class BillingService extends ChangeNotifier {
  BillingService({required this.entitlements, InAppPurchase? iap}) : _iap = iap;

  final Entitlements entitlements;

  /// Null where there is no store to talk to. Resolved lazily in [init] rather
  /// than in the constructor, because `InAppPurchase.instance` throws outright
  /// on platforms with no registered implementation — web and the test host —
  /// and that must not be able to kill app startup or make this class
  /// impossible to construct in a test.
  InAppPurchase? _iap;

  StreamSubscription<List<PurchaseDetails>>? _sub;

  bool _available = false;
  bool _loading = true;
  String? _error;
  List<ProductDetails> _products = const [];

  /// Set while a purchase is in flight so the paywall can show progress and
  /// block double taps.
  bool _purchasePending = false;

  bool get isAvailable => _available;
  bool get isLoading => _loading;
  String? get error => _error;
  bool get purchasePending => _purchasePending;
  List<ProductDetails> get products => _products;

  ProductDetails? productFor(String id) {
    for (final p in _products) {
      if (p.id == id) return p;
    }
    return null;
  }

  /// Starts listening and loads products. Non-throwing: a device with no Play
  /// Services simply reports [isAvailable] false and the app stays fully
  /// usable on the free tier.
  Future<void> init() async {
    if (_iap == null && !kIsWeb) {
      try {
        _iap = InAppPurchase.instance;
      } catch (_) {
        _iap = null;
      }
    }

    final iap = _iap;
    if (iap == null) {
      // No store on this platform: stay on the free tier, stay usable.
      _available = false;
      _loading = false;
      notifyListeners();
      return;
    }

    _sub = iap.purchaseStream.listen(
      _onPurchases,
      onError: (Object e) {
        _error = 'Purchase stream error: $e';
        notifyListeners();
      },
    );

    try {
      _available = await iap.isAvailable();
    } catch (_) {
      _available = false;
    }

    if (_available) {
      await _loadProducts();
      // Re-validate on every launch so a lapsed or refunded subscription
      // actually loses access rather than staying Pro forever.
      unawaited(restore());
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> _loadProducts() async {
    try {
      final resp = await _iap!.queryProductDetails(ProProducts.all);
      if (resp.error != null) {
        _error = resp.error!.message;
      }
      _products = resp.productDetails;
      if (resp.notFoundIDs.isNotEmpty) {
        debugPrint(
          'Billing: products not found in Play Console: '
          '${resp.notFoundIDs.join(', ')}. Create them with these exact ids, '
          'or the paywall will show nothing to buy.',
        );
      }
    } catch (e) {
      _error = '$e';
    }
  }

  /// Launches the Play purchase flow for [productId].
  Future<void> buy(String productId) async {
    final product = productFor(productId);
    if (product == null) {
      _error = 'That plan is not available right now.';
      notifyListeners();
      return;
    }

    _purchasePending = true;
    _error = null;
    notifyListeners();

    try {
      final param = PurchaseParam(productDetails: product);
      // Both subscriptions and the lifetime unlock are non-consumable: they are
      // owned once and restored, never bought twice.
      await _iap!.buyNonConsumable(purchaseParam: param);
    } catch (e) {
      _purchasePending = false;
      _error = '$e';
      notifyListeners();
    }
  }

  /// Re-applies previously owned purchases (new device, reinstall).
  Future<void> restore() async {
    final iap = _iap;
    if (iap == null) return;
    try {
      await iap.restorePurchases();
    } catch (e) {
      _error = '$e';
      notifyListeners();
    }
  }

  Future<void> _onPurchases(List<PurchaseDetails> purchases) async {
    var granted = false;
    String? source;

    for (final p in purchases) {
      switch (p.status) {
        case PurchaseStatus.pending:
          _purchasePending = true;

        case PurchaseStatus.error:
          _purchasePending = false;
          _error = p.error?.message ?? 'The purchase could not be completed.';

        case PurchaseStatus.canceled:
          _purchasePending = false;

        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          _purchasePending = false;
          if (ProProducts.all.contains(p.productID)) {
            granted = true;
            source = p.productID;
          }
      }

      // Every delivered purchase must be acknowledged, or Play auto-refunds it
      // after three days.
      if (p.pendingCompletePurchase) {
        try {
          await _iap!.completePurchase(p);
        } catch (e) {
          debugPrint('Billing: completePurchase failed: $e');
        }
      }
    }

    if (granted) {
      entitlements.setPro(true, source: source);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
