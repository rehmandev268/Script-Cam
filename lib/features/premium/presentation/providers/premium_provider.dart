import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/utils/toast_service.dart';

const String _kPremiumProductId = 'com.yourname.yourapp.premium'; // Replace with real ID
const String _kPrefKey = 'is_premium_user';

class PremiumProvider extends ChangeNotifier {
  final InAppPurchase _iap = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  
  bool _isPremium = false;
  
  // Only track PURCHASING status here (Restoring is handled locally in UI)
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

    _subscription = _iap.purchaseStream.listen(
      _listenToPurchaseUpdated,
      onDone: () => _subscription.cancel(),
      onError: (error) {
        _setPurchasing(false);
      },
    );

    await _loadProducts();
  }

  Future<void> _loadProducts() async {
    final bool available = await _iap.isAvailable();
    if (!available) return;

    const Set<String> _kIds = {_kPremiumProductId};
    final ProductDetailsResponse response = await _iap.queryProductDetails(_kIds);
    _products = response.productDetails;
    notifyListeners();
  }

  // --- BUYING (Updates _isPurchasing) ---
  Future<void> buyPremium() async {
    if (_products.isEmpty) {
      ToastService.show("Store unavailable");
      return;
    }
    _setPurchasing(true); // Start loading on Purchase button
    
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: _products.first);
    await _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }

  // --- RESTORING (Returns Future, UI handles loading) ---
  Future<void> restorePurchases() async {
    // We do NOT set _isPurchasing here. 
    // The UI will show its own spinner while awaiting this.
    try {
      await _iap.restorePurchases();
      // Logic continues in _listenToPurchaseUpdated when items arrive
    } catch (e) {
      ToastService.show("Restore failed: $e");
    }
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      
      if (purchaseDetails.status == PurchaseStatus.pending) {
        _setPurchasing(true); // Keep spinner going
      } 
      else if (purchaseDetails.status == PurchaseStatus.error) {
        _setPurchasing(false); // Stop spinner
        if (purchaseDetails.error?.code != 'user_cancelled') {
           ToastService.show("Error: ${purchaseDetails.error?.message}");
        }
      } 
      else if (purchaseDetails.status == PurchaseStatus.purchased ||
               purchaseDetails.status == PurchaseStatus.restored) {
        
        _deliverProduct(purchaseDetails);
      }
      
      if (purchaseDetails.pendingCompletePurchase) {
        _iap.completePurchase(purchaseDetails);
      }
    }
  }

  Future<void> _deliverProduct(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.productID == _kPremiumProductId) {
      _isPremium = true;
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_kPrefKey, true);
      
      // Stop spinner
      _setPurchasing(false);

      if (purchaseDetails.status == PurchaseStatus.purchased) {
        ToastService.show("Premium Unlocked!");
      } else if (purchaseDetails.status == PurchaseStatus.restored) {
         ToastService.show("Restored Successfully");
      }
    } else {
      _setPurchasing(false);
    }
  }

  void _setPurchasing(bool value) {
    _isPurchasing = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}