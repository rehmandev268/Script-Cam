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
  String get studio => 'الاستوديو';

  @override
  String get startYourJourney => 'ابدأ رحلتك';

  @override
  String get noResultsFound => 'لم يتم العثور على نتائج';

  @override
  String get noResultsMessage =>
      'لم نتمكن من العثور على أي نصوص تطابق بحثك. جرب كلمات مفتاحية مختلفة!';

  @override
  String get emptyCreativeSpaceMessage =>
      'مساحتك الإبداعية فارغة. أنشئ نصك الأول أو جرب تسجيل شيء ما على الفور!';

  @override
  String get paste => 'لصق';

  @override
  String get createNewScript => 'إنشاء نص جديد';

  @override
  String get selectPlatformDesc => 'اختر منصة لنصك';

  @override
  String get pro => 'PRO';

  @override
  String get minRead => 'دقيقة قراءة';

  @override
  String get words => 'كلمات';

  @override
  String get edit => 'تعديل';

  @override
  String get howToUseTitle => 'كيفية استخدام ScriptCam';

  @override
  String get step1Title => 'إنشاء نص';

  @override
  String get step1Desc => 'ابدأ بإنشاء نص جديد أو تسجيل سريع بدون نص';

  @override
  String get step2Title => 'إعداد التلقين';

  @override
  String get step2Desc =>
      'اضبط السرعة وحجم الخط وفعل مزامنة الصوت للتمرير بدون استخدام اليدين';

  @override
  String get step3Title => 'سجل الفيديو الخاص بك';

  @override
  String get step3Desc => 'اضغط على تسجيل واقرأ نصك أثناء النظر إلى الكاميرا';

  @override
  String get step4Title => 'التحرير والمشاركة';

  @override
  String get step4Desc =>
      'استخدم محرر الفيديو للقص والضبط وتطبيق الفلاتر قبل المشاركة';

  @override
  String get gotIt => 'فهمت';

  @override
  String get deleteVideoTitle => 'حذف الفيديو؟';

  @override
  String get videoDeleted => 'تم حذف الفيديو';

  @override
  String get mute => 'كتم الصوت';

  @override
  String get opacity => 'الشفافية';

  @override
  String get original => 'أصلي';

  @override
  String get processing => 'جاري المعالجة...';

  @override
  String get range => 'النطاق';

  @override
  String get ratio => 'النسبة';

  @override
  String get recordingFailed => 'فشل التسجيل';

  @override
  String get rotate => 'تدوير';

  @override
  String get targetFps => 'FPS المستهدف';

  @override
  String get transform => 'تحويل';

  @override
  String get premiumDescription =>
      'افتح جميع الميزات المميزة واستمتع بتجربة خالية من الإعلانات';

  @override
  String get removeAds => 'إزالة الإعلانات';

  @override
  String get unlimitedScripts => 'نصوص غير محدودة';

  @override
  String get unlockCreatorPro => 'فتح Creator Pro';

  @override
  String get upgradeForLifetime => 'ترقية للوصول مدى الحياة';

  @override
  String get restorePurchaseLink => 'استعادة الشراء';

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
