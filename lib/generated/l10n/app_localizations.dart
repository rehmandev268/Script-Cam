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
import 'app_localizations_ur.dart';
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
    Locale('ur'),
    Locale('zh'),
  ];

  /// About section header
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Fallback script content prompt
  ///
  /// In en, this message translates to:
  /// **'Add or select a script to begin recording with teleprompter overlay.'**
  String get addOrSelectScriptPrompt;

  /// Adjust tab label
  ///
  /// In en, this message translates to:
  /// **'Adjust'**
  String get adjust;

  /// Ad error title
  ///
  /// In en, this message translates to:
  /// **'Ad unavailable'**
  String get adNotAvailable;

  /// Ad error description on sheet
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t load an ad. Try again in a moment.'**
  String get adNotAvailableDesc;

  /// When user closed ad early
  ///
  /// In en, this message translates to:
  /// **'Ad not finished'**
  String get adNotCompleted;

  /// Description when ad incomplete
  ///
  /// In en, this message translates to:
  /// **'Watch the full ad to earn recording credits.'**
  String get adNotCompletedDesc;

  /// All category label
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// Bottom sheet title for scripts picker
  ///
  /// In en, this message translates to:
  /// **'All Scripts'**
  String get allScriptsTitle;

  /// Appearance settings label
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// App description in info dialog
  ///
  /// In en, this message translates to:
  /// **'The ultimate teleprompter and video recording tool for content creators. Create, read, and record seamlessly.'**
  String get appInfoDescription;

  /// App info dialog title
  ///
  /// In en, this message translates to:
  /// **'ScriptCam'**
  String get appInfoTitle;

  /// The application title
  ///
  /// In en, this message translates to:
  /// **'ScriptCam'**
  String get appTitle;

  /// Auto backup toggle title
  ///
  /// In en, this message translates to:
  /// **'Automatic backup'**
  String get autoBackup;

  /// Auto sync switch label
  ///
  /// In en, this message translates to:
  /// **'Auto Sync'**
  String get autoSync;

  /// Back camera option label
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backCamera;

  /// Background color row label
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get background;

  /// No description provided for @backupFailedDetail.
  ///
  /// In en, this message translates to:
  /// **'Backup error: {error}'**
  String backupFailedDetail(String error);

  /// Trigger backup action
  ///
  /// In en, this message translates to:
  /// **'Backup now'**
  String get backupNow;

  /// Include videos in backup toggle
  ///
  /// In en, this message translates to:
  /// **'Backup videos'**
  String get backupVideos;

  /// Confirm bulk delete from gallery
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Delete this recording?} other{Delete {count} recordings?}}'**
  String bulkDeleteRecordingsTitle(int count);

  /// Camera mode helper description text
  ///
  /// In en, this message translates to:
  /// **'Camera preview with live teleprompter overlay.'**
  String get cameraPreviewWithOverlay;

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Close button
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Google Drive backup section title and premium feature
  ///
  /// In en, this message translates to:
  /// **'Cloud Backup'**
  String get cloudBackup;

  /// Drive connected status
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connected;

  /// Backup connect drive tile
  ///
  /// In en, this message translates to:
  /// **'Connect Google Drive'**
  String get connectGoogleDrive;

  /// IAP connection error toast
  ///
  /// In en, this message translates to:
  /// **'Connection error. Check your internet and try again.'**
  String get connectionError;

  /// Contact us menu item
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// Button to continue to next screen
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// Editor error title
  ///
  /// In en, this message translates to:
  /// **'Could not load video'**
  String get couldNotLoadVideo;

  /// Video settings countdown section
  ///
  /// In en, this message translates to:
  /// **'Countdown timer'**
  String get countdownTimer;

  /// Toast when script is created
  ///
  /// In en, this message translates to:
  /// **'Created!'**
  String get created;

  /// Create new script button
  ///
  /// In en, this message translates to:
  /// **'Create New Script'**
  String get createNewScript;

  /// Badge text for remaining credits
  ///
  /// In en, this message translates to:
  /// **'Credits {count}'**
  String creditsRemaining(int count);

  /// Cue cards mode label
  ///
  /// In en, this message translates to:
  /// **'Cue Cards'**
  String get cueCards;

  /// No description provided for @currentCreditsDescription.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{You have 1 free recording left for this script.} other{You have {count} free recordings left for this script.}}'**
  String currentCreditsDescription(int count);

  /// Dark theme short label
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// Dark theme option
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// Settings label for default camera
  ///
  /// In en, this message translates to:
  /// **'Default camera'**
  String get defaultCamera;

  /// Delete button
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Delete confirmation dialog message
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get deleteScriptMessage;

  /// Delete confirmation dialog title
  ///
  /// In en, this message translates to:
  /// **'Delete Script?'**
  String get deleteScriptTitle;

  /// Delete video confirmation title
  ///
  /// In en, this message translates to:
  /// **'Delete Video?'**
  String get deleteVideoTitle;

  /// Discard edits
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discard;

  /// Exit editor dialog title
  ///
  /// In en, this message translates to:
  /// **'Discard changes?'**
  String get discardChanges;

  /// Exit editor dialog body
  ///
  /// In en, this message translates to:
  /// **'Your edits will be lost.'**
  String get discardChangesDesc;

  /// Disconnect Google Drive
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get disconnect;

  /// Discount badge text
  ///
  /// In en, this message translates to:
  /// **'20% OFF'**
  String get discountBadge;

  /// Duplicate action label
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get duplicate;

  /// No description provided for @durationMinutesSecondsShort.
  ///
  /// In en, this message translates to:
  /// **'{minutes}:{seconds}'**
  String durationMinutesSecondsShort(int minutes, int seconds);

  /// No description provided for @durationSecondsShort.
  ///
  /// In en, this message translates to:
  /// **'{seconds}s'**
  String durationSecondsShort(int seconds);

  /// Ad gate title when user has credits
  ///
  /// In en, this message translates to:
  /// **'Earn Recording Credits'**
  String get earnRecordingCredits;

  /// Edit menu item
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Edit script screen title
  ///
  /// In en, this message translates to:
  /// **'Edit Script'**
  String get editScript;

  /// Toast when edit blocked during countdown
  ///
  /// In en, this message translates to:
  /// **'Wait for countdown to finish before editing.'**
  String get editScriptBlockedDuringCountdown;

  /// Toast when edit blocked during recording
  ///
  /// In en, this message translates to:
  /// **'Stop recording to edit your script.'**
  String get editScriptBlockedWhileRecording;

  /// Empty state description when no scripts exist
  ///
  /// In en, this message translates to:
  /// **'Your creative space is empty. Create your first script or try recording something on the fly!'**
  String get emptyCreativeSpaceMessage;

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

  /// No description provided for @errorSharingVideo.
  ///
  /// In en, this message translates to:
  /// **'Could not share video: {error}'**
  String errorSharingVideo(String error);

  /// Share subject when exporting a script
  ///
  /// In en, this message translates to:
  /// **'Exported Script: {title}'**
  String exportedScriptSubject(String title);

  /// Settings label for export quality
  ///
  /// In en, this message translates to:
  /// **'Export quality'**
  String get exportQuality;

  /// Toast after export
  ///
  /// In en, this message translates to:
  /// **'Script exported successfully'**
  String get exportSuccess;

  /// Teleprompter focus line toggle
  ///
  /// In en, this message translates to:
  /// **'Focus line'**
  String get focusLine;

  /// Font setting label
  ///
  /// In en, this message translates to:
  /// **'Font'**
  String get font;

  /// Font size control label
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get fontSize;

  /// No description provided for @freeRecordingsLeft.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 free recording left} other{{count} free recordings left}}'**
  String freeRecordingsLeft(int count);

  /// Legal note for weekly trial plan
  ///
  /// In en, this message translates to:
  /// **'Free trial starts immediately. Cancel anytime before renewal.'**
  String get freeTrialCancelAnytime;

  /// Front camera option label
  ///
  /// In en, this message translates to:
  /// **'Front'**
  String get frontCamera;

  /// Full duration preset label in editor timeline
  ///
  /// In en, this message translates to:
  /// **'Full'**
  String get fullDuration;

  /// General category label
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// Get premium button
  ///
  /// In en, this message translates to:
  /// **'Get Premium'**
  String get getPremium;

  /// Fallback display name for Google account
  ///
  /// In en, this message translates to:
  /// **'Google User'**
  String get googleUser;

  /// Button on teleprompter error sheet
  ///
  /// In en, this message translates to:
  /// **'Go Premium'**
  String get goPremium;

  /// Got it button
  ///
  /// In en, this message translates to:
  /// **'Got It'**
  String get gotIt;

  /// Button to grant permissions
  ///
  /// In en, this message translates to:
  /// **'Grant Access'**
  String get grantAccess;

  /// Help section header
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// Premium feature bullet
  ///
  /// In en, this message translates to:
  /// **'High Quality Video'**
  String get highQualityVideo;

  /// How to use menu item
  ///
  /// In en, this message translates to:
  /// **'How to Use'**
  String get howToUse;

  /// How to use screen title
  ///
  /// In en, this message translates to:
  /// **'How to Use ScriptCam'**
  String get howToUseTitle;

  /// Import script button in editor
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get importScript;

  /// Toast after import
  ///
  /// In en, this message translates to:
  /// **'Script imported successfully'**
  String get importSuccess;

  /// No description provided for @itemsSelected.
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String itemsSelected(int count);

  /// Stay in editor
  ///
  /// In en, this message translates to:
  /// **'Keep editing'**
  String get keepEditing;

  /// Language settings label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Legal note for lifetime plan
  ///
  /// In en, this message translates to:
  /// **'Lifetime unlock. No recurring billing.'**
  String get lifetimeNoRecurringBilling;

  /// Lifetime plan subtitle
  ///
  /// In en, this message translates to:
  /// **'One-time purchase. Pay once, unlock forever.'**
  String get lifetimeOneTimeUnlock;

  /// Lifetime purchase label
  ///
  /// In en, this message translates to:
  /// **'Lifetime Plan'**
  String get lifetimePlan;

  /// Price-not-loaded warning for lifetime plan
  ///
  /// In en, this message translates to:
  /// **'Lifetime price not loaded from store yet.'**
  String get lifetimePriceNotLoaded;

  /// Light theme short label
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// Light theme option
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// Teleprompter line spacing control
  ///
  /// In en, this message translates to:
  /// **'Line spacing'**
  String get lineSpacing;

  /// Loop toggle label
  ///
  /// In en, this message translates to:
  /// **'Loop'**
  String get loop;

  /// Settings link to premium details
  ///
  /// In en, this message translates to:
  /// **'Manage your premium status'**
  String get managePremiumStatus;

  /// Minutes to read label
  ///
  /// In en, this message translates to:
  /// **'min read'**
  String get minRead;

  /// Mirror text toggle label
  ///
  /// In en, this message translates to:
  /// **'Mirror'**
  String get mirror;

  /// Mute audio toggle
  ///
  /// In en, this message translates to:
  /// **'Mute'**
  String get mute;

  /// Never backed up / restored label
  ///
  /// In en, this message translates to:
  /// **'Never'**
  String get never;

  /// New script action card title
  ///
  /// In en, this message translates to:
  /// **'New Script'**
  String get newScript;

  /// Two-line label on script strip add card
  ///
  /// In en, this message translates to:
  /// **'New\nScript'**
  String get newScriptMultiline;

  /// Button to go to next screen
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Premium feature bullet
  ///
  /// In en, this message translates to:
  /// **'No Ads Forever'**
  String get noAds;

  /// Description for the no internet screen
  ///
  /// In en, this message translates to:
  /// **'It seems you are offline. Please check your connection and try again.'**
  String get noInternetDesc;

  /// Short error title
  ///
  /// In en, this message translates to:
  /// **'No internet'**
  String get noInternetError;

  /// No internet error description
  ///
  /// In en, this message translates to:
  /// **'Connect to the internet and try again.'**
  String get noInternetErrorDesc;

  /// Title for the no internet screen
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get noInternetTitle;

  /// When user has zero recording credits
  ///
  /// In en, this message translates to:
  /// **'No recordings left · Watch an ad to continue'**
  String get noRecordingsLeft;

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

  /// No selected script status text
  ///
  /// In en, this message translates to:
  /// **'No saved script selected'**
  String get noSavedScriptSelected;

  /// Backup when user not authenticated
  ///
  /// In en, this message translates to:
  /// **'Not signed in to Google.'**
  String get notAuthenticated;

  /// Countdown disabled option
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get off;

  /// Permission row label for camera
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get onboardingAccessCamera;

  /// Permission row label for microphone
  ///
  /// In en, this message translates to:
  /// **'Microphone'**
  String get onboardingAccessMic;

  /// Small recording badge on onboarding mock overlay
  ///
  /// In en, this message translates to:
  /// **'REC'**
  String get onboardingInteractiveRecLabel;

  /// Small label above onboarding mock preview
  ///
  /// In en, this message translates to:
  /// **'Main view'**
  String get onboardingInteractiveStep1Eyebrow;

  /// Muted text inside onboarding preview card
  ///
  /// In en, this message translates to:
  /// **'Overlay script and framing stay visible together. Scroll to rehearse; start recording when pacing feels right.'**
  String get onboardingInteractiveStep1Preview;

  /// Onboarding page 1 subtitle
  ///
  /// In en, this message translates to:
  /// **'ScriptCam centers on capture. Scripts, credits, and settings stay reachable without crowding what you film.'**
  String get onboardingInteractiveStep1Subtitle;

  /// Onboarding page 1 title
  ///
  /// In en, this message translates to:
  /// **'Recording-first workspace'**
  String get onboardingInteractiveStep1Title;

  /// Sample teleprompter lines in onboarding
  ///
  /// In en, this message translates to:
  /// **'Good morning—thanks for being here.\nWe will keep this brief and practical.\nIf you drift from the lens, settle back deliberately and carry on.'**
  String get onboardingInteractiveStep2Sample;

  /// Onboarding page 2 subtitle
  ///
  /// In en, this message translates to:
  /// **'Pause rehearsal with one tap. Adjust scroll pacing and text size from the recording screen when you rehearse or shoot.'**
  String get onboardingInteractiveStep2Subtitle;

  /// Onboarding page 2 title
  ///
  /// In en, this message translates to:
  /// **'Teleprompter overlay'**
  String get onboardingInteractiveStep2Title;

  /// Hint under permission rows on onboarding
  ///
  /// In en, this message translates to:
  /// **'You can change these anytime in Android or iOS settings.'**
  String get onboardingInteractiveStep4CardHint;

  /// Onboarding page 3 subtitle before permissions
  ///
  /// In en, this message translates to:
  /// **'ScriptCam needs camera and microphone so you can see yourself while the script stays in sync with your pace.'**
  String get onboardingInteractiveStep4Subtitle;

  /// Onboarding page 3 title before permissions
  ///
  /// In en, this message translates to:
  /// **'Recording access'**
  String get onboardingInteractiveStep4Title;

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

  /// Title of camera preview overlay settings sheet
  ///
  /// In en, this message translates to:
  /// **'Overlay Settings'**
  String get overlaySettings;

  /// Paste button
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get paste;

  /// Toast message when permissions are denied
  ///
  /// In en, this message translates to:
  /// **'Camera and Microphone permissions are required.'**
  String get permissionsRequired;

  /// Preferences section header
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// Premium screen title
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premium;

  /// Title when subscription is active
  ///
  /// In en, this message translates to:
  /// **'Premium Active'**
  String get premiumActive;

  /// Premium benefit highlight in ad dialog
  ///
  /// In en, this message translates to:
  /// **'Premium users get instant recording and Voice Sync!'**
  String get premiumBenefitInstantRecord;

  /// Premium screen description
  ///
  /// In en, this message translates to:
  /// **'Unlock all premium features and enjoy an ad-free experience'**
  String get premiumDescription;

  /// Toast after successful purchase
  ///
  /// In en, this message translates to:
  /// **'Premium unlocked!'**
  String get premiumUnlocked;

  /// Privacy policy menu item
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Pro badge label
  ///
  /// In en, this message translates to:
  /// **'PRO'**
  String get pro;

  /// Processing message
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processing;

  /// No description provided for @purchaseErrorDetail.
  ///
  /// In en, this message translates to:
  /// **'Purchase failed: {p0}'**
  String purchaseErrorDetail(String p0);

  /// IAP failed to start purchase
  ///
  /// In en, this message translates to:
  /// **'Could not start purchase. Try again.'**
  String get purchaseFailedInitiate;

  /// High export quality
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get qualityHigh;

  /// Export quality section
  ///
  /// In en, this message translates to:
  /// **'Quality'**
  String get qualityLabel;

  /// Low export quality
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get qualityLow;

  /// Standard export quality
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get qualityStandard;

  /// Range control label
  ///
  /// In en, this message translates to:
  /// **'Range'**
  String get range;

  /// Rate us menu item
  ///
  /// In en, this message translates to:
  /// **'Rate Us'**
  String get rateUs;

  /// Aspect ratio label
  ///
  /// In en, this message translates to:
  /// **'Ratio'**
  String get ratio;

  /// Recent scripts section title
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get recent;

  /// Recording failed error message
  ///
  /// In en, this message translates to:
  /// **'Recording failed'**
  String get recordingFailed;

  /// No description provided for @recordingsDeletedToast.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 recording deleted} other{{count} recordings deleted}}'**
  String recordingsDeletedToast(int count);

  /// No description provided for @recordingsRemainingHint.
  ///
  /// In en, this message translates to:
  /// **'{count} recording{count, plural, =1{} other{s}} remaining · Watch an ad for more'**
  String recordingsRemainingHint(int count);

  /// Primary CTA on recording intent zone
  ///
  /// In en, this message translates to:
  /// **'Record now'**
  String get recordNow;

  /// Premium feature line for Bluetooth remote and keyboard
  ///
  /// In en, this message translates to:
  /// **'Bluetooth Remote & Keyboard'**
  String get remoteControl;

  /// Toast when remote or keyboard controls require Premium
  ///
  /// In en, this message translates to:
  /// **'Bluetooth Remote & Keyboard is a Premium Feature'**
  String get remoteControlLocked;

  /// Remove ads feature
  ///
  /// In en, this message translates to:
  /// **'Remove Ads'**
  String get removeAds;

  /// Rename action label
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get rename;

  /// Resolution setting label
  ///
  /// In en, this message translates to:
  /// **'Resolution'**
  String get resolution;

  /// Restore from backup
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restore;

  /// Toast after restore
  ///
  /// In en, this message translates to:
  /// **'Purchases restored successfully.'**
  String get restoredSuccessfully;

  /// No description provided for @restoreFailed.
  ///
  /// In en, this message translates to:
  /// **'Restore failed: {error}'**
  String restoreFailed(String error);

  /// Restore purchase link text
  ///
  /// In en, this message translates to:
  /// **'Restore Purchase'**
  String get restorePurchaseLink;

  /// Retry button label
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Toast when ad reward granted
  ///
  /// In en, this message translates to:
  /// **'Reward granted: +3 recordings'**
  String get rewardGranted;

  /// Rotate control label
  ///
  /// In en, this message translates to:
  /// **'Rotate'**
  String get rotate;

  /// Save button
  ///
  /// In en, this message translates to:
  /// **'SAVE'**
  String get save;

  /// Confirm save in export dialog
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// Toast when script is saved
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @savedAs.
  ///
  /// In en, this message translates to:
  /// **'Saved as {p0}'**
  String savedAs(String p0);

  /// Editor save action label
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveEditorLabel;

  /// Generic save error
  ///
  /// In en, this message translates to:
  /// **'Save failed'**
  String get saveFailed;

  /// Save error empty output
  ///
  /// In en, this message translates to:
  /// **'Nothing to save'**
  String get saveFailedEmpty;

  /// Save error when gallery fails
  ///
  /// In en, this message translates to:
  /// **'Could not save to gallery'**
  String get saveFailedGallery;

  /// Save error path missing
  ///
  /// In en, this message translates to:
  /// **'Save location not found'**
  String get saveFailedNotFound;

  /// Export dialog title
  ///
  /// In en, this message translates to:
  /// **'Save video'**
  String get saveVideo;

  /// Save in progress label
  ///
  /// In en, this message translates to:
  /// **'Saving…'**
  String get savingEllipsis;

  /// Script content input placeholder
  ///
  /// In en, this message translates to:
  /// **'Start writing your script here...'**
  String get scriptContentPlaceholder;

  /// Toast when script is deleted
  ///
  /// In en, this message translates to:
  /// **'Script deleted'**
  String get scriptDeleted;

  /// No description provided for @scriptSummary.
  ///
  /// In en, this message translates to:
  /// **'{p0} · {p1}'**
  String scriptSummary(String p0, String p1);

  /// Script title field hint
  ///
  /// In en, this message translates to:
  /// **'e.g. YouTube Intro'**
  String get scriptTitleHint;

  /// Script title input placeholder
  ///
  /// In en, this message translates to:
  /// **'Script Title...'**
  String get scriptTitlePlaceholder;

  /// Scroll speed slider label
  ///
  /// In en, this message translates to:
  /// **'Scroll Speed'**
  String get scrollSpeed;

  /// Search scripts placeholder
  ///
  /// In en, this message translates to:
  /// **'Search scripts...'**
  String get searchScripts;

  /// Selected script status text
  ///
  /// In en, this message translates to:
  /// **'Selected script ready'**
  String get selectedScriptReady;

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

  /// Platform selection description
  ///
  /// In en, this message translates to:
  /// **'Select a platform for your script'**
  String get selectPlatformDesc;

  /// Settings screen title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Share app menu item
  ///
  /// In en, this message translates to:
  /// **'Share App'**
  String get shareApp;

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

  /// Share sheet subject
  ///
  /// In en, this message translates to:
  /// **'Check out my video'**
  String get shareVideoSubject;

  /// Share sheet message body
  ///
  /// In en, this message translates to:
  /// **'Video recorded with ScriptCam'**
  String get shareVideoText;

  /// Google sign-in cancelled for backup
  ///
  /// In en, this message translates to:
  /// **'Sign-in was cancelled.'**
  String get signInCancelled;

  /// Soft start toggle label
  ///
  /// In en, this message translates to:
  /// **'Soft Start'**
  String get softStart;

  /// Speed control label
  ///
  /// In en, this message translates to:
  /// **'Speed'**
  String get speed;

  /// Speed preset fast
  ///
  /// In en, this message translates to:
  /// **'Fast'**
  String get speedFast;

  /// Speed preset normal
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get speedNormal;

  /// Speed preset slow
  ///
  /// In en, this message translates to:
  /// **'Slow'**
  String get speedSlow;

  /// Speed preset turbo
  ///
  /// In en, this message translates to:
  /// **'Turbo'**
  String get speedTurbo;

  /// CTA for weekly trial plan
  ///
  /// In en, this message translates to:
  /// **'Start Free Trial'**
  String get startFreeTrial;

  /// Start recording button
  ///
  /// In en, this message translates to:
  /// **'Start Recording'**
  String get startRecording;

  /// Empty state title when no scripts exist
  ///
  /// In en, this message translates to:
  /// **'Start Your Journey'**
  String get startYourJourney;

  /// Step 1 description
  ///
  /// In en, this message translates to:
  /// **'Start by creating a new script or quick record without text'**
  String get step1Desc;

  /// Step 1 title
  ///
  /// In en, this message translates to:
  /// **'Create a Script'**
  String get step1Title;

  /// Step 2 description
  ///
  /// In en, this message translates to:
  /// **'Adjust speed, font size, and enable voice sync for hands-free scrolling'**
  String get step2Desc;

  /// Step 2 title
  ///
  /// In en, this message translates to:
  /// **'Setup Teleprompter'**
  String get step2Title;

  /// Step 3 description
  ///
  /// In en, this message translates to:
  /// **'Press record and read your script while looking at the camera'**
  String get step3Desc;

  /// Step 3 title
  ///
  /// In en, this message translates to:
  /// **'Record Your Video'**
  String get step3Title;

  /// Step 4 description
  ///
  /// In en, this message translates to:
  /// **'Use the video editor to trim, adjust, and apply filters before sharing'**
  String get step4Desc;

  /// Step 4 title
  ///
  /// In en, this message translates to:
  /// **'Edit & Share'**
  String get step4Title;

  /// How-to step 5 description
  ///
  /// In en, this message translates to:
  /// **'Use a Bluetooth remote or keyboard to play, pause, and adjust scroll speed.'**
  String get step5Desc;

  /// How-to step 5 title
  ///
  /// In en, this message translates to:
  /// **'Remote control'**
  String get step5Title;

  /// Message when product pricing cannot load
  ///
  /// In en, this message translates to:
  /// **'Store pricing unavailable right now.'**
  String get storePricingUnavailable;

  /// IAP store unavailable toast
  ///
  /// In en, this message translates to:
  /// **'Store is unavailable. Try again later.'**
  String get storeUnavailable;

  /// Toggle label for horizontal script strip
  ///
  /// In en, this message translates to:
  /// **'Strip view'**
  String get stripView;

  /// Video editor app bar title
  ///
  /// In en, this message translates to:
  /// **'Studio Editor'**
  String get studioEditor;

  /// Support section header
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// Email body prefix for support
  ///
  /// In en, this message translates to:
  /// **'Hi ScriptCam team,\n\n'**
  String get supportBody;

  /// Email subject for support
  ///
  /// In en, this message translates to:
  /// **'ScriptCam support'**
  String get supportSubject;

  /// Switch Google account
  ///
  /// In en, this message translates to:
  /// **'Switch account'**
  String get switchAccount;

  /// System theme short label
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// System default theme option
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// Bottom navigation: camera / studio
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get tabCamera;

  /// Bottom navigation: saved recordings
  ///
  /// In en, this message translates to:
  /// **'Recordings'**
  String get tabRecordings;

  /// Bottom navigation: scripts list
  ///
  /// In en, this message translates to:
  /// **'Scripts'**
  String get tabScripts;

  /// Target frames per second label
  ///
  /// In en, this message translates to:
  /// **'Target FPS'**
  String get targetFps;

  /// Text color row label
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get text;

  /// Toast when text is pasted
  ///
  /// In en, this message translates to:
  /// **'Text pasted'**
  String get textPasted;

  /// Toast when title is missing
  ///
  /// In en, this message translates to:
  /// **'Title required'**
  String get titleRequired;

  /// Transform tab label
  ///
  /// In en, this message translates to:
  /// **'Transform'**
  String get transform;

  /// Trim tab label
  ///
  /// In en, this message translates to:
  /// **'Trim'**
  String get trim;

  /// Generic error title
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get unexpectedError;

  /// Generic error description
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get unexpectedErrorDesc;

  /// Premium feature bullet
  ///
  /// In en, this message translates to:
  /// **'Unlimited Recordings'**
  String get unlimitedRecordings;

  /// Unlimited scripts feature
  ///
  /// In en, this message translates to:
  /// **'Unlimited Scripts'**
  String get unlimitedScripts;

  /// Premium upgrade banner description
  ///
  /// In en, this message translates to:
  /// **'Unlock all features & remove ads'**
  String get unlockAllFeatures;

  /// Unlock creator pro title
  ///
  /// In en, this message translates to:
  /// **'Unlock Creator Pro'**
  String get unlockCreatorPro;

  /// Fallback title for empty script
  ///
  /// In en, this message translates to:
  /// **'Untitled Script'**
  String get untitledScript;

  /// Upgrade for lifetime button
  ///
  /// In en, this message translates to:
  /// **'Upgrade for Lifetime Access'**
  String get upgradeForLifetime;

  /// Premium upgrade banner title
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro'**
  String get upgradeToPro;

  /// Toggle label for using saved script
  ///
  /// In en, this message translates to:
  /// **'Use a saved script'**
  String get useASavedScript;

  /// Version menu item
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// Video deleted toast message
  ///
  /// In en, this message translates to:
  /// **'Video deleted'**
  String get videoDeleted;

  /// Snackbar when file missing
  ///
  /// In en, this message translates to:
  /// **'Video file not found'**
  String get videoFileNotFound;

  /// Export file name label
  ///
  /// In en, this message translates to:
  /// **'File name'**
  String get videoName;

  /// Export file name hint
  ///
  /// In en, this message translates to:
  /// **'MyVideo'**
  String get videoNameHint;

  /// Video settings title
  ///
  /// In en, this message translates to:
  /// **'Video Settings'**
  String get videoSettings;

  /// Voice sync toggle label
  ///
  /// In en, this message translates to:
  /// **'Voice Sync'**
  String get voiceSync;

  /// Premium feature label on details screen
  ///
  /// In en, this message translates to:
  /// **'Voice Sync'**
  String get voiceSyncFeature;

  /// Short message when voice sync is locked
  ///
  /// In en, this message translates to:
  /// **'Voice Sync is a Premium Feature'**
  String get voiceSyncLocked;

  /// Ad gate premium-style bullet
  ///
  /// In en, this message translates to:
  /// **'Watch 1 Ad → Get +3 Recordings'**
  String get watchAdGetRecordings;

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

  /// Weekly plan title
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weeklyPlan;

  /// Price-not-loaded warning for weekly plan
  ///
  /// In en, this message translates to:
  /// **'Weekly price not loaded from store yet.'**
  String get weeklyPriceNotLoaded;

  /// Weekly plan subtitle when store price unavailable
  ///
  /// In en, this message translates to:
  /// **'3-day free trial, weekly price from store'**
  String get weeklyTrialStorePrice;

  /// Weekly plan subtitle with price
  ///
  /// In en, this message translates to:
  /// **'3-day free trial, then {price} / week'**
  String weeklyTrialThenPrice(String price);

  /// Recording intent zone headline
  ///
  /// In en, this message translates to:
  /// **'What are you\nrecording today?'**
  String get whatAreYouRecording;

  /// Column width row label
  ///
  /// In en, this message translates to:
  /// **'Width'**
  String get width;

  /// Full width option
  ///
  /// In en, this message translates to:
  /// **'Full'**
  String get widthFull;

  /// Medium width option
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get widthMedium;

  /// Narrow width option
  ///
  /// In en, this message translates to:
  /// **'Narrow'**
  String get widthNarrow;

  /// Backup on Wi‑Fi only toggle
  ///
  /// In en, this message translates to:
  /// **'Wi‑Fi only'**
  String get wifiOnly;

  /// No description provided for @wordCountShort.
  ///
  /// In en, this message translates to:
  /// **'{count} words'**
  String wordCountShort(int count);

  /// Word count label
  ///
  /// In en, this message translates to:
  /// **'words'**
  String get words;

  /// Purchase success headline
  ///
  /// In en, this message translates to:
  /// **'You\'re now Premium!'**
  String get youAreNowPremium;

  /// Dialog title when user tries to exit while recording is paused
  ///
  /// In en, this message translates to:
  /// **'Stop Recording?'**
  String get stopRecordingTitle;

  /// Dialog message when user tries to exit while recording is paused
  ///
  /// In en, this message translates to:
  /// **'Your recording is paused. Are you sure you want to exit? The current recording will be discarded.'**
  String get stopRecordingMessage;
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
    'ur',
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
    case 'ur':
      return AppLocalizationsUr();
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
