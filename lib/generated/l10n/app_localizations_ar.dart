// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'ScriptCam';

  @override
  String get onboardingWelcomeTitle => 'مرحبًا بك في ScriptCam';

  @override
  String get onboardingWelcomeDesc =>
      'استوديو التلقين الشامل الخاص بك. اكتب النصوص، سجل مقاطع الفيديو، وحرر بسلاسة.';

  @override
  String get onboardingScriptEditorTitle => 'محرر النصوص';

  @override
  String get onboardingScriptEditorDesc =>
      'اكتب وأدر نصوص الفيديو الخاصة بك بسهولة. نظم أفكارك على الفور.';

  @override
  String get onboardingTeleprompterTitle => 'التلقين';

  @override
  String get onboardingTeleprompterDesc =>
      'اقرأ نصك أثناء النظر مباشرة إلى الكاميرا. تسجيل احترافي سهل.';

  @override
  String get onboardingPermissionsTitle => 'تمكين الأذونات';

  @override
  String get onboardingPermissionsDesc =>
      'لتسجيل مقاطع الفيديو ومزامنة صوتك مع النص، نحتاج إلى الوصول إلى الكاميرا والميكروفون.';

  @override
  String get grantAccess => 'منح الوصول';

  @override
  String get start => 'ابدأ';

  @override
  String get next => 'التالي';

  @override
  String get permissionsRequired => 'أذونات الكاميرا والميكروفون مطلوبة.';

  @override
  String get selectLanguage => 'اختر اللغة';

  @override
  String get selectLanguageDesc => 'اختر لغتك المفضلة للتطبيق';

  @override
  String get continueButton => 'متابعة';

  @override
  String get settings => 'الإعدادات';

  @override
  String get preferences => 'التفضيلات';

  @override
  String get help => 'المساعدة';

  @override
  String get support => 'الدعم';

  @override
  String get about => 'حول';

  @override
  String get appearance => 'المظهر';

  @override
  String get language => 'اللغة';

  @override
  String get systemDefault => 'افتراضي النظام';

  @override
  String get lightMode => 'الوضع الفاتح';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get system => 'النظام';

  @override
  String get light => 'فاتح';

  @override
  String get dark => 'داكن';

  @override
  String get howToUse => 'كيفية الاستخدام';

  @override
  String get shareApp => 'مشاركة التطبيق';

  @override
  String get contactUs => 'اتصل بنا';

  @override
  String get rateUs => 'قيمنا';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get version => 'الإصدار';

  @override
  String get upgradeToPro => 'الترقية إلى Pro';

  @override
  String get unlockAllFeatures => 'افتح جميع الميزات وأزل الإعلانات';

  @override
  String shareAppMessage(String url) {
    return 'سجل مقاطع فيديو احترافية بثقة باستخدام ScriptCam! 🎥✨\n\nيحتوي على تلقين مدمج، تسجيل 4K، ومحرر فيديو. جربه هنا:\n$url';
  }

  @override
  String get shareAppSubject => 'تحقق من ScriptCam: تلقين الفيديو';

  @override
  String get goodMorning => 'صباح الخير';

  @override
  String get goodAfternoon => 'مساء الخير';

  @override
  String get goodEvening => 'مساء الخير';

  @override
  String get readyToCreate => 'هل أنت مستعد لإنشاء شيء\nمذهل؟';

  @override
  String get newScript => 'نص جديد';

  @override
  String get writeFromScratch => 'اكتب من الصفر';

  @override
  String get quickRecord => 'تسجيل سريع';

  @override
  String get recordOnTheFly => 'سجل على الفور';

  @override
  String get myScripts => 'نصوصي';

  @override
  String get recentFirst => 'الأحدث أولاً';

  @override
  String get quickRecordDialogTitle => 'تسجيل سريع';

  @override
  String get quickRecordDialogDesc =>
      'أدخل تفاصيل النص أدناه، أو تخطى لفتح الكاميرا بدون نص.';

  @override
  String get scriptTitle => 'عنوان النص';

  @override
  String get scriptContent => 'محتوى النص';

  @override
  String get scriptTitleHint => 'مثال: مقدمة يوتيوب';

  @override
  String get scriptContentHint => 'الصق محتوى النص هنا...';

  @override
  String get startRecording => 'بدء التسجيل';

  @override
  String get editScript => 'تحرير النص';

  @override
  String get save => 'حفظ';

  @override
  String get scriptTitlePlaceholder => 'عنوان النص...';

  @override
  String get scriptContentPlaceholder => 'ابدأ كتابة نصك هنا...';

  @override
  String get platform => 'المنصة';

  @override
  String get titleRequired => 'العنوان مطلوب';

  @override
  String get saved => 'تم الحفظ';

  @override
  String get created => 'تم الإنشاء!';

  @override
  String get textPasted => 'تم لصق النص';

  @override
  String get scriptDeleted => 'تم حذف النص';

  @override
  String get deleteScriptTitle => 'حذف النص؟';

  @override
  String get deleteScriptMessage => 'لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get appInfoTitle => 'ScriptCam';

  @override
  String get appInfoVersion => 'الإصدار 1.0.3';

  @override
  String get appInfoDescription =>
      'أداة التلقين والتسجيل النهائية لمنشئي المحتوى. أنشئ واقرأ وسجل بسلاسة.';

  @override
  String get close => 'إغلاق';

  @override
  String get emptyScriptsAll => 'لا توجد نصوص بعد';

  @override
  String get emptyScriptsAllDesc => 'أنشئ نصك الأول للبدء';

  @override
  String emptyScriptsCategory(String category) {
    return 'لا توجد نصوص $category';
  }

  @override
  String get emptyScriptsCategoryDesc => 'أنشئ نصًا لهذه المنصة';

  @override
  String get gallery => 'المعرض';

  @override
  String get emptyGallery => 'لا توجد مقاطع فيديو بعد';

  @override
  String get emptyGalleryDesc => 'سجل مقطع الفيديو الأول لرؤيته هنا';

  @override
  String get teleprompter => 'التلقين';

  @override
  String get record => 'تسجيل';

  @override
  String get stop => 'إيقاف';

  @override
  String get pause => 'إيقاف مؤقت';

  @override
  String get resume => 'استئناف';

  @override
  String get speed => 'السرعة';

  @override
  String get fontSize => 'حجم الخط';

  @override
  String get mirror => 'مرآة';

  @override
  String get voiceSync => 'مزامنة الصوت';

  @override
  String get autoScroll => 'التمرير التلقائي';

  @override
  String get videoSettings => 'إعدادات الفيديو';

  @override
  String get resolution => 'الدقة';

  @override
  String get quality => 'الجودة';

  @override
  String get premium => 'بريميوم';

  @override
  String get getPremium => 'احصل على بريميوم';

  @override
  String get restorePurchases => 'استعادة المشتريات';

  @override
  String get videoEditor => 'محرر الفيديو';

  @override
  String get trim => 'قص';

  @override
  String get adjust => 'ضبط';

  @override
  String get filters => 'الفلاتر';

  @override
  String get export => 'تصدير';

  @override
  String get exporting => 'جاري التصدير...';

  @override
  String get exportComplete => 'اكتمل التصدير!';

  @override
  String get brightness => 'السطوع';

  @override
  String get contrast => 'التباين';

  @override
  String get saturation => 'التشبع';

  @override
  String get share => 'مشاركة';

  @override
  String get play => 'تشغيل';

  @override
  String get all => 'الكل';

  @override
  String get general => 'عام';

  @override
  String get search => 'بحث';

  @override
  String get searchScripts => 'البحث عن نصوص...';

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
}
