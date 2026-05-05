// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get about => 'के बारे में';

  @override
  String get addOrSelectScriptPrompt =>
      'टेलीप्रॉम्प्टर ओवरले के साथ रिकॉर्डिंग शुरू करने के लिए एक स्क्रिप्ट जोड़ें या चुनें।';

  @override
  String get adjust => 'समायोजित करें';

  @override
  String get adNotAvailable => 'विज्ञापन अनुपलब्ध';

  @override
  String get adNotAvailableDesc =>
      'हम कोई विज्ञापन लोड नहीं कर सके. थोड़ी देर में पुनः प्रयास करें.';

  @override
  String get adNotCompleted => 'विज्ञापन ख़त्म नहीं हुआ';

  @override
  String get adNotCompletedDesc =>
      'रिकॉर्डिंग क्रेडिट अर्जित करने के लिए पूरा विज्ञापन देखें।';

  @override
  String get all => 'सभी';

  @override
  String get allScriptsTitle => 'सभी स्क्रिप्ट';

  @override
  String get appearance => 'दिखावट';

  @override
  String get appInfoDescription =>
      'सामग्री निर्माताओं के लिए अंतिम टेलीप्रॉम्प्टर और वीडियो रिकॉर्डिंग टूल। बनाएँ, पढ़ें और रिकॉर्ड करें बिना किसी रुकावट के।';

  @override
  String get appInfoTitle => 'ScriptCam';

  @override
  String get appTitle => 'ScriptCam';

  @override
  String get autoBackup => 'स्वचालित बैकअप';

  @override
  String get autoSync => 'स्वतः सिंक';

  @override
  String get backCamera => 'पीछे';

  @override
  String get background => 'पृष्ठभूमि';

  @override
  String backupFailedDetail(String error) {
    return 'बैकअप त्रुटि: $error';
  }

  @override
  String get backupNow => 'अब समर्थन देना';

  @override
  String get backupVideos => 'बैकअप वीडियो';

  @override
  String bulkDeleteRecordingsTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count रिकॉर्डिंग हटाएं?',
      one: 'यह रिकॉर्डिंग हटाएं?',
    );
    return '$_temp0';
  }

  @override
  String get cameraPreviewWithOverlay =>
      'लाइव टेलीप्रॉम्प्टर ओवरले के साथ कैमरा पूर्वावलोकन।';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get close => 'बंद करें';

  @override
  String get cloudBackup => 'मेघ बैकअप';

  @override
  String get connected => 'जुड़े हुए';

  @override
  String get connectGoogleDrive => 'Google ड्राइव कनेक्ट करें';

  @override
  String get connectionError =>
      'संपर्क त्रुटि। अपना इंटरनेट जाँचें और पुनः प्रयास करें।';

  @override
  String get contactUs => 'संपर्क करें';

  @override
  String get continueButton => 'जारी रखें';

  @override
  String get couldNotLoadVideo => 'वीडियो लोड नहीं हो सका';

  @override
  String get countdownTimer => 'उल्टी गिनती करने वाली घड़ी';

  @override
  String get created => 'बनाया गया!';

  @override
  String get createNewScript => 'नई स्क्रिप्ट बनाएं';

  @override
  String creditsRemaining(int count) {
    return 'क्रेडिट $count';
  }

  @override
  String get cueCards => 'क्यू कार्ड';

  @override
  String currentCreditsDescription(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'इस स्क्रिप्ट के लिए आपके पास $count मुफ्त रिकॉर्डिंगें बची हैं।',
      one: 'इस स्क्रिप्ट के लिए आपके पास 1 मुफ्त रिकॉर्डिंग बची है।',
    );
    return '$_temp0';
  }

  @override
  String get dark => 'डार्क';

  @override
  String get darkMode => 'डार्क मोड';

  @override
  String get defaultCamera => 'डिफ़ॉल्ट कैमरा';

  @override
  String get delete => 'हटाएँ';

  @override
  String get deleteScriptMessage => 'यह कार्रवाई पूर्ववत नहीं की जा सकती।';

  @override
  String get deleteScriptTitle => 'स्क्रिप्ट हटाएँ?';

  @override
  String get deleteVideoTitle => 'वीडियो हटाएं?';

  @override
  String get discard => 'खारिज करना';

  @override
  String get discardChanges => 'परिवर्तनों को निरस्त करें?';

  @override
  String get discardChangesDesc => 'आपके संपादन खो जायेंगे.';

  @override
  String get disconnect => 'डिस्कनेक्ट';

  @override
  String get discountBadge => '20% की छूट';

  @override
  String get duplicate => 'डुप्लिकेट';

  @override
  String durationMinutesSecondsShort(int minutes, int seconds) {
    return '$minutes:$seconds';
  }

  @override
  String durationSecondsShort(int seconds) {
    return '$seconds';
  }

  @override
  String get earnRecordingCredits => 'रिकॉर्डिंग क्रेडिट अर्जित करें';

  @override
  String get edit => 'संपादित करें';

  @override
  String get editScript => 'स्क्रिप्ट एडिट करें';

  @override
  String get editScriptBlockedDuringCountdown =>
      'संपादन से पहले उलटी गिनती समाप्त होने की प्रतीक्षा करें।';

  @override
  String get editScriptBlockedWhileRecording =>
      'अपनी स्क्रिप्ट संपादित करने के लिए रिकॉर्डिंग बंद करें।';

  @override
  String get emptyCreativeSpaceMessage =>
      'आपका रचनात्मक स्थान खाली है। अपनी पहली स्क्रिप्ट बनाएं या तुरंत कुछ रिकॉर्ड करने का प्रयास करें!';

  @override
  String get emptyGallery => 'अभी तक कोई वीडियो नहीं';

  @override
  String get emptyGalleryDesc =>
      'इसे यहाँ देखने के लिए अपना पहला वीडियो रिकॉर्ड करें';

  @override
  String errorSharingVideo(String error) {
    return 'वीडियो साझा नहीं किया जा सका: $error';
  }

  @override
  String exportedScriptSubject(String title) {
    return 'निर्यातित स्क्रिप्ट: $title';
  }

  @override
  String get exportQuality => 'निर्यात गुणवत्ता';

  @override
  String get exportSuccess => 'स्क्रिप्ट सफलतापूर्वक निर्यात की गई';

  @override
  String get focusLine => 'फोकस रेखा';

  @override
  String get font => 'फ़ॉन्ट';

  @override
  String get fontSize => 'फ़ॉन्ट आकार';

  @override
  String freeRecordingsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count मुफ्त रिकॉर्डिंगें शेष',
      one: '1 मुफ्त रिकॉर्डिंग शेष',
    );
    return '$_temp0';
  }

  @override
  String get freeTrialCancelAnytime =>
      'नि:शुल्क परीक्षण तुरंत प्रारंभ होता है. नवीनीकरण से पहले कभी भी रद्द करें।';

  @override
  String get frontCamera => 'सामने';

  @override
  String get fullDuration => 'भरा हुआ';

  @override
  String get general => 'सामान्य';

  @override
  String get getPremium => 'प्रीमियम प्राप्त करें';

  @override
  String get googleUser => 'गूगल उपयोगकर्ता';

  @override
  String get goPremium => 'प्रीमियम के लिए जाएँ';

  @override
  String get gotIt => 'समझ गया';

  @override
  String get grantAccess => 'एक्सेस दें';

  @override
  String get help => 'मदद';

  @override
  String get highQualityVideo => 'उच्च गुणवत्ता वाला वीडियो';

  @override
  String get howToUse => 'कैसे उपयोग करें';

  @override
  String get howToUseTitle => 'ScriptCam कैसे उपयोग करें';

  @override
  String get importScript => 'आयात';

  @override
  String get importSuccess => 'स्क्रिप्ट सफलतापूर्वक आयात की गई';

  @override
  String itemsSelected(int count) {
    return '$count चयनित';
  }

  @override
  String get keepEditing => 'संपादन करते रहें';

  @override
  String get language => 'भाषा';

  @override
  String get lifetimeNoRecurringBilling =>
      'लाइफटाइम अनलॉक. कोई आवर्ती बिलिंग नहीं.';

  @override
  String get lifetimeOneTimeUnlock =>
      'एक बार खरीदे। एक बार भुगतान करें, हमेशा के लिए अनलॉक करें।';

  @override
  String get lifetimePlan => 'आजीवन योजना';

  @override
  String get lifetimePriceNotLoaded =>
      'लाइफ़टाइम कीमत अभी तक स्टोर से लोड नहीं की गई है।';

  @override
  String get light => 'लाइट';

  @override
  String get lightMode => 'लाइट मोड';

  @override
  String get lineSpacing => 'पंक्ति रिक्ति';

  @override
  String get loop => 'कुंडली';

  @override
  String get managePremiumStatus => 'अपनी प्रीमियम स्थिति प्रबंधित करें';

  @override
  String get minRead => 'मिनट पढ़ें';

  @override
  String get mirror => 'मिरर';

  @override
  String get mute => 'म्यूट';

  @override
  String get never => 'कभी नहीं';

  @override
  String get newScript => 'नई स्क्रिप्ट';

  @override
  String get newScriptMultiline => 'नया\nस्क्रिप्ट';

  @override
  String get next => 'अगला';

  @override
  String get noAds => 'हमेशा के लिए कोई विज्ञापन नहीं';

  @override
  String get noInternetDesc =>
      'ऐसा लगता है कि आप ऑफ़लाइन हैं. अपने कनेक्शन की जांच करें और पुन: प्रयास करें।';

  @override
  String get noInternetError => 'कोई इंटरनेट नहीं';

  @override
  String get noInternetErrorDesc =>
      'इंटरनेट से कनेक्ट करें और पुनः प्रयास करें।';

  @override
  String get noInternetTitle => 'कोई इंटरनेट कनेक्शन नहीं';

  @override
  String get noRecordingsLeft =>
      'कोई रिकॉर्डिंग नहीं बची · जारी रखने के लिए विज्ञापन देखें';

  @override
  String get noResultsFound => 'कोई परिणाम नहीं मिला';

  @override
  String get noResultsMessage =>
      'हमें आपकी खोज से मेल खाने वाली कोई स्क्रिप्ट नहीं मिली। अलग कीवर्ड आज़माएं!';

  @override
  String get noSavedScriptSelected => 'कोई सहेजी गई स्क्रिप्ट चयनित नहीं';

  @override
  String get notAuthenticated => 'Google में साइन इन नहीं है.';

  @override
  String get off => 'बंद';

  @override
  String get onboardingAccessCamera => 'कैमरा';

  @override
  String get onboardingAccessMic => 'माइक्रोफ़ोन';

  @override
  String get onboardingInteractiveRecLabel => 'आरईसी';

  @override
  String get onboardingInteractiveStep1Eyebrow => 'प्रमुख राय';

  @override
  String get onboardingInteractiveStep1Preview =>
      'ओवरले स्क्रिप्ट और फ़्रेमिंग एक साथ दृश्यमान रहते हैं। रिहर्सल करने के लिए स्क्रॉल करें; जब गति सही लगे तो रिकॉर्डिंग शुरू करें।';

  @override
  String get onboardingInteractiveStep1Subtitle =>
      'स्क्रिप्टकैम कैप्चर पर केन्द्रित है। स्क्रिप्ट, क्रेडिट और सेटिंग आप जो भी फिल्माते हैं उसे प्रभावित किए बिना पहुंच योग्य रहते हैं।';

  @override
  String get onboardingInteractiveStep1Title => 'रिकॉर्डिंग-प्रथम कार्यक्षेत्र';

  @override
  String get onboardingInteractiveStep2Sample =>
      'सुप्रभात—यहां आने के लिए धन्यवाद।\nहम इसे संक्षिप्त और व्यावहारिक रखेंगे।\nयदि आप लेंस से भटक जाते हैं, तो जानबूझकर वापस स्थिर हो जाएं और आगे बढ़ें।';

  @override
  String get onboardingInteractiveStep2Subtitle =>
      'एक टैप से रिहर्सल रोकें। जब आप रिहर्सल करते हैं या शूट करते हैं तो रिकॉर्डिंग स्क्रीन से स्क्रॉल पेसिंग और टेक्स्ट आकार समायोजित करें।';

  @override
  String get onboardingInteractiveStep2Title => 'टेलीप्रॉम्प्टर ओवरले';

  @override
  String get onboardingInteractiveStep4CardHint =>
      'आप इन्हें एंड्रॉइड या आईओएस सेटिंग्स में कभी भी बदल सकते हैं।';

  @override
  String get onboardingInteractiveStep4Subtitle =>
      'स्क्रिप्टकैम को कैमरे और माइक्रोफ़ोन की आवश्यकता होती है ताकि जब स्क्रिप्ट आपकी गति के साथ तालमेल में रहे तो आप स्वयं देख सकें।';

  @override
  String get onboardingInteractiveStep4Title => 'रिकॉर्डिंग का उपयोग';

  @override
  String get opacity => 'अपारदर्शिता';

  @override
  String get original => 'मूल';

  @override
  String get overlaySettings => 'ओवरले सेटिंग्स';

  @override
  String get paste => 'पेस्ट';

  @override
  String get permissionsRequired => 'कैमरा और माइक्रोफ़ोन अनुमति आवश्यक हैं।';

  @override
  String get preferences => 'प्राथमिकताएँ';

  @override
  String get premium => 'प्रीमियम';

  @override
  String get premiumActive => 'प्रीमियम सक्रिय';

  @override
  String get premiumBenefitInstantRecord =>
      'प्रीमियम उपयोगकर्ताओं को तुरंत रिकॉर्डिंग और वॉयस सिंक मिलता है!';

  @override
  String get premiumDescription =>
      'सभी प्रीमियम सुविधाओं को अनलॉक करें और विज्ञापन-मुक्त अनुभव का आनंद लें';

  @override
  String get premiumUnlocked => 'प्रीमियम अनलॉक!';

  @override
  String get privacyPolicy => 'गोपनीयता नीति';

  @override
  String get pro => 'प्रो';

  @override
  String get processing => 'प्रोसेसिंग...';

  @override
  String purchaseErrorDetail(String p0) {
    return 'खरीदारी विफल: $p0';
  }

  @override
  String get purchaseFailedInitiate =>
      'खरीदारी प्रारंभ नहीं हो सकी. पुनः प्रयास करें।';

  @override
  String get qualityHigh => 'उच्च';

  @override
  String get qualityLabel => 'गुणवत्ता';

  @override
  String get qualityLow => 'कम';

  @override
  String get qualityStandard => 'मानक';

  @override
  String get range => 'रेंज';

  @override
  String get rateUs => 'हमें रेट करें';

  @override
  String get ratio => 'अनुपात';

  @override
  String get recent => 'हाल ही का';

  @override
  String get recordingFailed => 'रिकॉर्डिंग विफल';

  @override
  String recordingsDeletedToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count रिकॉर्डिंग हटाई गईं',
      one: '1 रिकॉर्डिंग हटाई गई',
    );
    return '$_temp0';
  }

  @override
  String recordingsRemainingHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count रिकॉर्डिंगें शेष',
      one: '1 रिकॉर्डिंग शेष',
    );
    return '$_temp0 · और पाने के लिए विज्ञापन देखें';
  }

  @override
  String get recordNow => 'अभी रिकॉर्ड करें';

  @override
  String get remoteControl => 'ब्लूटूथ रिमोट और कीबोर्ड';

  @override
  String get remoteControlLocked =>
      'ब्लूटूथ रिमोट और कीबोर्ड एक प्रीमियम फीचर है';

  @override
  String get removeAds => 'विज्ञापन हटाएं';

  @override
  String get rename => 'नाम बदलें';

  @override
  String get resolution => 'रिज़ॉल्यूशन';

  @override
  String get restore => 'पुनर्स्थापित करना';

  @override
  String get restoredSuccessfully => 'खरीदारी सफलतापूर्वक बहाल हो गई.';

  @override
  String restoreFailed(String error) {
    return 'पुनर्स्थापना विफल: $error';
  }

  @override
  String get restorePurchaseLink => 'खरीद बहाल करें';

  @override
  String get retry => 'पुन: प्रयास करें';

  @override
  String get rewardGranted => 'इनाम दिया गया: +3 रिकॉर्डिंग';

  @override
  String get rotate => 'घुमाएं';

  @override
  String get save => 'सहेजें';

  @override
  String get saveButton => 'बचाना';

  @override
  String get saved => 'सहेजा गया';

  @override
  String savedAs(String p0) {
    return '$p0 के रूप में सहेजा गया';
  }

  @override
  String get saveEditorLabel => 'बचाना';

  @override
  String get saveFailed => 'सहेजना विफल';

  @override
  String get saveFailedEmpty => 'बचाने के लिए कुछ भी नहीं';

  @override
  String get saveFailedGallery => 'गैलरी में सहेजा नहीं जा सका';

  @override
  String get saveFailedNotFound => 'स्थान सहेजें नहीं मिला';

  @override
  String get saveVideo => 'वीडियो सहेजें';

  @override
  String get savingEllipsis => 'सहेजा जा रहा है...';

  @override
  String get scriptContentPlaceholder =>
      'अपनी स्क्रिप्ट यहाँ लिखना शुरू करें...';

  @override
  String get scriptDeleted => 'स्क्रिप्ट हटा दी गई';

  @override
  String scriptSummary(String p0, String p1) {
    return '$p0 · $p1';
  }

  @override
  String get scriptTitleHint => 'जैसे YouTube इंट्रो';

  @override
  String get scriptTitlePlaceholder => 'स्क्रिप्ट शीर्षक...';

  @override
  String get scrollSpeed => 'स्क्रॉल गति';

  @override
  String get searchScripts => 'स्क्रिप्ट खोजें...';

  @override
  String get selectedScriptReady => 'चयनित स्क्रिप्ट तैयार';

  @override
  String get selectLanguage => 'भाषा चुनें';

  @override
  String get selectLanguageDesc => 'ऐप के लिए अपनी पसंदीदा भाषा चुनें';

  @override
  String get selectPlatformDesc => 'अपनी स्क्रिप्ट के लिए एक प्लेटफ़ॉर्म चुनें';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get shareApp => 'ऐप शेयर करें';

  @override
  String shareAppMessage(String url) {
    return 'ScriptCam के साथ आत्मविश्वास से पेशेवर वीडियो रिकॉर्ड करें! 🎥✨\n\nइसमें अंतर्निर्मित टेलीप्रॉम्प्टर, 4K रिकॉर्डिंग और वीडियो एडिटर है। यहाँ आज़माएँ:\n$url';
  }

  @override
  String get shareAppSubject => 'ScriptCam देखें: वीडियो टेलीप्रॉम्प्टर';

  @override
  String get shareVideoSubject => 'मेरा वीडियो देखें';

  @override
  String get shareVideoText => 'स्क्रिप्टकैम से रिकॉर्ड किया गया वीडियो';

  @override
  String get signInCancelled => 'साइन-इन रद्द कर दिया गया.';

  @override
  String get softStart => 'नरम शुरुआत';

  @override
  String get speed => 'गति';

  @override
  String get speedFast => 'तेज़';

  @override
  String get speedNormal => 'सामान्य';

  @override
  String get speedSlow => 'धीमा';

  @override
  String get speedTurbo => 'टर्बो';

  @override
  String get startFreeTrial => 'निशुल्क आजमाइश शुरु करें';

  @override
  String get startRecording => 'रिकॉर्डिंग शुरू करें';

  @override
  String get startYourJourney => 'अपनी यात्रा शुरू करें';

  @override
  String get step1Desc =>
      'एक नई स्क्रिप्ट या बिना टेक्स्ट के क्विक रिकॉर्ड बनाकर शुरुआत करें';

  @override
  String get step1Title => 'एक स्क्रिप्ट बनाएँ';

  @override
  String get step2Desc =>
      'गति, फ़ॉन्ट आकार समायोजित करें और हैंड्स-फ्री स्क्रॉलिंग के लिए वॉयस सिंक सक्षम करें';

  @override
  String get step2Title => 'टेलीप्रॉम्प्टर सेटअप करें';

  @override
  String get step3Desc =>
      'रिकॉर्ड दबाएं और कैमरे को देखते हुए अपनी स्क्रिप्ट पढ़ें';

  @override
  String get step3Title => 'अपना वीडियो रिकॉर्ड करें';

  @override
  String get step4Desc =>
      'साझा करने से पहले वीडियो एडिटर का उपयोग ट्रिम, समायोजित और फ़िल्टर लागू करने के लिए करें';

  @override
  String get step4Title => 'संपादित करें और साझा करें';

  @override
  String get step5Desc =>
      'चलाने, रोकने और स्क्रॉल गति को समायोजित करने के लिए ब्लूटूथ रिमोट या कीबोर्ड का उपयोग करें।';

  @override
  String get step5Title => 'रिमोट कंट्रोल';

  @override
  String get storePricingUnavailable =>
      'स्टोर मूल्य निर्धारण अभी उपलब्ध नहीं है।';

  @override
  String get storeUnavailable => 'स्टोर अनुपलब्ध है. बाद में पुन: प्रयास।';

  @override
  String get stripView => 'पट्टी का दृश्य';

  @override
  String get studioEditor => 'स्टूडियो संपादक';

  @override
  String get support => 'सहयोग';

  @override
  String get supportBody => 'नमस्ते स्क्रिप्टकैम टीम,';

  @override
  String get supportSubject => 'स्क्रिप्टकैम समर्थन';

  @override
  String get switchAccount => 'खाता स्थानांतरित करें';

  @override
  String get system => 'सिस्टम';

  @override
  String get systemDefault => 'सिस्टम डिफ़ॉल्ट';

  @override
  String get tabCamera => 'कैमरा';

  @override
  String get tabRecordings => 'रिकॉर्डिंग';

  @override
  String get tabScripts => 'स्क्रिप्ट';

  @override
  String get targetFps => 'लक्ष्य FPS';

  @override
  String get text => 'मूलपाठ';

  @override
  String get textPasted => 'टेक्स्ट पेस्ट किया गया';

  @override
  String get titleRequired => 'शीर्षक आवश्यक';

  @override
  String get transform => 'बदलें';

  @override
  String get trim => 'ट्रिम';

  @override
  String get unexpectedError => 'कुछ गलत हो गया';

  @override
  String get unexpectedErrorDesc => 'कुछ गलत हो गया। कृपया पुन: प्रयास करें।';

  @override
  String get unlimitedRecordings => 'असीमित रिकॉर्डिंग';

  @override
  String get unlimitedScripts => 'असीमित स्क्रिप्ट';

  @override
  String get unlockAllFeatures => 'सभी सुविधाएँ अनलॉक करें और विज्ञापन हटाएँ';

  @override
  String get unlockCreatorPro => 'क्रिएटर प्रो अनलॉक करें';

  @override
  String get untitledScript => 'शीर्षक रहित स्क्रिप्ट';

  @override
  String get upgradeForLifetime => 'जीवनभर की पहुंच के लिए अपग्रेड करें';

  @override
  String get upgradeToPro => 'प्रो में अपग्रेड करें';

  @override
  String get useASavedScript => 'किसी सहेजी गई स्क्रिप्ट का उपयोग करें';

  @override
  String get version => 'संस्करण';

  @override
  String get videoDeleted => 'वीडियो हटा दिया गया';

  @override
  String get videoFileNotFound => 'वीडियो फ़ाइल नहीं मिली';

  @override
  String get videoName => 'फ़ाइल का नाम';

  @override
  String get videoNameHint => 'मेरा वीडियो';

  @override
  String get videoSettings => 'वीडियो सेटिंग्स';

  @override
  String get voiceSync => 'वॉयस सिंक';

  @override
  String get voiceSyncFeature => 'आवाज समन्वयन';

  @override
  String get voiceSyncLocked => 'वॉयस सिंक एक प्रीमियम फीचर है';

  @override
  String get watchAdGetRecordings =>
      '1 विज्ञापन देखें → +3 रिकॉर्डिंग प्राप्त करें';

  @override
  String get watchAdToRecord => 'रिकॉर्ड करने के लिए विज्ञापन देखें';

  @override
  String get watchAdToRecordDesc =>
      'इस स्क्रिप्ट की रिकॉर्डिंग अनलॉक करने के लिए एक छोटा विज्ञापन देखें।';

  @override
  String get weeklyPlan => 'साप्ताहिक';

  @override
  String get weeklyPriceNotLoaded =>
      'साप्ताहिक मूल्य अभी तक स्टोर से लोड नहीं किया गया है।';

  @override
  String get weeklyTrialStorePrice =>
      '3 दिन का निःशुल्क परीक्षण, स्टोर से साप्ताहिक मूल्य';

  @override
  String weeklyTrialThenPrice(String price) {
    return '3 दिन का निःशुल्क परीक्षण, फिर $price/सप्ताह';
  }

  @override
  String get whatAreYouRecording => 'आप क्या हैं?\nआज रिकॉर्डिंग?';

  @override
  String get width => 'चौड़ाई';

  @override
  String get widthFull => 'भरा हुआ';

  @override
  String get widthMedium => 'मध्यम';

  @override
  String get widthNarrow => 'सँकरा';

  @override
  String get wifiOnly => 'केवल वाईफाई';

  @override
  String wordCountShort(int count) {
    return '$count शब्द';
  }

  @override
  String get words => 'शब्द';

  @override
  String get youAreNowPremium => 'अब आप प्रीमियम हैं!';
}
