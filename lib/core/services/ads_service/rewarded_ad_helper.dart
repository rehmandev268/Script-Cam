import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:async';
import '../../constants/app_constants.dart';
import 'package:flutter/foundation.dart';
import '../analytics_service.dart';
import 'ad_state.dart';

class RewardedAdHelper {
  static RewardedAd? _rewardedAd;
  static InterstitialAd? _interstitialAd;

  // AdMob ads expire after ~1 hour. Track load time to detect stale ads.
  static DateTime? _rewardedLoadTime;
  static DateTime? _interstitialLoadTime;
  static const Duration _adExpiry = Duration(minutes: 55);

  // Guards against concurrent load calls firing duplicate requests.
  static bool _rewardedLoading = false;
  static bool _interstitialLoading = false;

  static bool _isStale(DateTime? loadTime) {
    if (loadTime == null) return true;
    return DateTime.now().difference(loadTime) > _adExpiry;
  }

  static bool get isAdLoaded {
    // Treat stale ads as not loaded so they get refreshed before showing.
    if (_rewardedAd != null && !_isStale(_rewardedLoadTime)) return true;
    if (_interstitialAd != null && !_isStale(_interstitialLoadTime)) return true;
    return false;
  }

  static Future<bool> loadAd() async {
    // If we have a fresh ad already, return immediately.
    if (_rewardedAd != null && !_isStale(_rewardedLoadTime)) return true;
    if (_interstitialAd != null && !_isStale(_interstitialLoadTime)) return true;

    // Dispose stale cached ads before reloading.
    if (_rewardedAd != null && _isStale(_rewardedLoadTime)) {
      _rewardedAd!.dispose();
      _rewardedAd = null;
      _rewardedLoadTime = null;
    }
    if (_interstitialAd != null && _isStale(_interstitialLoadTime)) {
      _interstitialAd!.dispose();
      _interstitialAd = null;
      _interstitialLoadTime = null;
    }

    _rewardedLoading = true;
    final completer = Completer<bool>();
    RewardedAd.load(
      adUnitId: AdIds.rewarded,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedLoading = false;
          _rewardedAd = ad;
          _rewardedLoadTime = DateTime.now();
          _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _rewardedAd = null;
              _rewardedLoadTime = null;
              load();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _rewardedAd = null;
              _rewardedLoadTime = null;
              load();
            },
          );
          if (!completer.isCompleted) completer.complete(true);
        },
        onAdFailedToLoad: (error) {
          _rewardedLoading = false;
          _rewardedAd = null;
          _rewardedLoadTime = null;
          AnalyticsService().logRewardedAdFailed(reason: 'Load failed: $error');
          debugPrint('RewardedAd failed to load: $error');
          _loadInterstitial(completer);
        },
      ),
    );

    return completer.future;
  }

  static void load() {
    if (!AdState.canRequestAds) return;
    if (_rewardedLoading) return;
    if (_rewardedAd != null && !_isStale(_rewardedLoadTime)) return;
    _rewardedLoading = true;
    RewardedAd.load(
      adUnitId: AdIds.rewarded,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedLoading = false;
          _rewardedAd = ad;
          _rewardedLoadTime = DateTime.now();
          _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _rewardedAd = null;
              _rewardedLoadTime = null;
              load();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _rewardedAd = null;
              _rewardedLoadTime = null;
              load();
            },
          );
        },
        onAdFailedToLoad: (error) {
          _rewardedLoading = false;
          _rewardedAd = null;
          _rewardedLoadTime = null;
          AnalyticsService().logRewardedAdFailed(reason: 'Load failed: $error');
          debugPrint('RewardedAd failed to load: $error');
          loadInterstitial();
        },
      ),
    );
  }

  static void show({
    required Function onRewardEarned,
    required Function onAdFailed,
  }) {
    // Always check freshness before showing — stale ads fail silently at show time.
    if (_rewardedAd != null && !_isStale(_rewardedLoadTime)) {
      _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          onRewardEarned();
        },
      );
    } else if (_interstitialAd != null && !_isStale(_interstitialLoadTime)) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _interstitialAd = null;
          _interstitialLoadTime = null;
          loadInterstitial();
          onRewardEarned();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _interstitialAd = null;
          _interstitialLoadTime = null;
          loadInterstitial();
          onAdFailed();
        },
      );
      _interstitialAd!.show();
    } else {
      // Stale or null — dispose and reload, then call onAdFailed so UI can retry.
      if (_rewardedAd != null) {
        _rewardedAd!.dispose();
        _rewardedAd = null;
        _rewardedLoadTime = null;
      }
      if (_interstitialAd != null) {
        _interstitialAd!.dispose();
        _interstitialAd = null;
        _interstitialLoadTime = null;
      }
      load();
      onAdFailed();
    }
  }

  /// Retries loading the ad once, and executes fallback if still fails.
  static Future<void> retryAndShow({
    required Function onRewardEarned,
    required Function onFallbackProceed,
  }) async {
    if (isAdLoaded) {
      show(onRewardEarned: onRewardEarned, onAdFailed: onFallbackProceed);
      return;
    }

    // Try loading again (handles fallback to interstitial if rewarded fails)
    bool success = await loadAd();
    if (success) {
      show(onRewardEarned: onRewardEarned, onAdFailed: onFallbackProceed);
    } else {
      onFallbackProceed();
    }
  }

  static void loadInterstitial() {
    if (!AdState.canRequestAds) return;
    if (_interstitialLoading) return;
    if (_interstitialAd != null && !_isStale(_interstitialLoadTime)) return;
    _interstitialLoading = true;
    InterstitialAd.load(
      adUnitId: AdIds.interstitial,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialLoading = false;
          _interstitialAd = ad;
          _interstitialLoadTime = DateTime.now();
          _interstitialAd!.fullScreenContentCallback =
              FullScreenContentCallback(
                onAdDismissedFullScreenContent: (ad) {
                  ad.dispose();
                  _interstitialAd = null;
                  _interstitialLoadTime = null;
                  loadInterstitial();
                },
                onAdFailedToShowFullScreenContent: (ad, error) {
                  ad.dispose();
                  _interstitialAd = null;
                  _interstitialLoadTime = null;
                  loadInterstitial();
                },
              );
        },
        onAdFailedToLoad: (error) {
          _interstitialLoading = false;
          _interstitialAd = null;
          _interstitialLoadTime = null;
          debugPrint('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  static Future<void> _loadInterstitial(Completer<bool> completer) async {
    if (_interstitialLoading) {
      // Another load already in flight — wait a moment then check result.
      await Future.delayed(const Duration(seconds: 3));
      if (!completer.isCompleted) {
        completer.complete(_interstitialAd != null && !_isStale(_interstitialLoadTime));
      }
      return;
    }
    _interstitialLoading = true;
    InterstitialAd.load(
      adUnitId: AdIds.interstitial,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialLoading = false;
          _interstitialAd = ad;
          _interstitialLoadTime = DateTime.now();
          _interstitialAd!.fullScreenContentCallback =
              FullScreenContentCallback(
                onAdDismissedFullScreenContent: (ad) {
                  ad.dispose();
                  _interstitialAd = null;
                  _interstitialLoadTime = null;
                  loadInterstitial();
                },
                onAdFailedToShowFullScreenContent: (ad, error) {
                  ad.dispose();
                  _interstitialAd = null;
                  _interstitialLoadTime = null;
                  loadInterstitial();
                },
              );
          if (!completer.isCompleted) completer.complete(true);
        },
        onAdFailedToLoad: (error) {
          _interstitialLoading = false;
          _interstitialAd = null;
          _interstitialLoadTime = null;
          debugPrint('InterstitialAd failed to load: $error');
          if (!completer.isCompleted) completer.complete(false);
        },
      ),
    );
  }
}
