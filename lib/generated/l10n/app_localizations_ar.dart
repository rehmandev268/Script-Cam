// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get about => 'حول';

  @override
  String get addOrSelectScriptPrompt =>
      'قم بإضافة أو تحديد برنامج نصي لبدء التسجيل باستخدام تراكب الملقن.';

  @override
  String get adjust => 'ضبط';

  @override
  String get adNotAvailable => 'الإعلان غير متاح';

  @override
  String get adNotAvailableDesc =>
      'لم نتمكن من تحميل إعلان. حاول مرة أخرى بعد قليل.';

  @override
  String get adNotCompleted => 'الإعلان لم ينته';

  @override
  String get adNotCompletedDesc =>
      'شاهد الإعلان كاملاً لتحصل على أرصدة التسجيل.';

  @override
  String get all => 'الكل';

  @override
  String get allScriptsTitle => 'جميع البرامج النصية';

  @override
  String get appearance => 'المظهر';

  @override
  String get appInfoDescription =>
      'أداة التلقين والتسجيل النهائية لمنشئي المحتوى. أنشئ واقرأ وسجل بسلاسة.';

  @override
  String get appInfoTitle => 'ScriptCam';

  @override
  String get appTitle => 'ScriptCam';

  @override
  String get autoBackup => 'النسخ الاحتياطي التلقائي';

  @override
  String get autoSync => 'المزامنة التلقائية';

  @override
  String get backCamera => 'خلف';

  @override
  String get background => 'خلفية';

  @override
  String backupFailedDetail(String error) {
    return 'خطأ في النسخ الاحتياطي: $error';
  }

  @override
  String get backupNow => 'النسخ الاحتياطي الآن';

  @override
  String get backupVideos => 'مقاطع الفيديو الاحتياطية';

  @override
  String bulkDeleteRecordingsTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'حذف $count تسجيلات؟',
      one: 'حذف هذا التسجيل؟',
    );
    return '$_temp0';
  }

  @override
  String get cameraPreviewWithOverlay =>
      'معاينة الكاميرا مع تراكب الملقن المباشر.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get close => 'إغلاق';

  @override
  String get cloudBackup => 'النسخ الاحتياطي السحابي';

  @override
  String get connected => 'متصل';

  @override
  String get connectGoogleDrive => 'قم بتوصيل جوجل درايف';

  @override
  String get connectionError =>
      'خطأ في الاتصال. تحقق من الإنترنت وحاول مرة أخرى.';

  @override
  String get contactUs => 'اتصل بنا';

  @override
  String get continueButton => 'متابعة';

  @override
  String get couldNotLoadVideo => 'تعذر تحميل الفيديو';

  @override
  String get countdownTimer => 'توقيت العد التنازلي';

  @override
  String get created => 'تم الإنشاء!';

  @override
  String get createNewScript => 'إنشاء نص جديد';

  @override
  String creditsRemaining(int count) {
    return 'الاعتمادات $count';
  }

  @override
  String get cueCards => 'بطاقات جديلة';

  @override
  String currentCreditsDescription(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'يتبقى لك $count تسجيلات مجانية لهذا النص.',
      one: 'يتبقى لك تسجيل مجاني واحد لهذا النص.',
    );
    return '$_temp0';
  }

  @override
  String get dark => 'داكن';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get defaultCamera => 'الكاميرا الافتراضية';

  @override
  String get delete => 'حذف';

  @override
  String get deleteScriptMessage => 'لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get deleteScriptTitle => 'حذف النص؟';

  @override
  String get deleteVideoTitle => 'حذف الفيديو؟';

  @override
  String get discard => 'ينبذ';

  @override
  String get discardChanges => 'هل تريد تجاهل التغييرات؟';

  @override
  String get discardChangesDesc => 'سيتم فقدان تعديلاتك.';

  @override
  String get disconnect => 'قطع الاتصال';

  @override
  String get discountBadge => 'خصم 20%';

  @override
  String get duplicate => 'ينسخ';

  @override
  String durationMinutesSecondsShort(int minutes, int seconds) {
    return '$minutes:$seconds';
  }

  @override
  String durationSecondsShort(int seconds) {
    return '$seconds ثانية';
  }

  @override
  String get earnRecordingCredits => 'كسب اعتمادات التسجيل';

  @override
  String get edit => 'تعديل';

  @override
  String get editScript => 'تحرير النص';

  @override
  String get editScriptBlockedDuringCountdown =>
      'انتظر حتى انتهاء العد التنازلي قبل التحرير.';

  @override
  String get editScriptBlockedWhileRecording =>
      'أوقف التسجيل لتحرير البرنامج النصي الخاص بك.';

  @override
  String get emptyCreativeSpaceMessage =>
      'مساحتك الإبداعية فارغة. أنشئ نصك الأول أو جرب تسجيل شيء ما على الفور!';

  @override
  String get emptyGallery => 'لا توجد مقاطع فيديو بعد';

  @override
  String get emptyGalleryDesc => 'سجل مقطع الفيديو الأول لرؤيته هنا';

  @override
  String errorSharingVideo(String error) {
    return 'تعذرت مشاركة الفيديو: $error';
  }

  @override
  String exportedScriptSubject(String title) {
    return 'البرنامج النصي الذي تم تصديره: $title';
  }

  @override
  String get exportQuality => 'جودة التصدير';

  @override
  String get exportSuccess => 'تم تصدير البرنامج النصي بنجاح';

  @override
  String get focusLine => 'خط التركيز';

  @override
  String get font => 'الخط';

  @override
  String get fontSize => 'حجم الخط';

  @override
  String freeRecordingsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'لا يزال هناك $count تسجيلات مجانية',
      one: 'لا يزال هناك تسجيل مجاني واحد',
    );
    return '$_temp0';
  }

  @override
  String get freeTrialCancelAnytime =>
      'تبدأ النسخة التجريبية المجانية على الفور. قم بالإلغاء في أي وقت قبل التجديد.';

  @override
  String get frontCamera => 'أمام';

  @override
  String get fullDuration => 'ممتلىء';

  @override
  String get general => 'عام';

  @override
  String get getPremium => 'احصل على بريميوم';

  @override
  String get googleUser => 'مستخدم جوجل';

  @override
  String get goPremium => 'اذهب إلى الإصدار المميز';

  @override
  String get gotIt => 'فهمت';

  @override
  String get grantAccess => 'منح الوصول';

  @override
  String get help => 'المساعدة';

  @override
  String get highQualityVideo => 'فيديو عالي الجودة';

  @override
  String get howToUse => 'كيفية الاستخدام';

  @override
  String get howToUseTitle => 'كيفية استخدام ScriptCam';

  @override
  String get importScript => 'يستورد';

  @override
  String get importSuccess => 'تم استيراد البرنامج النصي بنجاح';

  @override
  String itemsSelected(int count) {
    return '$count محددة';
  }

  @override
  String get keepEditing => 'استمر في التحرير';

  @override
  String get language => 'اللغة';

  @override
  String get lifetimeNoRecurringBilling =>
      'فتح مدى الحياة. لا الفواتير المتكررة.';

  @override
  String get lifetimeOneTimeUnlock =>
      'شراء لمرة واحدة. ادفع مرة واحدة وافتح القفل إلى الأبد.';

  @override
  String get lifetimePlan => 'خطة مدى الحياة';

  @override
  String get lifetimePriceNotLoaded =>
      'السعر مدى الحياة لم يتم تحميله من المتجر بعد.';

  @override
  String get light => 'فاتح';

  @override
  String get lightMode => 'الوضع الفاتح';

  @override
  String get lineSpacing => 'تباعد الأسطر';

  @override
  String get loop => 'حلقة';

  @override
  String get managePremiumStatus => 'إدارة حالة قسط الخاص بك';

  @override
  String get minRead => 'دقيقة قراءة';

  @override
  String get mirror => 'مرآة';

  @override
  String get mute => 'كتم الصوت';

  @override
  String get never => 'أبداً';

  @override
  String get newScript => 'نص جديد';

  @override
  String get newScriptMultiline => 'جديد\nالبرنامج النصي';

  @override
  String get next => 'التالي';

  @override
  String get noAds => 'لا إعلانات إلى الأبد';

  @override
  String get noInternetDesc =>
      'يبدو أنك غير متصل. يرجى التحقق من اتصالك والمحاولة مرة أخرى.';

  @override
  String get noInternetError => 'لا يوجد إنترنت';

  @override
  String get noInternetErrorDesc => 'اتصل بالإنترنت وحاول مرة أخرى.';

  @override
  String get noInternetTitle => 'لا يوجد اتصال بالإنترنت';

  @override
  String get noRecordingsLeft => 'لم يتبق أي تسجيلات · شاهد إعلانًا للمتابعة';

  @override
  String get noResultsFound => 'لم يتم العثور على نتائج';

  @override
  String get noResultsMessage =>
      'لم نتمكن من العثور على أي نصوص تطابق بحثك. جرب كلمات مفتاحية مختلفة!';

  @override
  String get noSavedScriptSelected => 'لم يتم تحديد أي برنامج نصي محفوظ';

  @override
  String get notAuthenticated => 'لم يتم تسجيل الدخول إلى جوجل.';

  @override
  String get off => 'عن';

  @override
  String get onboardingAccessCamera => 'آلة تصوير';

  @override
  String get onboardingAccessMic => 'ميكروفون';

  @override
  String get onboardingInteractiveRecLabel => 'REC';

  @override
  String get onboardingInteractiveStep1Eyebrow => 'العرض الرئيسي';

  @override
  String get onboardingInteractiveStep1Preview =>
      'يبقى النص المتراكب والإطار مرئيين معًا. قم بالتمرير إلى التمرين؛ ابدأ التسجيل عندما تشعر أن السرعة مناسبة.';

  @override
  String get onboardingInteractiveStep1Subtitle =>
      'يركز ScriptCam على الالتقاط. تظل النصوص والاعتمادات والإعدادات قابلة للوصول دون إزعاج ما تقوم بتصويره.';

  @override
  String get onboardingInteractiveStep1Title => 'التسجيل-مساحة العمل الأولى';

  @override
  String get onboardingInteractiveStep2Sample =>
      'صباح الخير – شكرًا لوجودك هنا.\nسنبقي هذا موجزًا ​​وعمليًا.\nإذا ابتعدت عن العدسة، فاستقر متعمدًا واستمر في ذلك.';

  @override
  String get onboardingInteractiveStep2Subtitle =>
      'وقفة بروفة بنقرة واحدة. اضبط سرعة التمرير وحجم النص من شاشة التسجيل عند التمرين أو التصوير.';

  @override
  String get onboardingInteractiveStep2Title => 'تراكب الملقن';

  @override
  String get onboardingInteractiveStep4CardHint =>
      'يمكنك تغيير هذه الإعدادات في أي وقت من خلال إعدادات Android أو iOS.';

  @override
  String get onboardingInteractiveStep4Subtitle =>
      'يحتاج ScriptCam إلى كاميرا وميكروفون حتى تتمكن من رؤية نفسك بينما يظل البرنامج النصي متزامنًا مع وتيرتك.';

  @override
  String get onboardingInteractiveStep4Title => 'تسجيل الوصول';

  @override
  String get opacity => 'الشفافية';

  @override
  String get original => 'أصلي';

  @override
  String get overlaySettings => 'إعدادات التراكب';

  @override
  String get paste => 'لصق';

  @override
  String get permissionsRequired => 'أذونات الكاميرا والميكروفون مطلوبة.';

  @override
  String get preferences => 'التفضيلات';

  @override
  String get premium => 'بريميوم';

  @override
  String get premiumActive => 'قسط نشط';

  @override
  String get premiumBenefitInstantRecord =>
      'يحصل المستخدمون المميزون على تسجيل فوري ومزامنة صوتية!';

  @override
  String get premiumDescription =>
      'افتح جميع الميزات المميزة واستمتع بتجربة خالية من الإعلانات';

  @override
  String get premiumUnlocked => 'قسط مقفلة!';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get pro => 'PRO';

  @override
  String get processing => 'جاري المعالجة...';

  @override
  String purchaseErrorDetail(String p0) {
    return 'فشل الشراء: $p0';
  }

  @override
  String get purchaseFailedInitiate => 'لا يمكن بدء الشراء. حاول ثانية.';

  @override
  String get qualityHigh => 'عالي';

  @override
  String get qualityLabel => 'جودة';

  @override
  String get qualityLow => 'قليل';

  @override
  String get qualityStandard => 'معيار';

  @override
  String get range => 'النطاق';

  @override
  String get rateUs => 'قيمنا';

  @override
  String get ratio => 'النسبة';

  @override
  String get recent => 'مؤخرًا';

  @override
  String get recordingFailed => 'فشل التسجيل';

  @override
  String recordingsDeletedToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'تم حذف $count تسجيلات',
      one: 'تم حذف تسجيل واحد',
    );
    return '$_temp0';
  }

  @override
  String recordingsRemainingHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'تبقّى $count تسجيلات',
      one: 'تبقّى تسجيل واحد',
    );
    return '$_temp0 · شاهِد إعلانًا للمزيد';
  }

  @override
  String get recordNow => 'سجل الآن';

  @override
  String get remoteControl => 'ريموت بلوتوث ولوحة مفاتيح';

  @override
  String get remoteControlLocked =>
      'يعد جهاز التحكم عن بعد ولوحة المفاتيح بتقنية Bluetooth ميزة مميزة';

  @override
  String get removeAds => 'إزالة الإعلانات';

  @override
  String get rename => 'إعادة تسمية';

  @override
  String get resolution => 'الدقة';

  @override
  String get restore => 'يعيد';

  @override
  String get restoredSuccessfully => 'تمت استعادة المشتريات بنجاح.';

  @override
  String restoreFailed(String error) {
    return 'فشلت الاستعادة: $error';
  }

  @override
  String get restorePurchaseLink => 'استعادة الشراء';

  @override
  String get retry => 'أعد المحاولة';

  @override
  String get rewardGranted => 'المكافأة الممنوحة: +3 تسجيلات';

  @override
  String get rotate => 'تدوير';

  @override
  String get save => 'حفظ';

  @override
  String get saveButton => 'يحفظ';

  @override
  String get saved => 'تم الحفظ';

  @override
  String savedAs(String p0) {
    return 'تم الحفظ باسم $p0';
  }

  @override
  String get saveEditorLabel => 'يحفظ';

  @override
  String get saveFailed => 'فشل الحفظ';

  @override
  String get saveFailedEmpty => 'لا شيء للحفظ';

  @override
  String get saveFailedGallery => 'لا يمكن الحفظ في المعرض';

  @override
  String get saveFailedNotFound => 'لم يتم العثور على موقع الحفظ';

  @override
  String get saveVideo => 'حفظ الفيديو';

  @override
  String get savingEllipsis => 'توفير…';

  @override
  String get scriptContentPlaceholder => 'ابدأ كتابة نصك هنا...';

  @override
  String get scriptDeleted => 'تم حذف النص';

  @override
  String scriptSummary(String p0, String p1) {
    return '$p0 · $p1';
  }

  @override
  String get scriptTitleHint => 'مثال: مقدمة يوتيوب';

  @override
  String get scriptTitlePlaceholder => 'عنوان النص...';

  @override
  String get scrollSpeed => 'سرعة التمرير';

  @override
  String get searchScripts => 'البحث عن نصوص...';

  @override
  String get selectedScriptReady => 'البرنامج النصي المحدد جاهز';

  @override
  String get selectLanguage => 'اختر اللغة';

  @override
  String get selectLanguageDesc => 'اختر لغتك المفضلة للتطبيق';

  @override
  String get selectPlatformDesc => 'اختر منصة لنصك';

  @override
  String get settings => 'الإعدادات';

  @override
  String get shareApp => 'مشاركة التطبيق';

  @override
  String shareAppMessage(String url) {
    return 'سجل مقاطع فيديو احترافية بثقة باستخدام ScriptCam! 🎥✨\n\nيحتوي على تلقين مدمج، تسجيل 4K، ومحرر فيديو. جربه هنا:\n$url';
  }

  @override
  String get shareAppSubject => 'تحقق من ScriptCam: تلقين الفيديو';

  @override
  String get shareVideoSubject => 'تحقق من الفيديو الخاص بي';

  @override
  String get shareVideoText => 'تم تسجيل الفيديو باستخدام ScriptCam';

  @override
  String get signInCancelled => 'تم إلغاء تسجيل الدخول.';

  @override
  String get softStart => 'بداية ناعمة';

  @override
  String get speed => 'السرعة';

  @override
  String get speedFast => 'سريع';

  @override
  String get speedNormal => 'طبيعي';

  @override
  String get speedSlow => 'بطيء';

  @override
  String get speedTurbo => 'توربيني';

  @override
  String get startFreeTrial => 'ابدأ النسخة التجريبية المجانية';

  @override
  String get startRecording => 'بدء التسجيل';

  @override
  String get startYourJourney => 'ابدأ رحلتك';

  @override
  String get step1Desc => 'ابدأ بإنشاء نص جديد أو تسجيل سريع بدون نص';

  @override
  String get step1Title => 'إنشاء نص';

  @override
  String get step2Desc =>
      'اضبط السرعة وحجم الخط وفعل مزامنة الصوت للتمرير بدون استخدام اليدين';

  @override
  String get step2Title => 'إعداد التلقين';

  @override
  String get step3Desc => 'اضغط على تسجيل واقرأ نصك أثناء النظر إلى الكاميرا';

  @override
  String get step3Title => 'سجل الفيديو الخاص بك';

  @override
  String get step4Desc =>
      'استخدم محرر الفيديو للقص والضبط وتطبيق الفلاتر قبل المشاركة';

  @override
  String get step4Title => 'التحرير والمشاركة';

  @override
  String get step5Desc =>
      'استخدم جهاز التحكم عن بعد أو لوحة المفاتيح التي تعمل بتقنية Bluetooth للتشغيل والإيقاف المؤقت وضبط سرعة التمرير.';

  @override
  String get step5Title => 'التحكم عن بعد';

  @override
  String get storePricingUnavailable => 'أسعار المتجر غير متاحة حاليًا.';

  @override
  String get storeUnavailable => 'المتجر غير متوفر. حاول مرة أخرى لاحقًا.';

  @override
  String get stripView => 'عرض الشريط';

  @override
  String get studioEditor => 'محرر الاستوديو';

  @override
  String get support => 'الدعم';

  @override
  String get supportBody => 'مرحبًا فريق ScriptCam،';

  @override
  String get supportSubject => 'دعم سكريبت كام';

  @override
  String get switchAccount => 'تبديل الحساب';

  @override
  String get system => 'النظام';

  @override
  String get systemDefault => 'افتراضي النظام';

  @override
  String get tabCamera => 'الكاميرا';

  @override
  String get tabRecordings => 'التسجيلات';

  @override
  String get tabScripts => 'النصوص';

  @override
  String get targetFps => 'FPS المستهدف';

  @override
  String get text => 'نص';

  @override
  String get textPasted => 'تم لصق النص';

  @override
  String get titleRequired => 'العنوان مطلوب';

  @override
  String get transform => 'تحويل';

  @override
  String get trim => 'قص';

  @override
  String get unexpectedError => 'حدث خطأ ما';

  @override
  String get unexpectedErrorDesc => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.';

  @override
  String get unlimitedRecordings => 'تسجيلات غير محدودة';

  @override
  String get unlimitedScripts => 'نصوص غير محدودة';

  @override
  String get unlockAllFeatures => 'افتح جميع الميزات وأزل الإعلانات';

  @override
  String get unlockCreatorPro => 'فتح Creator Pro';

  @override
  String get untitledScript => 'سيناريو بدون عنوان';

  @override
  String get upgradeForLifetime => 'ترقية للوصول مدى الحياة';

  @override
  String get upgradeToPro => 'الترقية إلى Pro';

  @override
  String get useASavedScript => 'استخدم البرنامج النصي المحفوظ';

  @override
  String get version => 'الإصدار';

  @override
  String get videoDeleted => 'تم حذف الفيديو';

  @override
  String get videoFileNotFound => 'لم يتم العثور على ملف الفيديو';

  @override
  String get videoName => 'اسم الملف';

  @override
  String get videoNameHint => 'MyVideo';

  @override
  String get videoSettings => 'إعدادات الفيديو';

  @override
  String get voiceSync => 'مزامنة الصوت';

  @override
  String get voiceSyncFeature => 'مزامنة الصوت';

  @override
  String get voiceSyncLocked => 'تعد المزامنة الصوتية ميزة مميزة';

  @override
  String get watchAdGetRecordings =>
      'شاهد إعلانًا واحدًا → احصل على +3 تسجيلات';

  @override
  String get watchAdToRecord => 'شاهد الإعلان للتسجيل';

  @override
  String get watchAdToRecordDesc =>
      'شاهد إعلانًا قصيرًا لفتح التسجيل لهذا البرنامج النصي.';

  @override
  String get weeklyPlan => 'أسبوعي';

  @override
  String get weeklyPriceNotLoaded =>
      'السعر الأسبوعي لم يتم تحميله من المتجر بعد.';

  @override
  String get weeklyTrialStorePrice =>
      'نسخة تجريبية مجانية لمدة 3 أيام، السعر الأسبوعي من المتجر';

  @override
  String weeklyTrialThenPrice(String price) {
    return 'نسخة تجريبية مجانية لمدة 3 أيام، ثم $price / الأسبوع';
  }

  @override
  String get whatAreYouRecording => 'ما أنت\nتسجيل اليوم؟';

  @override
  String get width => 'عرض';

  @override
  String get widthFull => 'ممتلىء';

  @override
  String get widthMedium => 'واسطة';

  @override
  String get widthNarrow => 'ضيق';

  @override
  String get wifiOnly => 'واي فاي فقط';

  @override
  String wordCountShort(int count) {
    return '$count كلمة';
  }

  @override
  String get words => 'كلمات';

  @override
  String get youAreNowPremium => 'أنت الآن بريميوم!';

  @override
  String get stopRecordingTitle => 'إيقاف التسجيل؟';

  @override
  String get stopRecordingMessage =>
      'التسجيل متوقف مؤقتاً. هل أنت متأكد أنك تريد الخروج؟ سيتم حذف التسجيل الحالي.';
}
