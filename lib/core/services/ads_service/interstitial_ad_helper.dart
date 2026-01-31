import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../constants/app_constants.dart';
import 'ad_state.dart';
import 'app_open_ad_manager.dart';
import '../analytics_service.dart';

class InterstitialAdHelper {
  static InterstitialAd? _interstitialAd;
  static bool _isLoading = false;

  static int _numAttempts = 0;
  static const int _maxAttempts = 5;

  static void load() {
    if (!AdState.canRequestAds) return;
    if (_isLoading || _interstitialAd != null) return;

    _isLoading = true;

    InterstitialAd.load(
      adUnitId: AdIds.interstitial,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isLoading = false;
          _numAttempts = 0;
        },
        onAdFailedToLoad: (error) {
          _interstitialAd = null;
          _isLoading = false;
          _numAttempts++;
          AnalyticsService().logAdLoadFailed(
            adType: 'interstitial',
            reason: error.message,
          );
          if (_numAttempts <= _maxAttempts) {
            final delay = math.pow(2, _numAttempts).toInt();
            Future.delayed(Duration(seconds: delay), () => load());
          }
        },
      ),
    );
  }

  static void show({
    required bool isPremium,
    required VoidCallback onComplete,
  }) {
    if (!AdState.canRequestAds || isPremium) {
      onComplete();
      return;
    }

    if (_interstitialAd == null) {
      load();
      onComplete();
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (_) {
        AppOpenAdManager.isShowingInterstitial = true;
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      },
      onAdDismissedFullScreenContent: (ad) {
        _finish(ad, onComplete);
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        AnalyticsService().logAdLoadFailed(
          adType: 'interstitial',
          reason: error.message,
        );
        _finish(ad, onComplete);
      },
      onAdImpression: (_) {
        AnalyticsService().logAdDisplayed(
          adType: 'interstitial',
          adPlacement: 'general',
        );
      },
      onAdClicked: (_) {
        AnalyticsService().logAdClicked(
          adType: 'interstitial',
          adPlacement: 'general',
        );
      },
    );

    _interstitialAd!.show();
  }

  static void _finish(InterstitialAd ad, VoidCallback onComplete) {
    ad.dispose();
    _interstitialAd = null;

    AppOpenAdManager.restoreSystemUI();
    AppOpenAdManager.isShowingInterstitial = false;

    load();
    onComplete();
  }
}
