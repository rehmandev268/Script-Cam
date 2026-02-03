import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:async';
import '../../constants/app_constants.dart';
import 'package:flutter/foundation.dart';
import '../analytics_service.dart';

class RewardedAdHelper {
  static RewardedAd? _rewardedAd;

  static bool get isAdLoaded => _rewardedAd != null;

  static Future<bool> loadAd() async {
    if (_rewardedAd != null) return true;

    final completer = Completer<bool>();
    RewardedAd.load(
      adUnitId: AdIds.rewarded,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _rewardedAd = null;
              load(); // Reload instantly after showing
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _rewardedAd = null;
              load();
            },
          );
          if (!completer.isCompleted) completer.complete(true);
        },
        onAdFailedToLoad: (error) {
          _rewardedAd = null;
          AnalyticsService().logRewardedAdFailed(reason: 'Load failed: $error');
          debugPrint('RewardedAd failed to load: $error');
          if (!completer.isCompleted) completer.complete(false);
        },
      ),
    );

    return completer.future;
  }

  static void load() {
    RewardedAd.load(
      adUnitId: AdIds.rewarded,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _rewardedAd = null;
              load(); // Reload instantly after showing
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _rewardedAd = null;
              load();
            },
          );
        },
        onAdFailedToLoad: (error) {
          _rewardedAd = null;
          AnalyticsService().logRewardedAdFailed(reason: 'Load failed: $error');
          debugPrint('RewardedAd failed to load: $error');
        },
      ),
    );
  }

  static void show({
    required Function onRewardEarned,
    required Function onAdFailed,
  }) {
    if (_rewardedAd != null) {
      _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          onRewardEarned();
        },
      );
    } else {
      onAdFailed();
    }
  }

  /// Retries loading the ad once, and executes fallback if still fails.
  static Future<void> retryAndShow({
    required Function onRewardEarned,
    required Function onFallbackProceed,
  }) async {
    if (_rewardedAd != null) {
      show(onRewardEarned: onRewardEarned, onAdFailed: onFallbackProceed);
      return;
    }

    // Try loading again
    RewardedAd.load(
      adUnitId: AdIds.rewarded,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          show(onRewardEarned: onRewardEarned, onAdFailed: onFallbackProceed);
        },
        onAdFailedToLoad: (error) {
          _rewardedAd = null;
          AnalyticsService().logRewardedAdFailed(
            reason: 'Retry load failed: $error',
          );
          onFallbackProceed(); // Fallback if retry fails
        },
      ),
    );
  }
}
