// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get about => 'کے بارے میں';

  @override
  String get addOrSelectScriptPrompt =>
      'ٹیلی پرمپٹر اوورلے کے ساتھ ریکارڈنگ شروع کرنے کے لیے اسکرپٹ شامل کریں یا منتخب کریں۔';

  @override
  String get adjust => 'ایڈجسٹ کریں';

  @override
  String get adNotAvailable => 'اشتہار دستیاب نہیں ہے';

  @override
  String get adNotAvailableDesc =>
      'اشتہار لوڈ کرنے میں ناکام رہا۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get adNotCompleted => 'اشتہار مکمل نہیں ہوا';

  @override
  String get adNotCompletedDesc =>
      'ایسا لگتا ہے کہ اشتہار کامیابی کے ساتھ مکمل نہیں ہوا۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get all => 'سب';

  @override
  String get allScriptsTitle => 'تمام اسکرپٹس';

  @override
  String get appearance => 'ظاہری شکل';

  @override
  String get appInfoDescription =>
      'مواد تخلیق کاروں کے لیے بہترین ٹیلی پرامپٹر اور ویڈیو ریکارڈنگ ٹول۔ آسانی سے بنائیں، پڑھیں اور ریکارڈ کریں۔';

  @override
  String get appInfoTitle => 'ScriptCam';

  @override
  String get appTitle => 'ScriptCam';

  @override
  String get autoBackup => 'خودکار بیک اپ';

  @override
  String get autoSync => 'آٹو سنک';

  @override
  String get backCamera => 'پیچھے';

  @override
  String get background => 'پس منظر';

  @override
  String backupFailedDetail(String error) {
    return 'بیک اپ ناکام رہا: $error';
  }

  @override
  String get backupNow => 'ابھی بیک اپ کریں';

  @override
  String get backupVideos => 'ویڈیوز کا بیک اپ';

  @override
  String bulkDeleteRecordingsTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ریکارڈنگز حذف کریں؟',
      one: 'یہ ریکارڈنگ حذف کریں؟',
    );
    return '$_temp0';
  }

  @override
  String get cameraPreviewWithOverlay =>
      'براہ راست ٹیلی پرمپٹر اوورلے کے ساتھ کیمرہ کا پیش نظارہ۔';

  @override
  String get cancel => 'منسوخ کریں';

  @override
  String get close => 'بند کریں';

  @override
  String get cloudBackup => 'کلاؤڈ بیک اپ';

  @override
  String get connected => 'جڑا ہوا';

  @override
  String get connectGoogleDrive => 'Google Drive سے جوڑیں';

  @override
  String get connectionError => 'کنکشن کی غلطی';

  @override
  String get contactUs => 'ہم سے رابطہ کریں';

  @override
  String get continueButton => 'جاری رکھیں';

  @override
  String get couldNotLoadVideo => 'ویڈیو لوڈ نہیں ہو سکی';

  @override
  String get countdownTimer => 'کاؤنٹ ڈاؤن ٹائمر';

  @override
  String get created => 'بنایا گیا!';

  @override
  String get createNewScript => 'نئی اسکرپٹ بنائیں';

  @override
  String creditsRemaining(int count) {
    return 'کریڈٹس $count';
  }

  @override
  String get cueCards => 'کیو کارڈز';

  @override
  String currentCreditsDescription(int count) {
    return 'آپ کے پاس ابھی $count کریڈٹس ہیں۔ مزید اشتہارات دیکھیں یا لامحدود رسائی کے لیے پریمیم حاصل کریں!';
  }

  @override
  String get dark => 'ڈارک';

  @override
  String get darkMode => 'ڈارک موڈ';

  @override
  String get defaultCamera => 'پہلے سے طے شدہ کیمرہ';

  @override
  String get delete => 'حذف کریں';

  @override
  String get deleteScriptMessage => 'یہ عمل واپس نہیں کیا جا سکتا۔';

  @override
  String get deleteScriptTitle => 'اسکرپٹ حذف کریں؟';

  @override
  String get deleteVideoTitle => 'ویڈیو حذف کریں؟';

  @override
  String get discard => 'مسترد کریں';

  @override
  String get discardChanges => 'تبدیلیاں مسترد کریں؟';

  @override
  String get discardChangesDesc =>
      'آپ کے پاس غیر محفوظ شدہ تبدیلیاں ہیں۔ ترمیمات ضائع ہو جائیں گی۔';

  @override
  String get disconnect => 'منقطع کریں';

  @override
  String get discountBadge => '20% کی چھوٹ';

  @override
  String get duplicate => 'نقل';

  @override
  String durationMinutesSecondsShort(int minutes, int seconds) {
    return '${minutes}m ${seconds}s';
  }

  @override
  String durationSecondsShort(int seconds) {
    return '${seconds}s';
  }

  @override
  String get earnRecordingCredits => 'ریکارڈنگ کریڈٹس کمائیں';

  @override
  String get edit => 'ترمیم کریں';

  @override
  String get editScript => 'اسکرپٹ ترمیم کریں';

  @override
  String get editScriptBlockedDuringCountdown =>
      'ترمیم کرنے سے پہلے الٹی گنتی ختم ہونے کا انتظار کریں۔';

  @override
  String get editScriptBlockedWhileRecording =>
      'اپنی اسکرپٹ میں ترمیم کرنے کے لیے ریکارڈنگ بند کریں۔';

  @override
  String get emptyCreativeSpaceMessage =>
      'آپ کی تخلیقی جگہ خالی ہے۔ اپنی پہلی اسکرپٹ بنائیں یا کچھ فوری ریکارڈ کریں!';

  @override
  String get emptyGallery => 'ابھی تک کوئی ویڈیو نہیں';

  @override
  String get emptyGalleryDesc =>
      'یہاں دیکھنے کے لیے اپنی پہلی ویڈیو ریکارڈ کریں';

  @override
  String errorSharingVideo(String error) {
    return 'ویڈیو شیئر کرنے میں غلطی: $error';
  }

  @override
  String exportedScriptSubject(String title) {
    return 'برآمد شدہ اسکرپٹ: $title';
  }

  @override
  String get exportQuality => 'برآمدی معیار';

  @override
  String get exportSuccess => 'اسکرپٹ کامیابی سے برآمد کی گئی';

  @override
  String get focusLine => 'فوکس لائن';

  @override
  String get font => 'فونٹ';

  @override
  String get fontSize => 'فونٹ سائز';

  @override
  String freeRecordingsLeft(int count) {
    return '$count مفت ریکارڈنگز باقی ہیں';
  }

  @override
  String get freeTrialCancelAnytime =>
      'مفت ٹرائل فوری طور پر شروع ہوتا ہے۔ تجدید سے پہلے کسی بھی وقت منسوخ کریں۔';

  @override
  String get frontCamera => 'سامنے والا';

  @override
  String get fullDuration => 'مکمل';

  @override
  String get general => 'عام';

  @override
  String get getPremium => 'پریمیم حاصل کریں';

  @override
  String get googleUser => 'Google صارف';

  @override
  String get goPremium => 'پریمیم حاصل کریں';

  @override
  String get gotIt => 'سمجھ گیا';

  @override
  String get grantAccess => 'رسائی دیں';

  @override
  String get help => 'مدد';

  @override
  String get highQualityVideo => 'اعلیٰ کوالٹی ویڈیو';

  @override
  String get howToUse => 'کیسے استعمال کریں';

  @override
  String get howToUseTitle => 'ScriptCam کیسے استعمال کریں';

  @override
  String get importScript => 'اسکرپٹ درآمد کریں';

  @override
  String get importSuccess => 'اسکرپٹ کامیابی سے درآمد کی گئی';

  @override
  String itemsSelected(int count) {
    return '$count منتخب';
  }

  @override
  String get keepEditing => 'ترمیم جاری رکھیں';

  @override
  String get language => 'زبان';

  @override
  String get lifetimeNoRecurringBilling =>
      'لائف ٹائم انلاک۔ کوئی اعادی بلنگ نہیں۔';

  @override
  String get lifetimeOneTimeUnlock =>
      'ایک بار کی خریداری۔ ایک بار ادائیگی کریں، ہمیشہ کے لیے غیر مقفل کریں۔';

  @override
  String get lifetimePlan => 'لائف ٹائم پلان';

  @override
  String get lifetimePriceNotLoaded =>
      'تاحیات قیمت ابھی تک اسٹور سے لوڈ نہیں ہوئی ہے۔';

  @override
  String get light => 'لائٹ';

  @override
  String get lightMode => 'لائٹ موڈ';

  @override
  String get lineSpacing => 'لائن اسپیسنگ';

  @override
  String get loop => 'لوپ';

  @override
  String get managePremiumStatus => 'اپنی پریمیم حیثیت کا انتظام کریں';

  @override
  String get minRead => 'منٹ پڑھیں';

  @override
  String get mirror => 'آئینہ';

  @override
  String get mute => 'خاموش کریں';

  @override
  String get never => 'کبھی نہیں';

  @override
  String get newScript => 'نئی اسکرپٹ';

  @override
  String get newScriptMultiline => 'نئی\nاسکرپٹ';

  @override
  String get next => 'اگلا';

  @override
  String get noAds => 'کوئی اشتہار نہیں';

  @override
  String get noInternetDesc =>
      'ایسا لگتا ہے آپ آف لائن ہیں۔ براہ کرم اپنا کنکشن چیک کریں اور دوبارہ کوشش کریں۔';

  @override
  String get noInternetError => 'انٹرنیٹ نہیں ہے';

  @override
  String get noInternetErrorDesc =>
      'براہ کرم اپنا نیٹ ورک کنکشن چیک کریں اور دوبارہ کوشش کریں۔';

  @override
  String get noInternetTitle => 'انٹرنیٹ کنکشن نہیں ہے';

  @override
  String get noRecordingsLeft =>
      'کوئی ریکارڈنگ باقی نہیں ہے · جاری رکھنے کے لیے اشتہار دیکھیں';

  @override
  String get noResultsFound => 'کوئی نتیجہ نہیں ملا';

  @override
  String get noResultsMessage =>
      'آپ کی تلاش سے مطابقت رکھنے والی کوئی اسکرپٹ نہیں ملی۔ مختلف الفاظ آزمائیں!';

  @override
  String get noSavedScriptSelected =>
      'کوئی محفوظ شدہ اسکرپٹ منتخب نہیں کیا گیا۔';

  @override
  String get notAuthenticated => 'تصدیق شدہ نہیں ہے';

  @override
  String get off => 'بند';

  @override
  String get onboardingAccessCamera => 'کیمرہ';

  @override
  String get onboardingAccessMic => 'مائیکروفون';

  @override
  String get onboardingInteractiveRecLabel => 'آر ای سی';

  @override
  String get onboardingInteractiveStep1Eyebrow => 'مرکزی منظر';

  @override
  String get onboardingInteractiveStep1Preview =>
      'اوورلے اسکرپٹ اور فریمنگ ایک ساتھ دکھائی دیتے ہیں۔ مشق کرنے کے لیے اسکرول کریں؛ جب پیسنگ درست محسوس ہو تو ریکارڈنگ شروع کریں۔';

  @override
  String get onboardingInteractiveStep1Subtitle =>
      'اسکرپٹ کیم کیپچر پر مرکز ہے۔ اسکرپٹس، کریڈٹس، اور سیٹنگز آپ جو فلم بناتے ہیں اسے جمع کیے بغیر قابل رسائی رہتے ہیں۔';

  @override
  String get onboardingInteractiveStep1Title => 'ریکارڈنگ - پہلی ورک اسپیس';

  @override
  String get onboardingInteractiveStep2Sample =>
      'صبح بخیر — یہاں آنے کا شکریہ۔\nہم اسے مختصر اور عملی رکھیں گے۔\nاگر آپ عینک سے ہٹ جاتے ہیں تو جان بوجھ کر واپس آ جائیں اور آگے بڑھیں۔';

  @override
  String get onboardingInteractiveStep2Subtitle =>
      'ایک تھپتھپا کر ریہرسل روک دیں۔ جب آپ مشق کریں یا شوٹ کریں تو ریکارڈنگ اسکرین سے اسکرول پیسنگ اور ٹیکسٹ سائز کو ایڈجسٹ کریں۔';

  @override
  String get onboardingInteractiveStep2Title => 'ٹیلی پرمپٹر اوورلے';

  @override
  String get onboardingInteractiveStep4CardHint =>
      'آپ انہیں Android یا iOS کی ترتیبات میں کسی بھی وقت تبدیل کر سکتے ہیں۔';

  @override
  String get onboardingInteractiveStep4Subtitle =>
      'ScriptCam کو کیمرے اور مائیکروفون کی ضرورت ہے تاکہ آپ خود کو دیکھ سکیں جب تک کہ اسکرپٹ آپ کی رفتار کے ساتھ مطابقت پذیر رہے۔';

  @override
  String get onboardingInteractiveStep4Title => 'ریکارڈنگ تک رسائی';

  @override
  String get opacity => 'شفافیت';

  @override
  String get original => 'اصل';

  @override
  String get overlaySettings => 'اوورلے کی ترتیبات';

  @override
  String get paste => 'چسپاں کریں';

  @override
  String get permissionsRequired => 'کیمرے اور مائیکروفون کی اجازت ضروری ہے۔';

  @override
  String get preferences => 'ترجیحات';

  @override
  String get premium => 'پریمیم';

  @override
  String get premiumActive => 'پریمیم فعال ہے';

  @override
  String get premiumBenefitInstantRecord =>
      'پریمیم صارفین کو فوری ریکارڈنگ اور آواز ہم آہنگی ملتی ہے!';

  @override
  String get premiumDescription =>
      'تمام پریمیم خصوصیات غیر مقفل کریں اور اشتہار سے پاک تجربہ لطف اندوز ہوں';

  @override
  String get premiumUnlocked => 'پریمیم ان لاک ہو گیا!';

  @override
  String get privacyPolicy => 'رازداری کی پالیسی';

  @override
  String get pro => 'پرو';

  @override
  String get processing => 'پروسیسنگ...';

  @override
  String purchaseErrorDetail(String p0) {
    return 'خریداری ناکام رہی: $p0';
  }

  @override
  String get purchaseFailedInitiate => 'خریداری شروع کرنے میں ناکام';

  @override
  String get qualityHigh => 'اعلیٰ (1080p)';

  @override
  String get qualityLabel => 'کوالٹی';

  @override
  String get qualityLow => 'کم (480p)';

  @override
  String get qualityStandard => 'معیاری (720p)';

  @override
  String get range => 'رینج';

  @override
  String get rateUs => 'ہمیں ریٹ کریں';

  @override
  String get ratio => 'تناسب';

  @override
  String get recent => 'حالیہ';

  @override
  String get recordingFailed => 'ریکارڈنگ ناکام';

  @override
  String recordingsDeletedToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ریکارڈنگز حذف ہو گئیں',
      one: '1 ریکارڈنگ حذف ہو گئی',
    );
    return '$_temp0';
  }

  @override
  String recordingsRemainingHint(int count) {
    return '$count ریکارڈنگز باقی ہیں · مزید کے لیے اشتہار دیکھیں';
  }

  @override
  String get recordNow => 'ابھی ریکارڈ کریں';

  @override
  String get remoteControl => 'بلوٹوتھ ریموٹ اور کی بورڈ';

  @override
  String get remoteControlLocked =>
      'بلوٹوتھ ریموٹ اور کی بورڈ ایک پریمیم فیچر ہے';

  @override
  String get removeAds => 'اشتہارات ہٹائیں';

  @override
  String get rename => 'نام تبدیل کریں۔';

  @override
  String get resolution => 'ریزولوشن';

  @override
  String get restore => 'بحال کریں';

  @override
  String get restoredSuccessfully => 'کامیابی سے ریسٹور ہو گیا';

  @override
  String restoreFailed(String error) {
    return 'ریسٹور ناکام رہا: $error';
  }

  @override
  String get restorePurchaseLink => 'خریداری بحال کریں';

  @override
  String get retry => 'دوبارہ کوشش کریں';

  @override
  String get rewardGranted => 'انعام مل گیا: +3 ریکارڈنگز';

  @override
  String get rotate => 'گھمائیں';

  @override
  String get save => 'محفوظ کریں';

  @override
  String get saveButton => 'محفوظ کریں';

  @override
  String get saved => 'محفوظ ہو گیا';

  @override
  String savedAs(String p0) {
    return '$p0 کے طور پر محفوظ';
  }

  @override
  String get saveEditorLabel => 'محفوظ کریں';

  @override
  String get saveFailed => 'محفوظ کرنا ناکام رہا';

  @override
  String get saveFailedEmpty => 'ایکسپورٹ سے خالی فائل بنی';

  @override
  String get saveFailedGallery => 'گیلری میں محفوظ کرنا ناکام رہا';

  @override
  String get saveFailedNotFound => 'ایکسپورٹ فائل نہیں ملی';

  @override
  String get saveVideo => 'ویڈیو محفوظ کریں';

  @override
  String get savingEllipsis => 'محفوظ ہو رہا ہے...';

  @override
  String get scriptContentPlaceholder => 'یہاں اپنی اسکرپٹ لکھنا شروع کریں...';

  @override
  String get scriptDeleted => 'اسکرپٹ حذف کر دی گئی';

  @override
  String scriptSummary(String p0, String p1) {
    return '$p0 · $p1';
  }

  @override
  String get scriptTitleHint => 'مثلاً YouTube انٹرو';

  @override
  String get scriptTitlePlaceholder => 'اسکرپٹ عنوان...';

  @override
  String get scrollSpeed => 'اسکرول کی رفتار';

  @override
  String get searchScripts => 'اسکرپٹس تلاش کریں...';

  @override
  String get selectedScriptReady => 'منتخب اسکرپٹ تیار ہے۔';

  @override
  String get selectLanguage => 'زبان منتخب کریں';

  @override
  String get selectLanguageDesc => 'ایپ کے لیے اپنی پسندیدہ زبان منتخب کریں';

  @override
  String get selectPlatformDesc =>
      'اپنی اسکرپٹ کے لیے ایک پلیٹ فارم منتخب کریں';

  @override
  String get settings => 'ترتیبات';

  @override
  String get shareApp => 'ایپ شیئر کریں';

  @override
  String shareAppMessage(String url) {
    return 'ScriptCam کے ساتھ اعتماد سے پیشہ ورانہ ویڈیوز ریکارڈ کریں! 🎥✨\n\nاس میں بلٹ-اِن ٹیلی پرامپٹر، 4K ریکارڈنگ، اور ویڈیو ایڈیٹر ہے۔ یہاں آزمائیں:\n$url';
  }

  @override
  String get shareAppSubject => 'ScriptCam دیکھیں: ویڈیو ٹیلی پرامپٹر';

  @override
  String get shareVideoSubject => 'میرا ویڈیو دیکھیں!';

  @override
  String get shareVideoText =>
      'اسکرپٹ کیم کے ساتھ ریکارڈ کیا گیا میرا ویڈیو دیکھیں!';

  @override
  String get signInCancelled => 'سائن ان منسوخ کر دیا گیا';

  @override
  String get softStart => 'سافٹ اسٹارٹ';

  @override
  String get speed => 'رفتار';

  @override
  String get speedFast => 'تیز';

  @override
  String get speedNormal => 'نارمل';

  @override
  String get speedSlow => 'سست';

  @override
  String get speedTurbo => 'ٹربو';

  @override
  String get startFreeTrial => 'مفت آزمائش شروع کریں۔';

  @override
  String get startRecording => 'ریکارڈنگ شروع کریں';

  @override
  String get startYourJourney => 'اپنا سفر شروع کریں';

  @override
  String get step1Desc =>
      'ایک نئی اسکرپٹ یا بغیر متن کے فوری ریکارڈ بنا کر شروعات کریں';

  @override
  String get step1Title => 'ایک اسکرپٹ بنائیں';

  @override
  String get step2Desc =>
      'رفتار، فونٹ سائز ایڈجسٹ کریں اور ہینڈز-فری اسکرولنگ کے لیے آواز ہم آہنگی فعال کریں';

  @override
  String get step2Title => 'ٹیلی پرامپٹر سیٹ اپ کریں';

  @override
  String get step3Desc =>
      'ریکارڈ دبائیں اور کیمرے کی طرف دیکھتے ہوئے اپنی اسکرپٹ پڑھیں';

  @override
  String get step3Title => 'اپنی ویڈیو ریکارڈ کریں';

  @override
  String get step4Desc =>
      'شیئر کرنے سے پہلے ویڈیو ایڈیٹر استعمال کریں تراشنے، ایڈجسٹ کرنے اور فلٹر لگانے کے لیے';

  @override
  String get step4Title => 'ترمیم اور شیئر کریں';

  @override
  String get step5Desc =>
      'چلانے، توقف کرنے اور اسکرول رفتار کنٹرول کرنے کے لیے بلوٹوتھ ریموٹ یا کی بورڈ استعمال کریں';

  @override
  String get step5Title => 'ریموٹ کنٹرول';

  @override
  String get storePricingUnavailable =>
      'اسٹور کی قیمتوں کا تعین ابھی دستیاب نہیں ہے۔';

  @override
  String get storeUnavailable => 'اسٹور دستیاب نہیں ہے';

  @override
  String get stripView => 'سٹرپ ویو';

  @override
  String get studioEditor => 'اسٹوڈیو ایڈیٹر';

  @override
  String get support => 'سپورٹ';

  @override
  String get supportBody => 'اپنے مسئلے کی تفصیل یہاں لکھیں...';

  @override
  String get supportSubject => 'ایپ سپورٹ';

  @override
  String get switchAccount => 'اکاؤنٹ تبدیل کریں';

  @override
  String get system => 'سسٹم';

  @override
  String get systemDefault => 'سسٹم ڈیفالٹ';

  @override
  String get tabCamera => 'کیمرہ';

  @override
  String get tabRecordings => 'ریکارڈنگز';

  @override
  String get tabScripts => 'اسکرپٹس';

  @override
  String get targetFps => 'ہدف FPS';

  @override
  String get text => 'متن';

  @override
  String get textPasted => 'متن چسپاں کیا گیا';

  @override
  String get titleRequired => 'عنوان ضروری ہے';

  @override
  String get transform => 'تبدیل کریں';

  @override
  String get trim => 'تراشیں';

  @override
  String get unexpectedError => 'غیر متوقع غلطی';

  @override
  String get unexpectedErrorDesc =>
      'کچھ غلط ہو گیا۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get unlimitedRecordings => 'لامحدود ریکارڈنگز';

  @override
  String get unlimitedScripts => 'لامحدود اسکرپٹس';

  @override
  String get unlockAllFeatures =>
      'تمام خصوصیات کو غیر مقفل کریں اور اشتہارات ہٹائیں';

  @override
  String get unlockCreatorPro => 'کریٹر پرو غیر مقفل کریں';

  @override
  String get untitledScript => 'بلا عنوان اسکرپٹ';

  @override
  String get upgradeForLifetime => 'تاحیات رسائی کے لیے اپگریڈ کریں';

  @override
  String get upgradeToPro => 'پرو میں اپگریڈ کریں';

  @override
  String get useASavedScript => 'محفوظ شدہ اسکرپٹ استعمال کریں';

  @override
  String get version => 'ورژن';

  @override
  String get videoDeleted => 'ویڈیو حذف کر دی گئی';

  @override
  String get videoFileNotFound => 'ویڈیو فائل نہیں ملی';

  @override
  String get videoName => 'ویڈیو کا نام';

  @override
  String get videoNameHint => 'ویڈیو کا نام درج کریں...';

  @override
  String get videoSettings => 'ویڈیو ترتیبات';

  @override
  String get voiceSync => 'آواز ہم آہنگی';

  @override
  String get voiceSyncFeature => 'وائس سنک (ٹیلی پرمپٹر)';

  @override
  String get voiceSyncLocked => 'آواز ہم آہنگی ایک پریمیم خصوصیت ہے';

  @override
  String get watchAdGetRecordings => '1 اشتہار دیکھیں ← +3 ریکارڈنگز حاصل کریں';

  @override
  String get watchAdToRecord => 'ریکارڈ کرنے کے لیے اشتہار دیکھیں';

  @override
  String get watchAdToRecordDesc =>
      'اس اسکرپٹ کے لیے ریکارڈنگ غیر مقفل کرنے کے لیے ایک مختصر اشتہار دیکھیں۔';

  @override
  String get weeklyPlan => 'ہفتہ وار';

  @override
  String get weeklyPriceNotLoaded =>
      'ہفتہ وار قیمت ابھی تک اسٹور سے لوڈ نہیں ہوئی ہے۔';

  @override
  String get weeklyTrialStorePrice =>
      '3 دن کی مفت آزمائش، اسٹور سے ہفتہ وار قیمت';

  @override
  String weeklyTrialThenPrice(String price) {
    return '3 دن کی مفت آزمائش، پھر $price/ ہفتہ';
  }

  @override
  String get whatAreYouRecording => 'آج آپ کیا\nریکارڈ کر رہے ہیں؟';

  @override
  String get width => 'چوڑائی';

  @override
  String get widthFull => 'مکمل';

  @override
  String get widthMedium => 'درمیانہ';

  @override
  String get widthNarrow => 'تنگ';

  @override
  String get wifiOnly => 'صرف WiFi';

  @override
  String wordCountShort(int count) {
    return '$count الفاظ';
  }

  @override
  String get words => 'الفاظ';

  @override
  String get youAreNowPremium => 'اب آپ پریمیم ہیں';
}
