import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/utils/toast_service.dart';
import '../../../../core/services/analytics_service.dart';
import '../../../../generated/l10n/app_localizations.dart';

const String _kPremiumLifetimeProductId = 'sc_premium_lifetime';
const String _kPremiumWeeklyProductId = 'sc_premium_weekly';
const String _kPremiumWeeklyAltProductId = 'sc_weekly';
const String _kPremiumMonthlyLegacyProductId = 'sc_premium_monthly';
const String _kPrefKey = 'is_premium_user';
const String _kPlanTypePrefKey = 'premium_plan_type';

class PremiumProvider extends ChangeNotifier {
  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  bool _disposed = false;

  bool _isPremium = false;
  bool _isPurchasing = false;
  List<ProductDetails> _products = [];
  bool _productsLoaded = false;

  bool get isPremium => _isPremium;
  bool get isPurchasing => _isPurchasing;
  bool get productsLoaded => _productsLoaded;

  bool _isLifetime = true;
  bool get isLifetime => _isLifetime;
  DateTime? get renewalDate => null;

  String get planTypeKey => _isLifetime ? 'lifetimePlan' : 'weeklyPlan';

  List<String> get unlockedFeatureKeys => [
    'unlimitedRecordings',
    'noAds',
    'voiceSyncFeature',
    'cloudBackup',
    'highQualityVideo',
  ];

  PremiumProvider() {
    _init();
  }

  bool _isLifetimeProductId(String productId) {
    return productId == _kPremiumLifetimeProductId;
  }

  bool _isWeeklyProductId(String productId) {
    return productId == _kPremiumWeeklyProductId ||
        productId == _kPremiumWeeklyAltProductId ||
        productId == _kPremiumMonthlyLegacyProductId;
  }

  ProductDetails? get lifetimeProduct {
    for (final p in _products) {
      if (_isLifetimeProductId(p.id)) return p;
    }
    for (final p in _products) {
      final id = p.id.toLowerCase();
      if (id.contains('life')) return p;
    }
    return null;
  }

  ProductDetails? get weeklyProduct {
    for (final p in _products) {
      if (_isWeeklyProductId(p.id)) return p;
    }
    for (final p in _products) {
      final id = p.id.toLowerCase();
      if (id.contains('week') || id.contains('sub')) return p;
    }
    // Fallback: if Play returns an unexpected subscription id format,
    // use any non-lifetime product so at least pricing can be shown.
    for (final p in _products) {
      if (!_isLifetimeProductId(p.id)) return p;
    }
    return null;
  }

  /// Returns the actual recurring price for the weekly subscription.
  /// For subscriptions with a free trial, Google Play's ProductDetails.price
  /// returns the introductory (free trial) price. The recurring price is in
  /// the last pricing phase of the subscription offer details.
  String? get weeklyRecurringPrice {
    final product = weeklyProduct;
    if (product == null) return null;
    if (product is GooglePlayProductDetails) {
      final subscriptionIndex = product.subscriptionIndex;
      if (subscriptionIndex != null) {
        final offerDetails =
            product.productDetails.subscriptionOfferDetails?[subscriptionIndex];
        if (offerDetails != null && offerDetails.pricingPhases.isNotEmpty) {
          return offerDetails.pricingPhases.last.formattedPrice;
        }
      }
    }
    // Fallback: if price looks like a zero/free value, return null so the UI
    // can show a generic label instead.
    final price = product.price;
    if (price.isEmpty || price == 'Free' || product.rawPrice == 0) return null;
    return price;
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    if (_disposed) return;
    _isPremium = prefs.getBool(_kPrefKey) ?? false;
    _isLifetime = (prefs.getString(_kPlanTypePrefKey) ?? 'lifetime') == 'lifetime';
    notifyListeners();

    final Stream<List<PurchaseDetails>> purchaseUpdated = _iap.purchaseStream;
    _subscription = purchaseUpdated.listen(
      _listenToPurchaseUpdated,
      onDone: () => _subscription?.cancel(),
      onError: (error) {
        if (_disposed) return;
        _setPurchasing(false);
        _showLocalizedToast((l10n) => l10n.connectionError);
      },
    );

    await _loadProducts();
  }

  Future<void> _loadProducts() async {
    final bool available = await _iap.isAvailable();
    if (!available) return;

    const Set<String> kIds = {
      _kPremiumLifetimeProductId,
      _kPremiumWeeklyProductId,
      _kPremiumWeeklyAltProductId,
      _kPremiumMonthlyLegacyProductId,
    };
    final ProductDetailsResponse response = await _iap.queryProductDetails(
      kIds,
    );

    if (response.notFoundIDs.isNotEmpty) {}

    _products = response.productDetails;
    _productsLoaded = true;
    notifyListeners();
  }

  Future<void> refreshProducts() async {
    await _loadProducts();
  }

  Future<void> buyPremium({required bool isLifetimePlan}) async {
    final selectedProduct = isLifetimePlan ? lifetimeProduct : weeklyProduct;
    if (selectedProduct == null) {
      _showLocalizedToast((l10n) => l10n.storeUnavailable);
      return;
    }

    _setPurchasing(true);

    final PurchaseParam purchaseParam = PurchaseParam(productDetails: selectedProduct);

    try {
      AnalyticsService().logPurchaseInitiated(
        productId: selectedProduct.id,
        productType: isLifetimePlan ? 'non_consumable' : 'subscription',
      );
      await _iap.buyNonConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      _setPurchasing(false);
      AnalyticsService().logPurchaseFailed(
        productId: selectedProduct.id,
        reason: e.toString(),
      );
      ToastService.show("Purchase failed to initiate");
      _showLocalizedToast((l10n) => l10n.purchaseFailedInitiate);
    }
  }

  Future<void> restorePurchases() async {
    try {
      await _iap.restorePurchases();
    } catch (e) {
      _showLocalizedToast((l10n) => l10n.restoreFailed(e.toString()));
    }
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    if (_disposed) return;
    if (purchaseDetailsList.isEmpty) {
      _setPurchasing(false);
      return;
    }

    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
          _setPurchasing(true);
          break;
        case PurchaseStatus.canceled:
          _setPurchasing(false);
          break;
        case PurchaseStatus.error:
          _setPurchasing(false);
          if (purchaseDetails.error?.code != 'user_cancelled') {
            _showLocalizedToast(
              (l10n) => l10n.purchaseErrorDetail(
                purchaseDetails.error?.message ?? 'Unknown Error',
              ),
            );
          }
          break;
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          _deliverProduct(purchaseDetails);
          break;
      }

      if (purchaseDetails.pendingCompletePurchase) {
        _iap.completePurchase(purchaseDetails);
      }
    }
  }

  Future<void> _deliverProduct(PurchaseDetails purchaseDetails) async {
    if (_isLifetimeProductId(purchaseDetails.productID) ||
        _isWeeklyProductId(purchaseDetails.productID)) {
      _isPremium = true;
      _isLifetime = _isLifetimeProductId(purchaseDetails.productID);
      final prefs = await SharedPreferences.getInstance();
      if (_disposed) return;
      await prefs.setBool(_kPrefKey, true);
      await prefs.setString(_kPlanTypePrefKey, _isLifetime ? 'lifetime' : 'weekly');

      _setPurchasing(false);
      notifyListeners();

      if (purchaseDetails.status == PurchaseStatus.purchased) {
        AnalyticsService().logPurchaseCompleted(
          productId: purchaseDetails.productID,
          productType: _isLifetime ? 'non_consumable' : 'subscription',
          price: 0, // Price info not directly available in PurchaseDetails
          currency: 'USD',
        );
        AnalyticsService().logPremiumActivated();
        _showLocalizedToast((l10n) => l10n.premiumUnlocked);
      } else if (purchaseDetails.status == PurchaseStatus.restored) {
        AnalyticsService().logPurchaseRestored(restoredCount: 1);
        _showLocalizedToast((l10n) => l10n.restoredSuccessfully);
      }
    } else {
      _setPurchasing(false);
    }
  }

  void _setPurchasing(bool value) {
    if (_isPurchasing != value) {
      _isPurchasing = value;
      notifyListeners();
    }
  }

  void _showLocalizedToast(String Function(AppLocalizations) messageSelector) {
    final context = ToastService.navigatorKey.currentContext;
    if (context != null) {
      final l10n = AppLocalizations.of(context);
      ToastService.show(messageSelector(l10n));
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _subscription?.cancel();
    _subscription = null;
    super.dispose();
  }
}
