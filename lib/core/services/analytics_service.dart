import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalytics get analytics => _analytics;
  FirebaseAnalyticsObserver get observer =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  void logEvent({required String name, Map<String, Object>? parameters}) {
    _analytics.logEvent(name: name, parameters: parameters);
  }

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
        'voice_sync_enabled': isVoiceSyncEnabled ? 1 : 0,
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
      parameters: {'enabled': enabled ? 1 : 0},
    );
  }

  void logMirrorTextToggled({required bool enabled}) {
    _analytics.logEvent(
      name: 'mirror_text_toggled',
      parameters: {'enabled': enabled ? 1 : 0},
    );
  }

  void logCountdownDurationChanged({required int duration}) {
    _analytics.logEvent(
      name: 'countdown_duration_changed',
      parameters: {'duration': duration},
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

  void logPremiumActivated() {
    _analytics.logEvent(name: 'premium_activated', parameters: {});
  }

  void logSubscriptionExpired() {
    _analytics.logEvent(name: 'subscription_expired', parameters: {});
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
      parameters: {'enabled': enabled ? 1 : 0},
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

  void logGoogleSignIn({required String email}) {
    _analytics.logEvent(name: 'google_sign_in', parameters: {'email': email});
  }

  void logGoogleSignOut() {
    _analytics.logEvent(name: 'google_sign_out', parameters: {});
  }

  void logGoogleSignInFailed({required String reason}) {
    _analytics.logEvent(
      name: 'google_sign_in_failed',
      parameters: {'reason': reason},
    );
  }

  void logBackupStarted({required int scriptCount, required int videoCount}) {
    _analytics.logEvent(
      name: 'backup_started',
      parameters: {'script_count': scriptCount, 'video_count': videoCount},
    );
  }

  void logBackupCompleted({
    required int scriptCount,
    required int videoCount,
    required int durationSeconds,
  }) {
    _analytics.logEvent(
      name: 'backup_completed',
      parameters: {
        'script_count': scriptCount,
        'video_count': videoCount,
        'duration_seconds': durationSeconds,
      },
    );
  }

  void logBackupFailed({required String reason}) {
    _analytics.logEvent(name: 'backup_failed', parameters: {'reason': reason});
  }

  void logRestoreStarted() {
    _analytics.logEvent(name: 'restore_started', parameters: {});
  }

  void logRestoreCompleted({
    required int scriptCount,
    required int videoCount,
  }) {
    _analytics.logEvent(
      name: 'restore_completed',
      parameters: {'script_count': scriptCount, 'video_count': videoCount},
    );
  }

  void logRestoreFailed({required String reason}) {
    _analytics.logEvent(name: 'restore_failed', parameters: {'reason': reason});
  }

  void logAutoBackupToggled({required bool enabled}) {
    _analytics.logEvent(
      name: 'auto_backup_toggled',
      parameters: {'enabled': enabled ? 1 : 0},
    );
  }

  void logBackupVideosToggled({required bool enabled}) {
    _analytics.logEvent(
      name: 'backup_videos_toggled',
      parameters: {'enabled': enabled ? 1 : 0},
    );
  }

  void logWifiOnlyBackupToggled({required bool enabled}) {
    _analytics.logEvent(
      name: 'wifi_only_backup_toggled',
      parameters: {'enabled': enabled ? 1 : 0},
    );
  }

  void logLanguageChanged({required String languageCode}) {
    _analytics.logEvent(
      name: 'language_changed',
      parameters: {'language_code': languageCode},
    );
  }

  void logFocusLineToggled({required bool enabled}) {
    _analytics.logEvent(
      name: 'focus_line_toggled',
      parameters: {'enabled': enabled ? 1 : 0},
    );
  }

  void logLineSpacingChanged({required double spacing}) {
    _analytics.logEvent(
      name: 'line_spacing_changed',
      parameters: {'spacing': spacing},
    );
  }

  void logVideoEdited({required String videoId}) {
    _analytics.logEvent(
      name: 'video_edited',
      parameters: {'video_id': videoId},
    );
  }

  void logScriptSearchCleared() {
    _analytics.logEvent(name: 'script_search_cleared', parameters: {});
  }

  void logScriptImported({required String source, required int wordCount}) {
    _analytics.logEvent(
      name: 'script_imported',
      parameters: {'source': source, 'word_count': wordCount},
    );
  }

  void logScriptExported({required String scriptId}) {
    _analytics.logEvent(
      name: 'script_exported',
      parameters: {'script_id': scriptId},
    );
  }

  void logScriptPasted({required int wordCount}) {
    _analytics.logEvent(
      name: 'script_pasted',
      parameters: {'word_count': wordCount},
    );
  }

  void logScriptPlatformChanged({
    required String scriptId,
    required String platform,
  }) {
    _analytics.logEvent(
      name: 'script_platform_changed',
      parameters: {'script_id': scriptId, 'platform': platform},
    );
  }

  void logEditorOpened({required bool isEditing}) {
    _analytics.logEvent(
      name: 'editor_opened',
      parameters: {'is_editing': isEditing ? 1 : 0},
    );
  }

  void logScriptRecordTapped({
    required String scriptId,
    required String category,
    required bool isPremium,
  }) {
    _analytics.logEvent(
      name: 'script_record_tapped',
      parameters: {
        'script_id': scriptId,
        'category': category,
        'is_premium': isPremium ? 1 : 0,
      },
    );
  }

  void logQuickRecordSubmitted({required int wordCount}) {
    _analytics.logEvent(
      name: 'quick_record_submitted',
      parameters: {'word_count': wordCount},
    );
  }

  void logTeleprompterScreenOpened({
    required String scriptId,
    required String scriptTitle,
  }) {
    _analytics.logEvent(
      name: 'teleprompter_screen_opened',
      parameters: {'script_id': scriptId, 'script_title': scriptTitle},
    );
  }

  void logTeleprompterPlayToggled({required bool isPlaying}) {
    _analytics.logEvent(
      name: 'teleprompter_play_toggled',
      parameters: {'is_playing': isPlaying ? 1 : 0},
    );
  }

  void logTeleprompterCompleted({
    required String scriptId,
    required int durationSeconds,
  }) {
    _analytics.logEvent(
      name: 'teleprompter_completed',
      parameters: {'script_id': scriptId, 'duration_seconds': durationSeconds},
    );
  }

  void logTeleprompterPaused({required int durationSeconds}) {
    _analytics.logEvent(
      name: 'teleprompter_paused',
      parameters: {'duration_seconds': durationSeconds},
    );
  }

  void logTextOrientationChanged({required int orientation}) {
    _analytics.logEvent(
      name: 'text_orientation_changed',
      parameters: {'orientation': orientation},
    );
  }

  void logVideoEditorOpened({required String videoId}) {
    _analytics.logEvent(
      name: 'video_editor_opened',
      parameters: {'video_id': videoId},
    );
  }

  void logVideoEditorTabChanged({required String tab}) {
    _analytics.logEvent(
      name: 'video_editor_tab_changed',
      parameters: {'tab': tab},
    );
  }

  void logVideoEditorExportStarted({
    required String quality,
    required double trimStart,
    required double trimEnd,
    required double playbackSpeed,
    required bool audioRemoved,
  }) {
    _analytics.logEvent(
      name: 'video_export_started',
      parameters: {
        'quality': quality,
        'trim_start': trimStart,
        'trim_end': trimEnd,
        'playback_speed': playbackSpeed,
        'audio_removed': audioRemoved ? 1 : 0,
      },
    );
  }

  void logVideoEditorExportCompleted({
    required int durationSeconds,
    required int fileSizeBytes,
  }) {
    _analytics.logEvent(
      name: 'video_export_completed',
      parameters: {
        'duration_seconds': durationSeconds,
        'file_size_bytes': fileSizeBytes,
      },
    );
  }

  void logVideoEditorExportFailed({required String reason}) {
    _analytics.logEvent(
      name: 'video_export_failed',
      parameters: {'reason': reason},
    );
  }

  void logVideoEditorDiscarded() {
    _analytics.logEvent(name: 'video_editor_discarded', parameters: {});
  }

  void logVideoRotated({required int degrees}) {
    _analytics.logEvent(
      name: 'video_rotated',
      parameters: {'degrees': degrees},
    );
  }

  void logVideoMirrored() {
    _analytics.logEvent(name: 'video_mirrored', parameters: {});
  }

  void logVideoAspectRatioChanged({required String ratio}) {
    _analytics.logEvent(
      name: 'video_aspect_ratio_changed',
      parameters: {'ratio': ratio},
    );
  }

  void logVideoPlaybackSpeedChanged({required double speed}) {
    _analytics.logEvent(
      name: 'video_playback_speed_changed',
      parameters: {'speed': speed},
    );
  }

  void logVideoAudioToggled({required bool audioRemoved}) {
    _analytics.logEvent(
      name: 'video_audio_toggled',
      parameters: {'audio_removed': audioRemoved ? 1 : 0},
    );
  }

  void logGalleryVideoOpened({required String videoId}) {
    _analytics.logEvent(
      name: 'gallery_video_opened',
      parameters: {'video_id': videoId},
    );
  }

  void logScriptSearchTyped({required String term, required int results}) {
    _analytics.logEvent(
      name: 'script_search_typed',
      parameters: {'term': term, 'results': results},
    );
  }

  void logAdGateTriggered({required int videoCount}) {
    _analytics.logEvent(
      name: 'ad_gate_triggered',
      parameters: {'video_count': videoCount},
    );
  }

  void logAdGateAction({required String action}) {
    _analytics.logEvent(name: 'ad_gate_action', parameters: {'action': action});
  }

  void logAdGateSuccess() {
    _analytics.logEvent(name: 'ad_gate_success', parameters: {});
  }
}
