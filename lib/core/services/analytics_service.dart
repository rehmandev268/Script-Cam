import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalytics get analytics => _analytics;
  FirebaseAnalyticsObserver get observer =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  void logAppOpen() {
    _analytics.logAppOpen();
  }

  void logScreenView(String screenName, String screenClass) {
    _analytics.logScreenView(screenName: screenName, screenClass: screenClass);
  }

  void logScriptCreated({
    required String scriptId,
    required String title,
    required String category,
    int? wordCount,
  }) {
    _analytics.logEvent(
      name: 'script_created',
      parameters: {
        'script_id': scriptId,
        'title': title,
        'category': category,
        // ignore: use_null_aware_elements
        if (wordCount != null) 'word_count': wordCount,
      },
    );
  }

  void logScriptEdited({
    required String scriptId,
    required String title,
    required String category,
    int? wordCount,
  }) {
    _analytics.logEvent(
      name: 'script_edited',
      parameters: {
        'script_id': scriptId,
        'title': title,
        'category': category,
        // ignore: use_null_aware_elements
        if (wordCount != null) 'word_count': wordCount,
      },
    );
  }

  void logScriptDeleted({required String scriptId, required String category}) {
    _analytics.logEvent(
      name: 'script_deleted',
      parameters: {'script_id': scriptId, 'category': category},
    );
  }

  void logScriptViewed({
    required String scriptId,
    required String title,
    required String category,
  }) {
    _analytics.logEvent(
      name: 'script_viewed',
      parameters: {'script_id': scriptId, 'title': title, 'category': category},
    );
  }

  void logCategorySelected(String category) {
    _analytics.logEvent(
      name: 'category_selected',
      parameters: {'category': category},
    );
  }

  void logRecordingStarted({
    required String scriptId,
    required String scriptTitle,
    required bool isVoiceSyncEnabled,
  }) {
    _analytics.logEvent(
      name: 'recording_started',
      parameters: {
        'script_id': scriptId,
        'script_title': scriptTitle,
        'voice_sync_enabled': isVoiceSyncEnabled,
      },
    );
  }

  void logRecordingStopped({
    required String scriptId,
    required int durationSeconds,
  }) {
    _analytics.logEvent(
      name: 'recording_stopped',
      parameters: {'script_id': scriptId, 'duration_seconds': durationSeconds},
    );
  }

  void logVideoSaved({
    required String videoId,
    required String scriptId,
    required int durationSeconds,
    required int fileSizeBytes,
  }) {
    _analytics.logEvent(
      name: 'video_saved',
      parameters: {
        'video_id': videoId,
        'script_id': scriptId,
        'duration_seconds': durationSeconds,
        'file_size_bytes': fileSizeBytes,
      },
    );
  }

  void logVideoDeleted({
    required String videoId,
    required int durationSeconds,
  }) {
    _analytics.logEvent(
      name: 'video_deleted',
      parameters: {'video_id': videoId, 'duration_seconds': durationSeconds},
    );
  }

  void logVideoShared({required String videoId, required String shareMethod}) {
    _analytics.logEvent(
      name: 'video_shared',
      parameters: {'video_id': videoId, 'share_method': shareMethod},
    );
  }

  void logVideoPlayed({required String videoId, required int durationSeconds}) {
    _analytics.logEvent(
      name: 'video_played',
      parameters: {'video_id': videoId, 'duration_seconds': durationSeconds},
    );
  }

  void logGalleryOpened({required int totalVideos}) {
    _analytics.logEvent(
      name: 'gallery_opened',
      parameters: {'total_videos': totalVideos},
    );
  }

  void logVoiceSyncToggled({required bool enabled}) {
    _analytics.logEvent(
      name: 'voice_sync_toggled',
      parameters: {'enabled': enabled},
    );
  }

  void logMirrorTextToggled({required bool enabled}) {
    _analytics.logEvent(
      name: 'mirror_text_toggled',
      parameters: {'enabled': enabled},
    );
  }

  void logTeleprompterSettingsChanged({
    required double fontSize,
    required double scrollSpeed,
  }) {
    _analytics.logEvent(
      name: 'teleprompter_settings_changed',
      parameters: {'font_size': fontSize, 'scroll_speed': scrollSpeed},
    );
  }

  void logPremiumScreenViewed() {
    _analytics.logEvent(name: 'premium_screen_viewed', parameters: {});
  }

  void logPurchaseInitiated({
    required String productId,
    required String productType,
  }) {
    _analytics.logEvent(
      name: 'purchase_initiated',
      parameters: {'product_id': productId, 'product_type': productType},
    );
  }

  void logPurchaseCompleted({
    required String productId,
    required String productType,
    required double price,
    required String currency,
  }) {
    _analytics.logEvent(
      name: 'purchase_completed',
      parameters: {
        'product_id': productId,
        'product_type': productType,
        'price': price,
        'currency': currency,
      },
    );
  }

  void logPurchaseFailed({required String productId, required String reason}) {
    _analytics.logEvent(
      name: 'purchase_failed',
      parameters: {'product_id': productId, 'reason': reason},
    );
  }

  void logPurchaseRestored({required int restoredCount}) {
    _analytics.logEvent(
      name: 'purchase_restored',
      parameters: {'restored_count': restoredCount},
    );
  }

  void logAdDisplayed({required String adType, required String adPlacement}) {
    _analytics.logEvent(
      name: 'ad_displayed',
      parameters: {'ad_type': adType, 'ad_placement': adPlacement},
    );
  }

  void logRewardedAdWatchClicked() {
    _analytics.logEvent(name: 'rewarded_ad_watch_clicked', parameters: {});
  }

  void logRewardedAdRewardEarned() {
    _analytics.logEvent(name: 'rewarded_ad_reward_earned', parameters: {});
  }

  void logRewardedAdFailed({required String reason}) {
    _analytics.logEvent(
      name: 'rewarded_ad_failed',
      parameters: {'reason': reason},
    );
  }

  void logAdClicked({required String adType, required String adPlacement}) {
    _analytics.logEvent(
      name: 'ad_clicked',
      parameters: {'ad_type': adType, 'ad_placement': adPlacement},
    );
  }

  void logAdLoadFailed({required String adType, required String reason}) {
    _analytics.logEvent(
      name: 'ad_load_failed',
      parameters: {'ad_type': adType, 'reason': reason},
    );
  }

  void logThemeChanged({required String theme}) {
    _analytics.logEvent(name: 'theme_changed', parameters: {'theme': theme});
  }

  void logSettingsOpened() {
    _analytics.logEvent(name: 'settings_opened', parameters: {});
  }

  void logTutorialStarted() {
    _analytics.logEvent(name: 'tutorial_started', parameters: {});
  }

  void logTutorialCompleted() {
    _analytics.logEvent(name: 'tutorial_completed', parameters: {});
  }

  void logOnboardingStarted() {
    _analytics.logEvent(name: 'onboarding_started', parameters: {});
  }

  void logOnboardingCompleted() {
    _analytics.logEvent(name: 'onboarding_completed', parameters: {});
  }

  void logPermissionRequested({required String permissionType}) {
    _analytics.logEvent(
      name: 'permission_requested',
      parameters: {'permission_type': permissionType},
    );
  }

  void logPermissionGranted({required String permissionType}) {
    _analytics.logEvent(
      name: 'permission_granted',
      parameters: {'permission_type': permissionType},
    );
  }

  void logPermissionDenied({required String permissionType}) {
    _analytics.logEvent(
      name: 'permission_denied',
      parameters: {'permission_type': permissionType},
    );
  }

  void logSearchPerformed({
    required String searchTerm,
    required int resultsCount,
  }) {
    _analytics.logEvent(
      name: 'search_performed',
      parameters: {'search_term': searchTerm, 'results_count': resultsCount},
    );
  }

  void logAppRated({required double rating}) {
    _analytics.logEvent(name: 'app_rated', parameters: {'rating': rating});
  }

  void logFeedbackSubmitted({required String feedbackType}) {
    _analytics.logEvent(
      name: 'feedback_submitted',
      parameters: {'feedback_type': feedbackType},
    );
  }

  void logShareApp({required String shareMethod}) {
    _analytics.logEvent(
      name: 'share_app',
      parameters: {'share_method': shareMethod},
    );
  }

  void logHelpDocumentViewed({required String documentName}) {
    _analytics.logEvent(
      name: 'help_document_viewed',
      parameters: {'document_name': documentName},
    );
  }

  void logPrivacyPolicyViewed() {
    _analytics.logEvent(name: 'privacy_policy_viewed', parameters: {});
  }

  void logTermsOfServiceViewed() {
    _analytics.logEvent(name: 'terms_of_service_viewed', parameters: {});
  }

  void logError({
    required String errorType,
    required String errorMessage,
    String? stackTrace,
  }) {
    _analytics.logEvent(
      name: 'app_error',
      parameters: {
        'error_type': errorType,
        'error_message': errorMessage,
        // ignore: use_null_aware_elements
        if (stackTrace != null) 'stack_trace': stackTrace,
      },
    );
  }

  void logQuickRecordStarted() {
    _analytics.logEvent(name: 'quick_record_started', parameters: {});
  }

  void logCameraFlipped({required String cameraDirection}) {
    _analytics.logEvent(
      name: 'camera_flipped',
      parameters: {'camera_direction': cameraDirection},
    );
  }

  void logFlashToggled({required bool enabled}) {
    _analytics.logEvent(
      name: 'flash_toggled',
      parameters: {'enabled': enabled},
    );
  }

  void setUserId(String userId) {
    _analytics.setUserId(id: userId);
  }

  void setUserProperty({required String name, required String value}) {
    _analytics.setUserProperty(name: name, value: value);
  }

  void logNavigationEvent({required String from, required String to}) {
    _analytics.logEvent(
      name: 'navigation',
      parameters: {'from_screen': from, 'to_screen': to},
    );
  }
}
