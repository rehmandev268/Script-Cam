import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/utils/toast_service.dart';
import '../../../../core/services/analytics_service.dart';

const String _kPremiumProductId = 'sc_premium_lifetime';
const String _kPrefKey = 'is_premium_user';

class PremiumProvider extends ChangeNotifier {
  final InAppPurchase _iap = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;

  bool _isPremium = true;
  bool _isPurchasing = false;
  List<ProductDetails> _products = [];

  bool get isPremium => _isPremium;
  bool get isPurchasing => _isPurchasing;

  PremiumProvider() {
    _init();
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    _isPremium = prefs.getBool(_kPrefKey) ?? false;
    notifyListeners();

    final Stream<List<PurchaseDetails>> purchaseUpdated = _iap.purchaseStream;
    _subscription = purchaseUpdated.listen(
      _listenToPurchaseUpdated,
      onDone: () => _subscription.cancel(),
      onError: (error) {
        _setPurchasing(false);
        ToastService.show("Connection Error");
      },
    );

    await _loadProducts();
  }

  Future<void> _loadProducts() async {
    final bool available = await _iap.isAvailable();
    if (!available) return;

    const Set<String> kIds = {_kPremiumProductId};
    final ProductDetailsResponse response = await _iap.queryProductDetails(
      kIds,
    );

    if (response.notFoundIDs.isNotEmpty) {}

    _products = response.productDetails;
    notifyListeners();
  }

  Future<void> buyPremium() async {
    if (_products.isEmpty) {
      ToastService.show("Store unavailable");
      return;
    }

    _setPurchasing(true);

    final PurchaseParam purchaseParam = PurchaseParam(
      productDetails: _products.first,
    );

    try {
      AnalyticsService().logPurchaseInitiated(
        productId: _products.first.id,
        productType: 'non_consumable',
      );
      await _iap.buyNonConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      _setPurchasing(false);
      AnalyticsService().logPurchaseFailed(
        productId: _products.first.id,
        reason: e.toString(),
      );
      ToastService.show("Purchase failed to initiate");
    }
  }

  Future<void> restorePurchases() async {
    try {
      await _iap.restorePurchases();
    } catch (e) {
      ToastService.show("Restore failed: $e");
    }
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
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
            ToastService.show("Error: ${purchaseDetails.error?.message}");
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
    if (purchaseDetails.productID == _kPremiumProductId) {
      _isPremium = true;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_kPrefKey, true);

      _setPurchasing(false);
      notifyListeners();

      if (purchaseDetails.status == PurchaseStatus.purchased) {
        AnalyticsService().logPurchaseCompleted(
          productId: purchaseDetails.productID,
          productType: 'non_consumable',
          price: 0, // Price info not directly available in PurchaseDetails
          currency: 'USD',
        );
        ToastService.show("Premium Unlocked!");
      } else if (purchaseDetails.status == PurchaseStatus.restored) {
        AnalyticsService().logPurchaseRestored(restoredCount: 1);
        ToastService.show("Restored Successfully");
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

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
