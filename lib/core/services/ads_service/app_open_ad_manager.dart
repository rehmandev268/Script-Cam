import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../constants/app_constants.dart';
import 'ad_state.dart';

class AppOpenAdManager {
  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;
  bool _isLoaded = false;

  static bool isShowingInterstitial = false;

  DateTime? _lastShownTime;

  static const Duration _coolDown = Duration(minutes: 3);

  bool get _canShowNow {
    if (_lastShownTime == null) return true;
    return DateTime.now().difference(_lastShownTime!) > _coolDown;
  }

  void loadAd() {
    if (!AdState.canRequestAds) return;
    if (isShowingInterstitial) return;
    if (_isLoaded) return;

    AppOpenAd.load(
      adUnitId: AdIds.appOpen,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _isLoaded = true;
          log('AppOpenAd loaded');
        },
        onAdFailedToLoad: (error) {
          log('AppOpenAd load failed: $error');
          _isLoaded = false;
          _appOpenAd = null;
        },
      ),
    );
  }

  void showAdIfAvailable(bool isPremium) {
    if (!AdState.canRequestAds) return;
    if (isPremium) return;
    if (isShowingInterstitial) return;
    if (!_canShowNow) return;

    if (!_isLoaded || _appOpenAd == null || _isShowingAd) {
      loadAd();
      return;
    }

    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (_) {
        _isShowingAd = true;
        _lastShownTime = DateTime.now();
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      },
      onAdDismissedFullScreenContent: (ad) {
        _cleanUp(ad);
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        log('AppOpenAd failed to show: $error');
        _cleanUp(ad);
      },
      onAdImpression: (_) {
        log('AppOpenAd impression');
      },
    );

    _appOpenAd!.show();
  }

  void _cleanUp(AppOpenAd ad) {
    _isShowingAd = false;
    _isLoaded = false;
    ad.dispose();
    _appOpenAd = null;

    restoreSystemUI();
    loadAd();
  }

  void dispose() {
    _appOpenAd?.dispose();
    _appOpenAd = null;
  }

  static void restoreSystemUI() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }
}
