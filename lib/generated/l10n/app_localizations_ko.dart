// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get about => '정보';

  @override
  String get addOrSelectScriptPrompt =>
      '텔레프롬프터 오버레이로 녹화를 시작하려면 스크립트를 추가하거나 선택하세요.';

  @override
  String get adjust => '조정';

  @override
  String get adNotAvailable => '광고를 사용할 수 없음';

  @override
  String get adNotAvailableDesc => '광고를 로드할 수 없습니다. 잠시 후에 다시 시도해 보세요.';

  @override
  String get adNotCompleted => '광고가 끝나지 않았습니다';

  @override
  String get adNotCompletedDesc => '전체 광고를 시청하여 녹음 크레딧을 획득하세요.';

  @override
  String get all => '전체';

  @override
  String get allScriptsTitle => '모든 스크립트';

  @override
  String get appearance => '외관';

  @override
  String get appInfoDescription =>
      '콘텐츠 제작자를 위한 궁극의 텔레프롬프터 및 비디오 녹화 도구. 원활하게 생성, 읽기 및 녹화하세요.';

  @override
  String get appInfoTitle => 'ScriptCam';

  @override
  String get appTitle => 'ScriptCam';

  @override
  String get autoBackup => '자동 백업';

  @override
  String get autoSync => '자동 동기화';

  @override
  String get backCamera => '뒤쪽에';

  @override
  String get background => '배경';

  @override
  String backupFailedDetail(String error) {
    return '백업 오류: $error';
  }

  @override
  String get backupNow => '지금 백업';

  @override
  String get backupVideos => '백업 비디오';

  @override
  String bulkDeleteRecordingsTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '녹화 $count개를 삭제할까요?',
      one: '이 녹화를 삭제할까요?',
    );
    return '$_temp0';
  }

  @override
  String get cameraPreviewWithOverlay => '라이브 텔레프롬프터 오버레이를 통한 카메라 미리보기.';

  @override
  String get cancel => '취소';

  @override
  String get close => '닫기';

  @override
  String get cloudBackup => '클라우드 백업';

  @override
  String get connected => '연결됨';

  @override
  String get connectGoogleDrive => 'Google 드라이브 연결';

  @override
  String get connectionError => '연결 오류입니다. 인터넷을 확인하고 다시 시도하세요.';

  @override
  String get contactUs => '문의하기';

  @override
  String get continueButton => '계속';

  @override
  String get couldNotLoadVideo => '동영상을 로드할 수 없습니다.';

  @override
  String get countdownTimer => '카운트다운 타이머';

  @override
  String get created => '생성됨!';

  @override
  String get createNewScript => '새 스크립트 만들기';

  @override
  String creditsRemaining(int count) {
    return '크레딧 $count';
  }

  @override
  String get cueCards => '큐 카드';

  @override
  String currentCreditsDescription(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '이 스크립트에 무료 녹화가 $count회 남았습니다.',
      one: '이 스크립트에 무료 녹화 1회가 남았습니다.',
    );
    return '$_temp0';
  }

  @override
  String get dark => '다크';

  @override
  String get darkMode => '다크 모드';

  @override
  String get defaultCamera => '기본 카메라';

  @override
  String get delete => '삭제';

  @override
  String get deleteScriptMessage => '이 작업은 취소할 수 없습니다.';

  @override
  String get deleteScriptTitle => '스크립트를 삭제하시겠습니까?';

  @override
  String get deleteVideoTitle => '비디오를 삭제하시겠습니까?';

  @override
  String get discard => '버리다';

  @override
  String get discardChanges => '변경사항을 삭제하시겠습니까?';

  @override
  String get discardChangesDesc => '수정사항이 손실됩니다.';

  @override
  String get disconnect => '연결 끊기';

  @override
  String get discountBadge => '20% 할인';

  @override
  String get duplicate => '복제하다';

  @override
  String durationMinutesSecondsShort(int minutes, int seconds) {
    return '$minutes:$seconds';
  }

  @override
  String durationSecondsShort(int seconds) {
    return '$seconds초';
  }

  @override
  String get earnRecordingCredits => '녹음 크레딧 획득';

  @override
  String get edit => '편집';

  @override
  String get editScript => '스크립트 편집';

  @override
  String get editScriptBlockedDuringCountdown =>
      '편집하기 전에 카운트다운이 완료될 때까지 기다리십시오.';

  @override
  String get editScriptBlockedWhileRecording => '스크립트를 편집하려면 녹음을 중지하세요.';

  @override
  String get emptyCreativeSpaceMessage =>
      '창작 공간이 비어 있습니다. 첫 번째 스크립트를 만들거나 즉석에서 녹화해 보세요!';

  @override
  String get emptyGallery => '아직 비디오가 없습니다';

  @override
  String get emptyGalleryDesc => '여기에서 보려면 첫 번째 비디오를 녹화하세요';

  @override
  String errorSharingVideo(String error) {
    return '동영상을 공유할 수 없습니다: $error';
  }

  @override
  String exportedScriptSubject(String title) {
    return '내보낸 스크립트: $title';
  }

  @override
  String get exportQuality => '수출 품질';

  @override
  String get exportSuccess => '스크립트를 성공적으로 내보냈습니다.';

  @override
  String get focusLine => '집중선';

  @override
  String get font => '세례반';

  @override
  String get fontSize => '글꼴 크기';

  @override
  String freeRecordingsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '무료 녹화 $count회 남음',
      one: '무료 녹화 1회 남음',
    );
    return '$_temp0';
  }

  @override
  String get freeTrialCancelAnytime => '무료 평가판이 즉시 시작됩니다. 갱신하기 전에 언제든지 취소하세요.';

  @override
  String get frontCamera => '앞쪽';

  @override
  String get fullDuration => '가득한';

  @override
  String get general => '일반';

  @override
  String get getPremium => '프리미엄 받기';

  @override
  String get googleUser => '구글 사용자';

  @override
  String get goPremium => '프리미엄으로 이동';

  @override
  String get gotIt => '알겠습니다';

  @override
  String get grantAccess => '액세스 허용';

  @override
  String get help => '도움말';

  @override
  String get highQualityVideo => '고품질 비디오';

  @override
  String get howToUse => '사용 방법';

  @override
  String get howToUseTitle => 'ScriptCam 사용 방법';

  @override
  String get importScript => '수입';

  @override
  String get importSuccess => '스크립트를 성공적으로 가져왔습니다.';

  @override
  String itemsSelected(int count) {
    return '$count개 선택됨';
  }

  @override
  String get keepEditing => '계속 수정하세요';

  @override
  String get language => '언어';

  @override
  String get lifetimeNoRecurringBilling => '평생 잠금 해제. 반복 청구가 없습니다.';

  @override
  String get lifetimeOneTimeUnlock => '일회성 구매. 한 번만 지불하면 영원히 잠금 해제됩니다.';

  @override
  String get lifetimePlan => '평생 계획';

  @override
  String get lifetimePriceNotLoaded => '평생 가격은 아직 매장에서 로드되지 않았습니다.';

  @override
  String get light => '라이트';

  @override
  String get lightMode => '라이트 모드';

  @override
  String get lineSpacing => '줄 간격';

  @override
  String get loop => '고리';

  @override
  String get managePremiumStatus => '프리미엄 상태 관리';

  @override
  String get minRead => '분 읽기';

  @override
  String get mirror => '미러';

  @override
  String get mute => '음소거';

  @override
  String get never => '절대';

  @override
  String get newScript => '새 스크립트';

  @override
  String get newScriptMultiline => '새로운\n스크립트';

  @override
  String get next => '다음';

  @override
  String get noAds => '영원히 광고가 없습니다';

  @override
  String get noInternetDesc => '오프라인 상태인 것 같습니다. 연결을 확인하고 다시 시도해 주세요.';

  @override
  String get noInternetError => '인터넷 없음';

  @override
  String get noInternetErrorDesc => '인터넷에 연결하고 다시 시도해 보세요.';

  @override
  String get noInternetTitle => '인터넷에 연결되어 있지 않음';

  @override
  String get noRecordingsLeft => '남은 녹음 없음 · 계속하려면 광고를 시청하세요';

  @override
  String get noResultsFound => '결과가 없습니다';

  @override
  String get noResultsMessage => '검색과 일치하는 스크립트를 찾을 수 없습니다. 다른 키워드를 시도하세요!';

  @override
  String get noSavedScriptSelected => '저장된 스크립트가 선택되지 않았습니다.';

  @override
  String get notAuthenticated => 'Google에 로그인하지 않았습니다.';

  @override
  String get off => '끄다';

  @override
  String get onboardingAccessCamera => '카메라';

  @override
  String get onboardingAccessMic => '마이크로폰';

  @override
  String get onboardingInteractiveRecLabel => '녹화';

  @override
  String get onboardingInteractiveStep1Eyebrow => '메인뷰';

  @override
  String get onboardingInteractiveStep1Preview =>
      '오버레이 스크립트와 프레이밍은 함께 표시됩니다. 스크롤하여 연습해 보세요. 속도가 적당하다고 느껴질 때 녹음을 시작하세요.';

  @override
  String get onboardingInteractiveStep1Subtitle =>
      'ScriptCam은 캡처에 중점을 둡니다. 촬영 내용을 복잡하게 만들지 않고도 스크립트, 크레딧 및 설정에 계속 접근할 수 있습니다.';

  @override
  String get onboardingInteractiveStep1Title => '녹음 우선 작업 공간';

  @override
  String get onboardingInteractiveStep2Sample =>
      '좋은 아침입니다. 여기 와주셔서 감사합니다.\n우리는 이것을 간단하고 실용적으로 유지할 것입니다.\n렌즈에서 벗어나면 의도적으로 자리를 잡고 계속 진행하세요.';

  @override
  String get onboardingInteractiveStep2Subtitle =>
      '탭 한 번으로 리허설을 일시 중지하세요. 리허설이나 촬영 시 녹화 화면에서 스크롤 간격과 텍스트 크기를 조정하세요.';

  @override
  String get onboardingInteractiveStep2Title => '텔레프롬프터 오버레이';

  @override
  String get onboardingInteractiveStep4CardHint =>
      'Android 또는 iOS 설정에서 언제든지 변경할 수 있습니다.';

  @override
  String get onboardingInteractiveStep4Subtitle =>
      'ScriptCam에는 스크립트가 속도에 맞춰 동기화되는 동안 자신을 볼 수 있도록 카메라와 마이크가 필요합니다.';

  @override
  String get onboardingInteractiveStep4Title => '녹음 액세스';

  @override
  String get opacity => '불투명도';

  @override
  String get original => '원본';

  @override
  String get overlaySettings => '오버레이 설정';

  @override
  String get paste => '붙여넣기';

  @override
  String get permissionsRequired => '카메라 및 마이크 권한이 필요합니다.';

  @override
  String get preferences => '환경설정';

  @override
  String get premium => '프리미엄';

  @override
  String get premiumActive => '프리미엄 액티브';

  @override
  String get premiumBenefitInstantRecord =>
      '프리미엄 사용자는 즉시 녹음 및 음성 동기화 기능을 사용할 수 있습니다!';

  @override
  String get premiumDescription => '모든 프리미엄 기능을 잠금 해제하고 광고 없는 경험을 즐기세요';

  @override
  String get premiumUnlocked => '프리미엄 잠금 해제!';

  @override
  String get privacyPolicy => '개인정보 보호정책';

  @override
  String get pro => 'PRO';

  @override
  String get processing => '처리 중...';

  @override
  String purchaseErrorDetail(String p0) {
    return '구매 실패: $p0';
  }

  @override
  String get purchaseFailedInitiate => '구매를 시작할 수 없습니다. 다시 시도해 보세요.';

  @override
  String get qualityHigh => '높은';

  @override
  String get qualityLabel => '품질';

  @override
  String get qualityLow => '낮은';

  @override
  String get qualityStandard => '기준';

  @override
  String get range => '범위';

  @override
  String get rateUs => '평가하기';

  @override
  String get ratio => '비율';

  @override
  String get recent => '최근의';

  @override
  String get recordingFailed => '녹화 실패';

  @override
  String recordingsDeletedToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '녹화 $count개 삭제됨',
      one: '녹화 1개 삭제됨',
    );
    return '$_temp0';
  }

  @override
  String recordingsRemainingHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '녹화 횟수 $count회 남음',
      one: '녹화 횟수 1회 남음',
    );
    return '$_temp0 · 광고를 시청해 더 받기';
  }

  @override
  String get recordNow => '지금 녹음하세요';

  @override
  String get remoteControl => '블루투스 리모컨 및 키보드';

  @override
  String get remoteControlLocked => 'Bluetooth 리모컨 및 키보드는 프리미엄 기능입니다';

  @override
  String get removeAds => '광고 제거';

  @override
  String get rename => '이름 바꾸기';

  @override
  String get resolution => '해상도';

  @override
  String get restore => '복원하다';

  @override
  String get restoredSuccessfully => '구매가 성공적으로 복원되었습니다.';

  @override
  String restoreFailed(String error) {
    return '복원 실패: $error';
  }

  @override
  String get restorePurchaseLink => '구매 복원';

  @override
  String get retry => '다시 해 보다';

  @override
  String get rewardGranted => '보상 부여: 녹음 +3개';

  @override
  String get rotate => '회전';

  @override
  String get save => '저장';

  @override
  String get saveButton => '구하다';

  @override
  String get saved => '저장됨';

  @override
  String savedAs(String p0) {
    return '$p0(으)로 저장됨';
  }

  @override
  String get saveEditorLabel => '구하다';

  @override
  String get saveFailed => '저장 실패';

  @override
  String get saveFailedEmpty => '저장할 항목이 없습니다.';

  @override
  String get saveFailedGallery => '갤러리에 저장할 수 없습니다.';

  @override
  String get saveFailedNotFound => '저장 위치를 ​​찾을 수 없습니다';

  @override
  String get saveVideo => '비디오 저장';

  @override
  String get savingEllipsis => '절약…';

  @override
  String get scriptContentPlaceholder => '여기에 스크립트 작성을 시작하세요...';

  @override
  String get scriptDeleted => '스크립트 삭제됨';

  @override
  String scriptSummary(String p0, String p1) {
    return '$p0 · $p1';
  }

  @override
  String get scriptTitleHint => '예: YouTube 인트로';

  @override
  String get scriptTitlePlaceholder => '스크립트 제목...';

  @override
  String get scrollSpeed => '스크롤 속도';

  @override
  String get searchScripts => '스크립트 검색...';

  @override
  String get selectedScriptReady => '선택한 스크립트 준비됨';

  @override
  String get selectLanguage => '언어 선택';

  @override
  String get selectLanguageDesc => '앱의 선호 언어를 선택하세요';

  @override
  String get selectPlatformDesc => '스크립트 플랫폼 선택';

  @override
  String get settings => '설정';

  @override
  String get shareApp => '앱 공유';

  @override
  String shareAppMessage(String url) {
    return 'ScriptCam으로 자신감 있게 전문 비디오를 녹화하세요! 🎥✨\n\n내장 텔레프롬프터, 4K 녹화 및 비디오 편집기가 있습니다. 여기에서 사용해 보세요:\n$url';
  }

  @override
  String get shareAppSubject => 'ScriptCam 확인: 비디오 텔레프롬프터';

  @override
  String get shareVideoSubject => '내 영상을 확인해 보세요';

  @override
  String get shareVideoText => 'ScriptCam으로 녹화된 비디오';

  @override
  String get signInCancelled => '로그인이 취소되었습니다.';

  @override
  String get softStart => '소프트 스타트';

  @override
  String get speed => '속도';

  @override
  String get speedFast => '빠른';

  @override
  String get speedNormal => '정상';

  @override
  String get speedSlow => '느린';

  @override
  String get speedTurbo => '터보';

  @override
  String get startFreeTrial => '무료 평가판 시작';

  @override
  String get startRecording => '녹화 시작';

  @override
  String get startYourJourney => '여정 시작';

  @override
  String get step1Desc => '새 스크립트를 만들거나 텍스트 없이 빠른 녹화를 시작하세요';

  @override
  String get step1Title => '스크립트 만들기';

  @override
  String get step2Desc => '속도, 글꼴 크기를 조정하고 음성 동기화를 활성화하여 핸즈프리 스크롤링을 사용하세요';

  @override
  String get step2Title => '텔레프롬프터 설정';

  @override
  String get step3Desc => '녹화를 누르고 카메라를 보면서 스크립트를 읽으세요';

  @override
  String get step3Title => '비디오 녹화';

  @override
  String get step4Desc => '비디오 편집기를 사용하여 공유하기 전에 자르기, 조정 및 필터를 적용하세요';

  @override
  String get step4Title => '편집 및 공유';

  @override
  String get step5Desc =>
      'Bluetooth 리모컨이나 키보드를 사용하여 재생, 일시 중지 및 스크롤 속도를 조정하세요.';

  @override
  String get step5Title => '원격 제어';

  @override
  String get storePricingUnavailable => '지금은 매장 가격을 확인할 수 없습니다.';

  @override
  String get storeUnavailable => '매장을 이용할 수 없습니다. 나중에 다시 시도하세요.';

  @override
  String get stripView => '스트립 뷰';

  @override
  String get studioEditor => '스튜디오 편집자';

  @override
  String get support => '지원';

  @override
  String get supportBody => '안녕하세요 ScriptCam 팀,';

  @override
  String get supportSubject => '스크립트캠 지원';

  @override
  String get switchAccount => '계정 전환';

  @override
  String get system => '시스템';

  @override
  String get systemDefault => '시스템 기본값';

  @override
  String get tabCamera => '카메라';

  @override
  String get tabRecordings => '녹화';

  @override
  String get tabScripts => '스크립트';

  @override
  String get targetFps => '목표 FPS';

  @override
  String get text => '텍스트';

  @override
  String get textPasted => '텍스트 붙여넣기됨';

  @override
  String get titleRequired => '제목 필요';

  @override
  String get transform => '변환';

  @override
  String get trim => '자르기';

  @override
  String get unexpectedError => '문제가 발생했습니다.';

  @override
  String get unexpectedErrorDesc => '문제가 발생했습니다. 다시 시도해 주세요.';

  @override
  String get unlimitedRecordings => '무제한 녹음';

  @override
  String get unlimitedScripts => '무제한 스크립트';

  @override
  String get unlockAllFeatures => '모든 기능 잠금 해제 및 광고 제거';

  @override
  String get unlockCreatorPro => '크리에이터 프로 잠금 해제';

  @override
  String get untitledScript => '제목 없는 스크립트';

  @override
  String get upgradeForLifetime => '평생 액세스로 업그레이드';

  @override
  String get upgradeToPro => '프로로 업그레이드';

  @override
  String get useASavedScript => '저장된 스크립트 사용';

  @override
  String get version => '버전';

  @override
  String get videoDeleted => '비디오가 삭제되었습니다';

  @override
  String get videoFileNotFound => '비디오 파일을 찾을 수 없습니다';

  @override
  String get videoName => '파일 이름';

  @override
  String get videoNameHint => '내 비디오';

  @override
  String get videoSettings => '비디오 설정';

  @override
  String get voiceSync => '음성 동기화';

  @override
  String get voiceSyncFeature => '음성 동기화';

  @override
  String get voiceSyncLocked => '음성 동기화는 프리미엄 기능입니다';

  @override
  String get watchAdGetRecordings => '광고 1개 시청 → 녹음 +3개 받기';

  @override
  String get watchAdToRecord => '녹화하려면 광고를 시청하세요';

  @override
  String get watchAdToRecordDesc => '이 스크립트에 대한 녹음을 잠금 해제하려면 짧은 광고를 시청하세요.';

  @override
  String get weeklyPlan => '주간';

  @override
  String get weeklyPriceNotLoaded => '주간 가격은 아직 매장에서 로드되지 않았습니다.';

  @override
  String get weeklyTrialStorePrice => '3일 무료 평가판, 주간 가격은 매장에서 확인 가능';

  @override
  String weeklyTrialThenPrice(String price) {
    return '3일 무료 평가판 이후 $price/주';
  }

  @override
  String get whatAreYouRecording => '당신은 무엇입니까\n오늘 녹화?';

  @override
  String get width => '너비';

  @override
  String get widthFull => '가득한';

  @override
  String get widthMedium => '중간';

  @override
  String get widthNarrow => '좁은';

  @override
  String get wifiOnly => 'Wi-Fi 전용';

  @override
  String wordCountShort(int count) {
    return '$count 단어';
  }

  @override
  String get words => '단어';

  @override
  String get youAreNowPremium => '이제 프리미엄이 되셨습니다!';
}
