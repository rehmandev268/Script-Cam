import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../features/premium/presentation/providers/premium_provider.dart';
import '../constants/app_constants.dart';

class AppOpenAdManager {
  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;
  static bool isLoaded = false;
  static bool isShowingInterstitial = false;

  void loadAd() {
    AppOpenAd.load(
      adUnitId: AdIds.appOpen,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          isLoaded = true;
        },
        onAdFailedToLoad: (error) {
          log('AppOpenAd failed to load: $error');
        },
      ),
    );
  }

  void showAdIfAvailable(bool isPremium) {
    if (isPremium) return;
    if (isShowingInterstitial) return;
    if (!isLoaded || _isShowingAd || _appOpenAd == null) {
      loadAd();
      return;
    }
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
      },
      onAdDismissedFullScreenContent: (ad) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        isLoaded = false;
        loadAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        isLoaded = false;
        loadAd();
      },
    );
    _appOpenAd!.show();
  }
}

class AdHelper {
  static InterstitialAd? _interstitialAd;
  static bool _isAdLoading = false;

  static void loadInterstitialAd() {
    if (_isAdLoading || _interstitialAd != null) return;
    _isAdLoading = true;
    InterstitialAd.load(
      adUnitId: AdIds.interstitial,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isAdLoading = false;
        },
        onAdFailedToLoad: (err) {
          _interstitialAd = null;
          _isAdLoading = false;
        },
      ),
    );
  }

  static void showInterstitialAd(VoidCallback onComplete, bool isPremium) {
    if (isPremium) {
      onComplete();
      return;
    }
    if (_interstitialAd == null) {
      loadInterstitialAd();
      onComplete();
      return;
    }
    AppOpenAdManager.isShowingInterstitial = true;
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        AppOpenAdManager.isShowingInterstitial = false;
        ad.dispose();
        _interstitialAd = null;
        loadInterstitialAd();
        onComplete();
      },
      onAdFailedToShowFullScreenContent: (ad, err) {
        AppOpenAdManager.isShowingInterstitial = false;
        ad.dispose();
        _interstitialAd = null;
        loadInterstitialAd();
        onComplete();
      },
      onAdShowedFullScreenContent: (_) {
        AppOpenAdManager.isShowingInterstitial = true;
      },
    );
    _interstitialAd!.show();
  }
}

class AppLifecycleReactor extends WidgetsBindingObserver {
  final AppOpenAdManager appOpenAdManager;
  final PremiumProvider provider;
  AppLifecycleReactor(
      {required this.appOpenAdManager, required this.provider});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      appOpenAdManager.showAdIfAvailable(provider.isPremium);
    }
  }
}
