// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get about => 'About';

  @override
  String get addOrSelectScriptPrompt =>
      'Add or select a script to begin recording with teleprompter overlay.';

  @override
  String get adjust => 'Adjust';

  @override
  String get adNotAvailable => 'Ad unavailable';

  @override
  String get adNotAvailableDesc =>
      'We couldn\'t load an ad. Try again in a moment.';

  @override
  String get adNotCompleted => 'Ad not finished';

  @override
  String get adNotCompletedDesc =>
      'Watch the full ad to earn recording credits.';

  @override
  String get all => 'All';

  @override
  String get allScriptsTitle => 'All Scripts';

  @override
  String get appearance => 'Appearance';

  @override
  String get appInfoDescription =>
      'The ultimate teleprompter and video recording tool for content creators. Create, read, and record seamlessly.';

  @override
  String get appInfoTitle => 'ScriptCam';

  @override
  String get appTitle => 'ScriptCam';

  @override
  String get autoBackup => 'Automatic backup';

  @override
  String get autoSync => 'Auto Sync';

  @override
  String get backCamera => 'Back';

  @override
  String get background => 'Background';

  @override
  String backupFailedDetail(String error) {
    return 'Backup error: $error';
  }

  @override
  String get backupNow => 'Backup now';

  @override
  String get backupVideos => 'Backup videos';

  @override
  String bulkDeleteRecordingsTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Delete $count recordings?',
      one: 'Delete this recording?',
    );
    return '$_temp0';
  }

  @override
  String get cameraPreviewWithOverlay =>
      'Camera preview with live teleprompter overlay.';

  @override
  String get cancel => 'Cancel';

  @override
  String get close => 'Close';

  @override
  String get cloudBackup => 'Cloud Backup';

  @override
  String get connected => 'Connected';

  @override
  String get connectGoogleDrive => 'Connect Google Drive';

  @override
  String get connectionError =>
      'Connection error. Check your internet and try again.';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get continueButton => 'Continue';

  @override
  String get couldNotLoadVideo => 'Could not load video';

  @override
  String get countdownTimer => 'Countdown timer';

  @override
  String get created => 'Created!';

  @override
  String get createNewScript => 'Create New Script';

  @override
  String creditsRemaining(int count) {
    return 'Credits $count';
  }

  @override
  String get cueCards => 'Cue Cards';

  @override
  String currentCreditsDescription(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'You have $count free recordings left for this script.',
      one: 'You have 1 free recording left for this script.',
    );
    return '$_temp0';
  }

  @override
  String get dark => 'Dark';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get defaultCamera => 'Default camera';

  @override
  String get delete => 'Delete';

  @override
  String get deleteScriptMessage => 'This action cannot be undone.';

  @override
  String get deleteScriptTitle => 'Delete Script?';

  @override
  String get deleteVideoTitle => 'Delete Video?';

  @override
  String get discard => 'Discard';

  @override
  String get discardChanges => 'Discard changes?';

  @override
  String get discardChangesDesc => 'Your edits will be lost.';

  @override
  String get disconnect => 'Disconnect';

  @override
  String get discountBadge => '20% OFF';

  @override
  String get duplicate => 'Duplicate';

  @override
  String durationMinutesSecondsShort(int minutes, int seconds) {
    return '$minutes:$seconds';
  }

  @override
  String durationSecondsShort(int seconds) {
    return '${seconds}s';
  }

  @override
  String get earnRecordingCredits => 'Earn Recording Credits';

  @override
  String get edit => 'Edit';

  @override
  String get editScript => 'Edit Script';

  @override
  String get editScriptBlockedDuringCountdown =>
      'Wait for countdown to finish before editing.';

  @override
  String get editScriptBlockedWhileRecording =>
      'Stop recording to edit your script.';

  @override
  String get emptyCreativeSpaceMessage =>
      'Your creative space is empty. Create your first script or try recording something on the fly!';

  @override
  String get emptyGallery => 'No videos yet';

  @override
  String get emptyGalleryDesc => 'Record your first video to see it here';

  @override
  String errorSharingVideo(String error) {
    return 'Could not share video: $error';
  }

  @override
  String exportedScriptSubject(String title) {
    return 'Exported Script: $title';
  }

  @override
  String get exportQuality => 'Export quality';

  @override
  String get exportSuccess => 'Script exported successfully';

  @override
  String get focusLine => 'Focus line';

  @override
  String get font => 'Font';

  @override
  String get fontSize => 'Font Size';

  @override
  String freeRecordingsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count free recordings left',
      one: '1 free recording left',
    );
    return '$_temp0';
  }

  @override
  String get freeTrialCancelAnytime =>
      'Free trial starts immediately. Cancel anytime before renewal.';

  @override
  String get frontCamera => 'Front';

  @override
  String get fullDuration => 'Full';

  @override
  String get general => 'General';

  @override
  String get getPremium => 'Get Premium';

  @override
  String get googleUser => 'Google User';

  @override
  String get goPremium => 'Go Premium';

  @override
  String get gotIt => 'Got It';

  @override
  String get grantAccess => 'Grant Access';

  @override
  String get help => 'Help';

  @override
  String get highQualityVideo => 'High Quality Video';

  @override
  String get howToUse => 'How to Use';

  @override
  String get howToUseTitle => 'How to Use ScriptCam';

  @override
  String get importScript => 'Import';

  @override
  String get importSuccess => 'Script imported successfully';

  @override
  String itemsSelected(int count) {
    return '$count selected';
  }

  @override
  String get keepEditing => 'Keep editing';

  @override
  String get language => 'Language';

  @override
  String get lifetimeNoRecurringBilling =>
      'Lifetime unlock. No recurring billing.';

  @override
  String get lifetimeOneTimeUnlock =>
      'One-time purchase. Pay once, unlock forever.';

  @override
  String get lifetimePlan => 'Lifetime Plan';

  @override
  String get lifetimePriceNotLoaded =>
      'Lifetime price not loaded from store yet.';

  @override
  String get light => 'Light';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get lineSpacing => 'Line spacing';

  @override
  String get loop => 'Loop';

  @override
  String get managePremiumStatus => 'Manage your premium status';

  @override
  String get minRead => 'min read';

  @override
  String get mirror => 'Mirror';

  @override
  String get mute => 'Mute';

  @override
  String get never => 'Never';

  @override
  String get newScript => 'New Script';

  @override
  String get newScriptMultiline => 'New\nScript';

  @override
  String get next => 'Next';

  @override
  String get noAds => 'No Ads Forever';

  @override
  String get noInternetDesc =>
      'It seems you are offline. Please check your connection and try again.';

  @override
  String get noInternetError => 'No internet';

  @override
  String get noInternetErrorDesc => 'Connect to the internet and try again.';

  @override
  String get noInternetTitle => 'No Internet Connection';

  @override
  String get noRecordingsLeft => 'No recordings left · Watch an ad to continue';

  @override
  String get noResultsFound => 'No results found';

  @override
  String get noResultsMessage =>
      'We couldn\'t find any scripts matching your search. Try different keywords!';

  @override
  String get noSavedScriptSelected => 'No saved script selected';

  @override
  String get notAuthenticated => 'Not signed in to Google.';

  @override
  String get off => 'Off';

  @override
  String get onboardingAccessCamera => 'Camera';

  @override
  String get onboardingAccessMic => 'Microphone';

  @override
  String get onboardingInteractiveRecLabel => 'REC';

  @override
  String get onboardingInteractiveStep1Eyebrow => 'Main view';

  @override
  String get onboardingInteractiveStep1Preview =>
      'Overlay script and framing stay visible together. Scroll to rehearse; start recording when pacing feels right.';

  @override
  String get onboardingInteractiveStep1Subtitle =>
      'ScriptCam centers on capture. Scripts, credits, and settings stay reachable without crowding what you film.';

  @override
  String get onboardingInteractiveStep1Title => 'Recording-first workspace';

  @override
  String get onboardingInteractiveStep2Sample =>
      'Good morning—thanks for being here.\nWe will keep this brief and practical.\nIf you drift from the lens, settle back deliberately and carry on.';

  @override
  String get onboardingInteractiveStep2Subtitle =>
      'Pause rehearsal with one tap. Adjust scroll pacing and text size from the recording screen when you rehearse or shoot.';

  @override
  String get onboardingInteractiveStep2Title => 'Teleprompter overlay';

  @override
  String get onboardingInteractiveStep4CardHint =>
      'You can change these anytime in Android or iOS settings.';

  @override
  String get onboardingInteractiveStep4Subtitle =>
      'ScriptCam needs camera and microphone so you can see yourself while the script stays in sync with your pace.';

  @override
  String get onboardingInteractiveStep4Title => 'Recording access';

  @override
  String get opacity => 'Opacity';

  @override
  String get original => 'Original';

  @override
  String get overlaySettings => 'Overlay Settings';

  @override
  String get paste => 'Paste';

  @override
  String get permissionsRequired =>
      'Camera and Microphone permissions are required.';

  @override
  String get preferences => 'Preferences';

  @override
  String get premium => 'Premium';

  @override
  String get premiumActive => 'Premium Active';

  @override
  String get premiumBenefitInstantRecord =>
      'Premium users get instant recording and Voice Sync!';

  @override
  String get premiumDescription =>
      'Unlock all premium features and enjoy an ad-free experience';

  @override
  String get premiumUnlocked => 'Premium unlocked!';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get pro => 'PRO';

  @override
  String get processing => 'Processing...';

  @override
  String purchaseErrorDetail(String p0) {
    return 'Purchase failed: $p0';
  }

  @override
  String get purchaseFailedInitiate => 'Could not start purchase. Try again.';

  @override
  String get qualityHigh => 'High';

  @override
  String get qualityLabel => 'Quality';

  @override
  String get qualityLow => 'Low';

  @override
  String get qualityStandard => 'Standard';

  @override
  String get range => 'Range';

  @override
  String get rateUs => 'Rate Us';

  @override
  String get ratio => 'Ratio';

  @override
  String get recent => 'Recent';

  @override
  String get recordingFailed => 'Recording failed';

  @override
  String recordingsDeletedToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count recordings deleted',
      one: '1 recording deleted',
    );
    return '$_temp0';
  }

  @override
  String recordingsRemainingHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 's',
      one: '',
    );
    return '$count recording$_temp0 remaining · Watch an ad for more';
  }

  @override
  String get recordNow => 'Record now';

  @override
  String get remoteControl => 'Bluetooth Remote & Keyboard';

  @override
  String get remoteControlLocked =>
      'Bluetooth Remote & Keyboard is a Premium Feature';

  @override
  String get removeAds => 'Remove Ads';

  @override
  String get rename => 'Rename';

  @override
  String get resolution => 'Resolution';

  @override
  String get restore => 'Restore';

  @override
  String get restoredSuccessfully => 'Purchases restored successfully.';

  @override
  String restoreFailed(String error) {
    return 'Restore failed: $error';
  }

  @override
  String get restorePurchaseLink => 'Restore Purchase';

  @override
  String get retry => 'Retry';

  @override
  String get rewardGranted => 'Reward granted: +3 recordings';

  @override
  String get rotate => 'Rotate';

  @override
  String get save => 'SAVE';

  @override
  String get saveButton => 'Save';

  @override
  String get saved => 'Saved';

  @override
  String savedAs(String p0) {
    return 'Saved as $p0';
  }

  @override
  String get saveEditorLabel => 'Save';

  @override
  String get saveFailed => 'Save failed';

  @override
  String get saveFailedEmpty => 'Nothing to save';

  @override
  String get saveFailedGallery => 'Could not save to gallery';

  @override
  String get saveFailedNotFound => 'Save location not found';

  @override
  String get saveVideo => 'Save video';

  @override
  String get savingEllipsis => 'Saving…';

  @override
  String get scriptContentPlaceholder => 'Start writing your script here...';

  @override
  String get scriptDeleted => 'Script deleted';

  @override
  String scriptSummary(String p0, String p1) {
    return '$p0 · $p1';
  }

  @override
  String get scriptTitleHint => 'e.g. YouTube Intro';

  @override
  String get scriptTitlePlaceholder => 'Script Title...';

  @override
  String get scrollSpeed => 'Scroll Speed';

  @override
  String get searchScripts => 'Search scripts...';

  @override
  String get selectedScriptReady => 'Selected script ready';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get selectLanguageDesc => 'Choose your preferred language for the app';

  @override
  String get selectPlatformDesc => 'Select a platform for your script';

  @override
  String get settings => 'Settings';

  @override
  String get shareApp => 'Share App';

  @override
  String shareAppMessage(String url) {
    return 'Record professional videos with confidence using ScriptCam! 🎥✨\n\nIt features a built-in Teleprompter, 4K recording, and Video Editor. Try it out here:\n$url';
  }

  @override
  String get shareAppSubject => 'Check out ScriptCam: Video Teleprompter';

  @override
  String get shareVideoSubject => 'Check out my video';

  @override
  String get shareVideoText => 'Video recorded with ScriptCam';

  @override
  String get signInCancelled => 'Sign-in was cancelled.';

  @override
  String get softStart => 'Soft Start';

  @override
  String get speed => 'Speed';

  @override
  String get speedFast => 'Fast';

  @override
  String get speedNormal => 'Normal';

  @override
  String get speedSlow => 'Slow';

  @override
  String get speedTurbo => 'Turbo';

  @override
  String get startFreeTrial => 'Start Free Trial';

  @override
  String get startRecording => 'Start Recording';

  @override
  String get startYourJourney => 'Start Your Journey';

  @override
  String get step1Desc =>
      'Start by creating a new script or quick record without text';

  @override
  String get step1Title => 'Create a Script';

  @override
  String get step2Desc =>
      'Adjust speed, font size, and enable voice sync for hands-free scrolling';

  @override
  String get step2Title => 'Setup Teleprompter';

  @override
  String get step3Desc =>
      'Press record and read your script while looking at the camera';

  @override
  String get step3Title => 'Record Your Video';

  @override
  String get step4Desc =>
      'Use the video editor to trim, adjust, and apply filters before sharing';

  @override
  String get step4Title => 'Edit & Share';

  @override
  String get step5Desc =>
      'Use a Bluetooth remote or keyboard to play, pause, and adjust scroll speed.';

  @override
  String get step5Title => 'Remote control';

  @override
  String get storePricingUnavailable => 'Store pricing unavailable right now.';

  @override
  String get storeUnavailable => 'Store is unavailable. Try again later.';

  @override
  String get stripView => 'Strip view';

  @override
  String get studioEditor => 'Studio Editor';

  @override
  String get support => 'Support';

  @override
  String get supportBody => 'Hi ScriptCam team,\n\n';

  @override
  String get supportSubject => 'ScriptCam support';

  @override
  String get switchAccount => 'Switch account';

  @override
  String get system => 'System';

  @override
  String get systemDefault => 'System Default';

  @override
  String get tabCamera => 'Camera';

  @override
  String get tabRecordings => 'Recordings';

  @override
  String get tabScripts => 'Scripts';

  @override
  String get targetFps => 'Target FPS';

  @override
  String get text => 'Text';

  @override
  String get textPasted => 'Text pasted';

  @override
  String get titleRequired => 'Title required';

  @override
  String get transform => 'Transform';

  @override
  String get trim => 'Trim';

  @override
  String get unexpectedError => 'Something went wrong';

  @override
  String get unexpectedErrorDesc => 'Something went wrong. Please try again.';

  @override
  String get unlimitedRecordings => 'Unlimited Recordings';

  @override
  String get unlimitedScripts => 'Unlimited Scripts';

  @override
  String get unlockAllFeatures => 'Unlock all features & remove ads';

  @override
  String get unlockCreatorPro => 'Unlock Creator Pro';

  @override
  String get untitledScript => 'Untitled Script';

  @override
  String get upgradeForLifetime => 'Upgrade for Lifetime Access';

  @override
  String get upgradeToPro => 'Upgrade to Pro';

  @override
  String get useASavedScript => 'Use a saved script';

  @override
  String get version => 'Version';

  @override
  String get videoDeleted => 'Video deleted';

  @override
  String get videoFileNotFound => 'Video file not found';

  @override
  String get videoName => 'File name';

  @override
  String get videoNameHint => 'MyVideo';

  @override
  String get videoSettings => 'Video Settings';

  @override
  String get voiceSync => 'Voice Sync';

  @override
  String get voiceSyncFeature => 'Voice Sync';

  @override
  String get voiceSyncLocked => 'Voice Sync is a Premium Feature';

  @override
  String get watchAdGetRecordings => 'Watch 1 Ad → Get +3 Recordings';

  @override
  String get watchAdToRecord => 'Watch Ad to Record';

  @override
  String get watchAdToRecordDesc =>
      'Watch a short ad to unlock recording for this script.';

  @override
  String get weeklyPlan => 'Weekly';

  @override
  String get weeklyPriceNotLoaded => 'Weekly price not loaded from store yet.';

  @override
  String get weeklyTrialStorePrice =>
      '3-day free trial, weekly price from store';

  @override
  String weeklyTrialThenPrice(String price) {
    return '3-day free trial, then $price / week';
  }

  @override
  String get whatAreYouRecording => 'What are you\nrecording today?';

  @override
  String get width => 'Width';

  @override
  String get widthFull => 'Full';

  @override
  String get widthMedium => 'Medium';

  @override
  String get widthNarrow => 'Narrow';

  @override
  String get wifiOnly => 'Wi‑Fi only';

  @override
  String wordCountShort(int count) {
    return '$count words';
  }

  @override
  String get words => 'words';

  @override
  String get youAreNowPremium => 'You\'re now Premium!';
}
