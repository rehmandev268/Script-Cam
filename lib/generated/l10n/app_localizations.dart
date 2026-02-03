import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('zh'),
  ];

  /// The application title
  ///
  /// In en, this message translates to:
  /// **'ScriptCam'**
  String get appTitle;

  /// Title for the welcome onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Welcome to ScriptCam'**
  String get onboardingWelcomeTitle;

  /// Description for the welcome onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Your all-in-one Teleprompter studio. Write scripts, record videos, and edit seamlessly.'**
  String get onboardingWelcomeDesc;

  /// Title for the script editor onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Script Editor'**
  String get onboardingScriptEditorTitle;

  /// Description for the script editor onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Write and manage your video scripts with ease. Organize your ideas instantly.'**
  String get onboardingScriptEditorDesc;

  /// Title for the teleprompter onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Teleprompter'**
  String get onboardingTeleprompterTitle;

  /// Description for the teleprompter onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Read your script while looking directly at the camera. Professional recording made easy.'**
  String get onboardingTeleprompterDesc;

  /// Title for the permissions onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Enable Permissions'**
  String get onboardingPermissionsTitle;

  /// Description for the permissions onboarding screen
  ///
  /// In en, this message translates to:
  /// **'To record videos and sync your voice with the script, we need access to your camera and microphone.'**
  String get onboardingPermissionsDesc;

  /// Button to grant permissions
  ///
  /// In en, this message translates to:
  /// **'Grant Access'**
  String get grantAccess;

  /// Button to start using the app
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// Button to go to next screen
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Toast message when permissions are denied
  ///
  /// In en, this message translates to:
  /// **'Camera and Microphone permissions are required.'**
  String get permissionsRequired;

  /// Title for language selection screen
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// Description for language selection screen
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language for the app'**
  String get selectLanguageDesc;

  /// Button to continue to next screen
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// Settings screen title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Preferences section header
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// Help section header
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// Support section header
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// About section header
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Appearance settings label
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// Language settings label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// System default theme option
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// Light theme option
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// Dark theme option
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// System theme short label
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// Light theme short label
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// Dark theme short label
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// How to use menu item
  ///
  /// In en, this message translates to:
  /// **'How to Use'**
  String get howToUse;

  /// Share app menu item
  ///
  /// In en, this message translates to:
  /// **'Share App'**
  String get shareApp;

  /// Contact us menu item
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// Rate us menu item
  ///
  /// In en, this message translates to:
  /// **'Rate Us'**
  String get rateUs;

  /// Privacy policy menu item
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Version menu item
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// Premium upgrade banner title
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro'**
  String get upgradeToPro;

  /// Premium upgrade banner description
  ///
  /// In en, this message translates to:
  /// **'Unlock all features & remove ads'**
  String get unlockAllFeatures;

  /// Message when sharing the app
  ///
  /// In en, this message translates to:
  /// **'Record professional videos with confidence using ScriptCam! 🎥✨\n\nIt features a built-in Teleprompter, 4K recording, and Video Editor. Try it out here:\n{url}'**
  String shareAppMessage(String url);

  /// Subject when sharing the app
  ///
  /// In en, this message translates to:
  /// **'Check out ScriptCam: Video Teleprompter'**
  String get shareAppSubject;

  /// Morning greeting
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get goodMorning;

  /// Afternoon greeting
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get goodAfternoon;

  /// Evening greeting
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get goodEvening;

  /// Home screen tagline
  ///
  /// In en, this message translates to:
  /// **'Ready to create something\namazing?'**
  String get readyToCreate;

  /// New script action card title
  ///
  /// In en, this message translates to:
  /// **'New Script'**
  String get newScript;

  /// New script action card subtitle
  ///
  /// In en, this message translates to:
  /// **'Write from scratch'**
  String get writeFromScratch;

  /// Quick record action card title
  ///
  /// In en, this message translates to:
  /// **'Quick Record'**
  String get quickRecord;

  /// Quick record action card subtitle
  ///
  /// In en, this message translates to:
  /// **'Record on the fly'**
  String get recordOnTheFly;

  /// My scripts section header
  ///
  /// In en, this message translates to:
  /// **'My Scripts'**
  String get myScripts;

  /// Sort order label
  ///
  /// In en, this message translates to:
  /// **'Recent First'**
  String get recentFirst;

  /// Quick record dialog title
  ///
  /// In en, this message translates to:
  /// **'Quick Record'**
  String get quickRecordDialogTitle;

  /// Quick record dialog description
  ///
  /// In en, this message translates to:
  /// **'Enter script details below, or skip to open the camera without any text.'**
  String get quickRecordDialogDesc;

  /// Script title field label
  ///
  /// In en, this message translates to:
  /// **'Script Title'**
  String get scriptTitle;

  /// Script content field label
  ///
  /// In en, this message translates to:
  /// **'Script Content'**
  String get scriptContent;

  /// Script title field hint
  ///
  /// In en, this message translates to:
  /// **'e.g. YouTube Intro'**
  String get scriptTitleHint;

  /// Script content field hint
  ///
  /// In en, this message translates to:
  /// **'Paste your script content here...'**
  String get scriptContentHint;

  /// Start recording button
  ///
  /// In en, this message translates to:
  /// **'Start Recording'**
  String get startRecording;

  /// Edit script screen title
  ///
  /// In en, this message translates to:
  /// **'Edit Script'**
  String get editScript;

  /// Save button
  ///
  /// In en, this message translates to:
  /// **'SAVE'**
  String get save;

  /// Script title input placeholder
  ///
  /// In en, this message translates to:
  /// **'Script Title...'**
  String get scriptTitlePlaceholder;

  /// Script content input placeholder
  ///
  /// In en, this message translates to:
  /// **'Start writing your script here...'**
  String get scriptContentPlaceholder;

  /// Platform section label
  ///
  /// In en, this message translates to:
  /// **'PLATFORM'**
  String get platform;

  /// Toast when title is missing
  ///
  /// In en, this message translates to:
  /// **'Title required'**
  String get titleRequired;

  /// Toast when script is saved
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// Toast when script is created
  ///
  /// In en, this message translates to:
  /// **'Created!'**
  String get created;

  /// Toast when text is pasted
  ///
  /// In en, this message translates to:
  /// **'Text pasted'**
  String get textPasted;

  /// Toast when script is deleted
  ///
  /// In en, this message translates to:
  /// **'Script deleted'**
  String get scriptDeleted;

  /// Delete confirmation dialog title
  ///
  /// In en, this message translates to:
  /// **'Delete Script?'**
  String get deleteScriptTitle;

  /// Delete confirmation dialog message
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get deleteScriptMessage;

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Delete button
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// App info dialog title
  ///
  /// In en, this message translates to:
  /// **'ScriptCam'**
  String get appInfoTitle;

  /// App version in info dialog
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.3'**
  String get appInfoVersion;

  /// App description in info dialog
  ///
  /// In en, this message translates to:
  /// **'The ultimate teleprompter and video recording tool for content creators. Create, read, and record seamlessly.'**
  String get appInfoDescription;

  /// Close button
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Empty state for all scripts
  ///
  /// In en, this message translates to:
  /// **'No scripts yet'**
  String get emptyScriptsAll;

  /// Empty state description for all scripts
  ///
  /// In en, this message translates to:
  /// **'Create your first script to get started'**
  String get emptyScriptsAllDesc;

  /// Empty state for specific category
  ///
  /// In en, this message translates to:
  /// **'No {category} scripts'**
  String emptyScriptsCategory(String category);

  /// Empty state description for category
  ///
  /// In en, this message translates to:
  /// **'Create a script for this platform'**
  String get emptyScriptsCategoryDesc;

  /// Gallery screen title
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// Empty gallery state
  ///
  /// In en, this message translates to:
  /// **'No videos yet'**
  String get emptyGallery;

  /// Empty gallery state description
  ///
  /// In en, this message translates to:
  /// **'Record your first video to see it here'**
  String get emptyGalleryDesc;

  /// Teleprompter screen title
  ///
  /// In en, this message translates to:
  /// **'Teleprompter'**
  String get teleprompter;

  /// Record button
  ///
  /// In en, this message translates to:
  /// **'Record'**
  String get record;

  /// Stop button
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// Pause button
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// Resume button
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// Speed control label
  ///
  /// In en, this message translates to:
  /// **'Speed'**
  String get speed;

  /// Font size control label
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get fontSize;

  /// Mirror text toggle label
  ///
  /// In en, this message translates to:
  /// **'Mirror'**
  String get mirror;

  /// Voice sync toggle label
  ///
  /// In en, this message translates to:
  /// **'Voice Sync'**
  String get voiceSync;

  /// Auto scroll toggle label
  ///
  /// In en, this message translates to:
  /// **'Auto Scroll'**
  String get autoScroll;

  /// Video settings title
  ///
  /// In en, this message translates to:
  /// **'Video Settings'**
  String get videoSettings;

  /// Resolution setting label
  ///
  /// In en, this message translates to:
  /// **'Resolution'**
  String get resolution;

  /// Quality setting label
  ///
  /// In en, this message translates to:
  /// **'Quality'**
  String get quality;

  /// Premium screen title
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premium;

  /// Get premium button
  ///
  /// In en, this message translates to:
  /// **'Get Premium'**
  String get getPremium;

  /// Restore purchases button
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get restorePurchases;

  /// Video editor screen title
  ///
  /// In en, this message translates to:
  /// **'Video Editor'**
  String get videoEditor;

  /// Trim tab label
  ///
  /// In en, this message translates to:
  /// **'Trim'**
  String get trim;

  /// Adjust tab label
  ///
  /// In en, this message translates to:
  /// **'Adjust'**
  String get adjust;

  /// Filters tab label
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// Export button
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get export;

  /// Exporting progress message
  ///
  /// In en, this message translates to:
  /// **'Exporting...'**
  String get exporting;

  /// Export complete message
  ///
  /// In en, this message translates to:
  /// **'Export complete!'**
  String get exportComplete;

  /// Brightness adjustment label
  ///
  /// In en, this message translates to:
  /// **'Brightness'**
  String get brightness;

  /// Contrast adjustment label
  ///
  /// In en, this message translates to:
  /// **'Contrast'**
  String get contrast;

  /// Saturation adjustment label
  ///
  /// In en, this message translates to:
  /// **'Saturation'**
  String get saturation;

  /// Share button
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// Play button
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// All category label
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// General category label
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// Search placeholder
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Search scripts placeholder
  ///
  /// In en, this message translates to:
  /// **'Search scripts...'**
  String get searchScripts;

  /// Dashboard tab label
  ///
  /// In en, this message translates to:
  /// **'Studio'**
  String get studio;

  /// Empty state title when no scripts exist
  ///
  /// In en, this message translates to:
  /// **'Start Your Journey'**
  String get startYourJourney;

  /// Empty state title when search yields no results
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// Empty state description when search yields no results
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find any scripts matching your search. Try different keywords!'**
  String get noResultsMessage;

  /// Empty state description when no scripts exist
  ///
  /// In en, this message translates to:
  /// **'Your creative space is empty. Create your first script or try recording something on the fly!'**
  String get emptyCreativeSpaceMessage;

  /// Paste button
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get paste;

  /// Create new script button
  ///
  /// In en, this message translates to:
  /// **'Create New Script'**
  String get createNewScript;

  /// Platform selection description
  ///
  /// In en, this message translates to:
  /// **'Select a platform for your script'**
  String get selectPlatformDesc;

  /// Pro badge label
  ///
  /// In en, this message translates to:
  /// **'PRO'**
  String get pro;

  /// Minutes to read label
  ///
  /// In en, this message translates to:
  /// **'min read'**
  String get minRead;

  /// Word count label
  ///
  /// In en, this message translates to:
  /// **'words'**
  String get words;

  /// Edit menu item
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// How to use screen title
  ///
  /// In en, this message translates to:
  /// **'How to Use ScriptCam'**
  String get howToUseTitle;

  /// Step 1 title
  ///
  /// In en, this message translates to:
  /// **'Create a Script'**
  String get step1Title;

  /// Step 1 description
  ///
  /// In en, this message translates to:
  /// **'Start by creating a new script or quick record without text'**
  String get step1Desc;

  /// Step 2 title
  ///
  /// In en, this message translates to:
  /// **'Setup Teleprompter'**
  String get step2Title;

  /// Step 2 description
  ///
  /// In en, this message translates to:
  /// **'Adjust speed, font size, and enable voice sync for hands-free scrolling'**
  String get step2Desc;

  /// Step 3 title
  ///
  /// In en, this message translates to:
  /// **'Record Your Video'**
  String get step3Title;

  /// Step 3 description
  ///
  /// In en, this message translates to:
  /// **'Press record and read your script while looking at the camera'**
  String get step3Desc;

  /// Step 4 title
  ///
  /// In en, this message translates to:
  /// **'Edit & Share'**
  String get step4Title;

  /// Step 4 description
  ///
  /// In en, this message translates to:
  /// **'Use the video editor to trim, adjust, and apply filters before sharing'**
  String get step4Desc;

  /// Got it button
  ///
  /// In en, this message translates to:
  /// **'Got It'**
  String get gotIt;

  /// Delete video confirmation title
  ///
  /// In en, this message translates to:
  /// **'Delete Video?'**
  String get deleteVideoTitle;

  /// Video deleted toast message
  ///
  /// In en, this message translates to:
  /// **'Video deleted'**
  String get videoDeleted;

  /// Mute audio toggle
  ///
  /// In en, this message translates to:
  /// **'Mute'**
  String get mute;

  /// Opacity control label
  ///
  /// In en, this message translates to:
  /// **'Opacity'**
  String get opacity;

  /// Original filter/preset label
  ///
  /// In en, this message translates to:
  /// **'Original'**
  String get original;

  /// Processing message
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processing;

  /// Range control label
  ///
  /// In en, this message translates to:
  /// **'Range'**
  String get range;

  /// Aspect ratio label
  ///
  /// In en, this message translates to:
  /// **'Ratio'**
  String get ratio;

  /// Recording failed error message
  ///
  /// In en, this message translates to:
  /// **'Recording failed'**
  String get recordingFailed;

  /// Rotate control label
  ///
  /// In en, this message translates to:
  /// **'Rotate'**
  String get rotate;

  /// Target frames per second label
  ///
  /// In en, this message translates to:
  /// **'Target FPS'**
  String get targetFps;

  /// Transform tab label
  ///
  /// In en, this message translates to:
  /// **'Transform'**
  String get transform;

  /// Premium screen description
  ///
  /// In en, this message translates to:
  /// **'Unlock all premium features and enjoy an ad-free experience'**
  String get premiumDescription;

  /// Remove ads feature
  ///
  /// In en, this message translates to:
  /// **'Remove Ads'**
  String get removeAds;

  /// Unlimited scripts feature
  ///
  /// In en, this message translates to:
  /// **'Unlimited Scripts'**
  String get unlimitedScripts;

  /// Unlock creator pro title
  ///
  /// In en, this message translates to:
  /// **'Unlock Creator Pro'**
  String get unlockCreatorPro;

  /// Upgrade for lifetime button
  ///
  /// In en, this message translates to:
  /// **'Upgrade for Lifetime Access'**
  String get upgradeForLifetime;

  /// Restore purchase link text
  ///
  /// In en, this message translates to:
  /// **'Restore Purchase'**
  String get restorePurchaseLink;

  /// Title for the rewarded ad dialog
  ///
  /// In en, this message translates to:
  /// **'Watch Ad to Record'**
  String get watchAdToRecord;

  /// Description for the rewarded ad dialog
  ///
  /// In en, this message translates to:
  /// **'Watch a short ad to unlock recording for this script.'**
  String get watchAdToRecordDesc;

  /// Premium benefit highlight in ad dialog
  ///
  /// In en, this message translates to:
  /// **'Premium users get instant recording and Voice Sync!'**
  String get premiumBenefitInstantRecord;

  /// Title for the no internet screen
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get noInternetTitle;

  /// Description for the no internet screen
  ///
  /// In en, this message translates to:
  /// **'It seems you are offline. Please check your connection and try again.'**
  String get noInternetDesc;

  /// Retry button label
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Short message when voice sync is locked
  ///
  /// In en, this message translates to:
  /// **'Voice Sync is a Premium Feature'**
  String get voiceSyncLocked;

  /// Longer message when voice sync is locked
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro to enable hands-free voice-synced scrolling.'**
  String get voiceSyncLockedDesc;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'ja',
    'ko',
    'pt',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
