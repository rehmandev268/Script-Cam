// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'ScriptCam';

  @override
  String get onboardingWelcomeTitle => 'Welcome to ScriptCam';

  @override
  String get onboardingWelcomeDesc =>
      'Your all-in-one Teleprompter studio. Write scripts, record videos, and edit seamlessly.';

  @override
  String get onboardingScriptEditorTitle => 'Script Editor';

  @override
  String get onboardingScriptEditorDesc =>
      'Write and manage your video scripts with ease. Organize your ideas instantly.';

  @override
  String get onboardingTeleprompterTitle => 'Teleprompter';

  @override
  String get onboardingTeleprompterDesc =>
      'Read your script while looking directly at the camera. Professional recording made easy.';

  @override
  String get onboardingPermissionsTitle => 'Enable Permissions';

  @override
  String get onboardingPermissionsDesc =>
      'To record videos and sync your voice with the script, we need access to your camera and microphone.';

  @override
  String get grantAccess => 'Grant Access';

  @override
  String get start => 'Start';

  @override
  String get next => 'Next';

  @override
  String get permissionsRequired =>
      'Camera and Microphone permissions are required.';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get selectLanguageDesc => 'Choose your preferred language for the app';

  @override
  String get continueButton => 'Continue';

  @override
  String get settings => 'Settings';

  @override
  String get preferences => 'Preferences';

  @override
  String get help => 'Help';

  @override
  String get support => 'Support';

  @override
  String get about => 'About';

  @override
  String get appearance => 'Appearance';

  @override
  String get language => 'Language';

  @override
  String get systemDefault => 'System Default';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get system => 'System';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get howToUse => 'How to Use';

  @override
  String get shareApp => 'Share App';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get rateUs => 'Rate Us';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get version => 'Version';

  @override
  String get upgradeToPro => 'Upgrade to Pro';

  @override
  String get unlockAllFeatures => 'Unlock all features & remove ads';

  @override
  String shareAppMessage(String url) {
    return 'Record professional videos with confidence using ScriptCam! 🎥✨\n\nIt features a built-in Teleprompter, 4K recording, and Video Editor. Try it out here:\n$url';
  }

  @override
  String get shareAppSubject => 'Check out ScriptCam: Video Teleprompter';

  @override
  String get goodMorning => 'Good Morning';

  @override
  String get goodAfternoon => 'Good Afternoon';

  @override
  String get goodEvening => 'Good Evening';

  @override
  String get readyToCreate => 'Ready to create something\namazing?';

  @override
  String get newScript => 'New Script';

  @override
  String get writeFromScratch => 'Write from scratch';

  @override
  String get quickRecord => 'Quick Record';

  @override
  String get recordOnTheFly => 'Record on the fly';

  @override
  String get myScripts => 'My Scripts';

  @override
  String get recentFirst => 'Recent First';

  @override
  String get quickRecordDialogTitle => 'Quick Record';

  @override
  String get quickRecordDialogDesc =>
      'Enter script details below, or skip to open the camera without any text.';

  @override
  String get scriptTitle => 'Script Title';

  @override
  String get scriptContent => 'Script Content';

  @override
  String get scriptTitleHint => 'e.g. YouTube Intro';

  @override
  String get scriptContentHint => 'Paste your script content here...';

  @override
  String get startRecording => 'Start Recording';

  @override
  String get editScript => 'Edit Script';

  @override
  String get save => 'SAVE';

  @override
  String get scriptTitlePlaceholder => 'Script Title...';

  @override
  String get scriptContentPlaceholder => 'Start writing your script here...';

  @override
  String get platform => 'PLATFORM';

  @override
  String get titleRequired => 'Title required';

  @override
  String get saved => 'Saved';

  @override
  String get created => 'Created!';

  @override
  String get textPasted => 'Text pasted';

  @override
  String get scriptDeleted => 'Script deleted';

  @override
  String get deleteScriptTitle => 'Delete Script?';

  @override
  String get deleteScriptMessage => 'This action cannot be undone.';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get appInfoTitle => 'ScriptCam';

  @override
  String get appInfoVersion => 'Version 1.0.3';

  @override
  String get appInfoDescription =>
      'The ultimate teleprompter and video recording tool for content creators. Create, read, and record seamlessly.';

  @override
  String get close => 'Close';

  @override
  String get emptyScriptsAll => 'No scripts yet';

  @override
  String get emptyScriptsAllDesc => 'Create your first script to get started';

  @override
  String emptyScriptsCategory(String category) {
    return 'No $category scripts';
  }

  @override
  String get emptyScriptsCategoryDesc => 'Create a script for this platform';

  @override
  String get gallery => 'Gallery';

  @override
  String get emptyGallery => 'No videos yet';

  @override
  String get emptyGalleryDesc => 'Record your first video to see it here';

  @override
  String get teleprompter => 'Teleprompter';

  @override
  String get record => 'Record';

  @override
  String get stop => 'Stop';

  @override
  String get pause => 'Pause';

  @override
  String get resume => 'Resume';

  @override
  String get speed => 'Speed';

  @override
  String get fontSize => 'Font Size';

  @override
  String get mirror => 'Mirror';

  @override
  String get voiceSync => 'Voice Sync';

  @override
  String get autoScroll => 'Auto Scroll';

  @override
  String get videoSettings => 'Video Settings';

  @override
  String get resolution => 'Resolution';

  @override
  String get quality => 'Quality';

  @override
  String get premium => 'Premium';

  @override
  String get getPremium => 'Get Premium';

  @override
  String get restorePurchases => 'Restore Purchases';

  @override
  String get videoEditor => 'Video Editor';

  @override
  String get trim => 'Trim';

  @override
  String get adjust => 'Adjust';

  @override
  String get filters => 'Filters';

  @override
  String get export => 'Export';

  @override
  String get exporting => 'Exporting...';

  @override
  String get exportComplete => 'Export complete!';

  @override
  String get brightness => 'Brightness';

  @override
  String get contrast => 'Contrast';

  @override
  String get saturation => 'Saturation';

  @override
  String get share => 'Share';

  @override
  String get play => 'Play';

  @override
  String get all => 'All';

  @override
  String get general => 'General';

  @override
  String get search => 'Search';

  @override
  String get searchScripts => 'Search scripts...';

  @override
  String get studio => 'Studio';

  @override
  String get startYourJourney => 'Start Your Journey';

  @override
  String get noResultsFound => 'No results found';

  @override
  String get noResultsMessage =>
      'We couldn\'t find any scripts matching your search. Try different keywords!';

  @override
  String get emptyCreativeSpaceMessage =>
      'Your creative space is empty. Create your first script or try recording something on the fly!';

  @override
  String get paste => 'Paste';

  @override
  String get createNewScript => 'Create New Script';

  @override
  String get selectPlatformDesc => 'Select a platform for your script';

  @override
  String get pro => 'PRO';

  @override
  String get minRead => 'min read';

  @override
  String get words => 'words';

  @override
  String get edit => 'Edit';

  @override
  String get howToUseTitle => 'How to Use ScriptCam';

  @override
  String get step1Title => 'Create a Script';

  @override
  String get step1Desc =>
      'Start by creating a new script or quick record without text';

  @override
  String get step2Title => 'Setup Teleprompter';

  @override
  String get step2Desc =>
      'Adjust speed, font size, and enable voice sync for hands-free scrolling';

  @override
  String get step3Title => 'Record Your Video';

  @override
  String get step3Desc =>
      'Press record and read your script while looking at the camera';

  @override
  String get step4Title => 'Edit & Share';

  @override
  String get step4Desc =>
      'Use the video editor to trim, adjust, and apply filters before sharing';

  @override
  String get gotIt => 'Got It';

  @override
  String get deleteVideoTitle => 'Delete Video?';

  @override
  String get videoDeleted => 'Video deleted';

  @override
  String get mute => 'Mute';

  @override
  String get opacity => 'Opacity';

  @override
  String get original => 'Original';

  @override
  String get processing => 'Processing...';

  @override
  String get range => 'Range';

  @override
  String get ratio => 'Ratio';

  @override
  String get recordingFailed => 'Recording failed';

  @override
  String get rotate => 'Rotate';

  @override
  String get targetFps => 'Target FPS';

  @override
  String get transform => 'Transform';

  @override
  String get premiumDescription =>
      'Unlock all premium features and enjoy an ad-free experience';

  @override
  String get removeAds => 'Remove Ads';

  @override
  String get unlimitedScripts => 'Unlimited Scripts';

  @override
  String get unlockCreatorPro => 'Unlock Creator Pro';

  @override
  String get upgradeForLifetime => 'Upgrade for Lifetime Access';

  @override
  String get restorePurchaseLink => 'Restore Purchase';

  @override
  String get watchAdToRecord => 'Watch Ad to Record';

  @override
  String get watchAdToRecordDesc =>
      'Watch a short ad to unlock recording for this script.';

  @override
  String get premiumBenefitInstantRecord =>
      'Premium users get instant recording and Voice Sync!';

  @override
  String get noInternetTitle => 'No Internet Connection';

  @override
  String get noInternetDesc =>
      'It seems you are offline. Please check your connection and try again.';

  @override
  String get retry => 'Retry';

  @override
  String get voiceSyncLocked => 'Voice Sync is a Premium Feature';

  @override
  String get voiceSyncLockedDesc =>
      'Upgrade to Pro to enable hands-free voice-synced scrolling.';
}
