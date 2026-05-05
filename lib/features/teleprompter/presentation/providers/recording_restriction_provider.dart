import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/services/ads_service/rewarded_ad_helper.dart';
import '../../../../core/services/analytics_service.dart';
import '../../../../core/services/connectivity_service.dart';

enum AdGateState { idle, loading, showing, error, rewardPending }

class RecordingRestrictionProvider extends ChangeNotifier {
  int _remainingRecordings = 0;
  AdGateState _state = AdGateState.idle;
  String? _errorMessage;
  bool _isPremium = false;

  int get remainingRecordings => _remainingRecordings;
  AdGateState get state => _state;
  String? get errorMessage => _errorMessage;
  bool get isLimitReached => _remainingRecordings <= 0 && !_isPremium;
  bool get isLoading =>
      _state == AdGateState.loading || _state == AdGateState.rewardPending;

  static const String _storageKey = 'remaining_recordings_count';
  static const String _firstInstallKey = 'credits_initialized';
  static const int _initialFreeCredits = 3;

  RecordingRestrictionProvider() {
    _loadCredits();
  }

  Future<void> _loadCredits() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final initialized = prefs.getBool(_firstInstallKey) ?? false;
      if (!initialized) {
        _remainingRecordings = _initialFreeCredits;
        await prefs.setInt(_storageKey, _initialFreeCredits);
        await prefs.setBool(_firstInstallKey, true);
      } else {
        _remainingRecordings = prefs.getInt(_storageKey) ?? 0;
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error loading credits: $e");
    }
  }

  Future<void> _saveCredits() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_storageKey, _remainingRecordings);
    } catch (e) {
      debugPrint("Error saving credits: $e");
    }
  }

  void updatePremiumStatus(bool isPremium) {
    if (_isPremium != isPremium) {
      _isPremium = isPremium;
      notifyListeners();
    }
  }

  void resetSession() {
    _remainingRecordings = 0;
    _saveCredits();
    _state = AdGateState.idle;
    _errorMessage = null;
    AnalyticsService().logEvent(
      name: 'recording_session_reset',
      parameters: {'count': _remainingRecordings},
    );
    notifyListeners();
  }

  void decrementRecordings() {
    if (_isPremium) return;

    if (_remainingRecordings > 0) {
      _remainingRecordings--;
      _saveCredits();
      AnalyticsService().logEvent(
        name: 'recording_count_decremented',
        parameters: {'remaining': _remainingRecordings},
      );
      if (_remainingRecordings == 0) {
        AnalyticsService().logEvent(name: 'recording_limit_reached');
      }
      notifyListeners();
    }
  }

  Future<void> watchAd({
    required ConnectivityService connectivity,
    required VoidCallback onRewardGranted,
    required void Function(String title, String message) onFailure,
  }) async {
    if (isLoading) return;

    if (!connectivity.isConnected) {
      onFailure('noInternetError', 'noInternetErrorDesc');
      return;
    }

    _state = AdGateState.loading;
    _errorMessage = null;
    notifyListeners();

    AnalyticsService().logEvent(name: 'ad_load_started');

    try {
      // Step 1: Load Ad
      final success = await RewardedAdHelper.loadAd();

      if (!success) {
        _state = AdGateState.error;
        _errorMessage = 'adNotAvailable';
        notifyListeners();
        onFailure('adNotAvailable', 'adNotAvailableDesc');
        return;
      }

      // Step 2: Show Ad
      _state = AdGateState.showing;
      notifyListeners();

      RewardedAdHelper.show(
        onRewardEarned: () {
          _grantReward();
          onRewardGranted();
        },
        onAdFailed: () {
          _state = AdGateState.error;
          notifyListeners();
          onFailure('adNotCompleted', 'adNotCompletedDesc');
        },
      );

      // We don't wait for show to finish in the future if it uses callbacks,
      // but we need to ensure state is cleaned up if reward isn't granted.
      // The callbacks above handle it.
    } catch (e) {
      _state = AdGateState.error;
      _errorMessage = e.toString();
      notifyListeners();
      onFailure('unexpectedError', 'unexpectedErrorDesc');
    }
  }

  void _grantReward() {
    _remainingRecordings += 3;
    _saveCredits();
    _state = AdGateState.idle;
    AnalyticsService().logEvent(
      name: 'reward_granted',
      parameters: {'added': 3, 'new_total': _remainingRecordings},
    );
    notifyListeners();
  }

  void setError(String? message) {
    _errorMessage = message;
    _state = message != null ? AdGateState.error : AdGateState.idle;
    notifyListeners();
  }
}
