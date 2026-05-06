// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get about => '关于';

  @override
  String get addOrSelectScriptPrompt => '添加或选择一个脚本以开始使用提词器覆盖进行录制。';

  @override
  String get adjust => '调整';

  @override
  String get adNotAvailable => '广告不可用';

  @override
  String get adNotAvailableDesc => '我们无法加载广告。稍后再试一次。';

  @override
  String get adNotCompleted => '广告未完成';

  @override
  String get adNotCompletedDesc => '观看完整广告即可获得录制积分。';

  @override
  String get all => '全部';

  @override
  String get allScriptsTitle => '所有脚本';

  @override
  String get appearance => '外观';

  @override
  String get appInfoDescription => '内容创作者的终极提词器和视频录制工具。无缝创建、阅读和录制。';

  @override
  String get appInfoTitle => 'ScriptCam';

  @override
  String get appTitle => 'ScriptCam';

  @override
  String get autoBackup => '自动备份';

  @override
  String get autoSync => '自动同步';

  @override
  String get backCamera => '后退';

  @override
  String get background => '背景';

  @override
  String backupFailedDetail(String error) {
    return '备份错误：$error';
  }

  @override
  String get backupNow => '立即备份';

  @override
  String get backupVideos => '备份视频';

  @override
  String bulkDeleteRecordingsTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '删除 $count 条录像？',
      one: '删除这条录像？',
    );
    return '$_temp0';
  }

  @override
  String get cameraPreviewWithOverlay => '带有实时提词器叠加的相机预览。';

  @override
  String get cancel => '取消';

  @override
  String get close => '关闭';

  @override
  String get cloudBackup => '云备份';

  @override
  String get connected => '已连接';

  @override
  String get connectGoogleDrive => '连接 Google 云端硬盘';

  @override
  String get connectionError => '连接错误。检查您的互联网并重试。';

  @override
  String get contactUs => '联系我们';

  @override
  String get continueButton => '继续';

  @override
  String get couldNotLoadVideo => '无法加载视频';

  @override
  String get countdownTimer => '倒计时器';

  @override
  String get created => '已创建！';

  @override
  String get createNewScript => '创建新脚本';

  @override
  String creditsRemaining(int count) {
    return '积分 $count';
  }

  @override
  String get cueCards => '提示卡';

  @override
  String currentCreditsDescription(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '该脚本还剩 $count 次免费录像。',
      one: '该脚本还剩 1 次免费录像。',
    );
    return '$_temp0';
  }

  @override
  String get dark => '深色';

  @override
  String get darkMode => '深色模式';

  @override
  String get defaultCamera => '默认相机';

  @override
  String get delete => '删除';

  @override
  String get deleteScriptMessage => '此操作无法撤销。';

  @override
  String get deleteScriptTitle => '删除脚本？';

  @override
  String get deleteVideoTitle => '删除视频？';

  @override
  String get discard => '丢弃';

  @override
  String get discardChanges => '放弃更改？';

  @override
  String get discardChangesDesc => '您的编辑将会丢失。';

  @override
  String get disconnect => '断开';

  @override
  String get discountBadge => '20% 折扣';

  @override
  String get duplicate => '复制';

  @override
  String durationMinutesSecondsShort(int minutes, int seconds) {
    return '$minutes：$seconds';
  }

  @override
  String durationSecondsShort(int seconds) {
    return '$seconds秒';
  }

  @override
  String get earnRecordingCredits => '赚取录音积分';

  @override
  String get edit => '编辑';

  @override
  String get editScript => '编辑脚本';

  @override
  String get editScriptBlockedDuringCountdown => '等待倒计时结束后再进行编辑。';

  @override
  String get editScriptBlockedWhileRecording => '停止录制以编辑脚本。';

  @override
  String get emptyCreativeSpaceMessage => '您的创意空间是空的。创建您的第一个脚本或尝试即兴录制内容！';

  @override
  String get emptyGallery => '暂无视频';

  @override
  String get emptyGalleryDesc => '录制您的第一个视频以在此处查看';

  @override
  String errorSharingVideo(String error) {
    return '无法分享视频：$error';
  }

  @override
  String exportedScriptSubject(String title) {
    return '导出的脚本：$title';
  }

  @override
  String get exportQuality => '出口品质';

  @override
  String get exportSuccess => '脚本导出成功';

  @override
  String get focusLine => '焦点线';

  @override
  String get font => '字体';

  @override
  String get fontSize => '字体大小';

  @override
  String freeRecordingsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '还剩 $count 次免费录像',
      one: '还剩 1 次免费录像',
    );
    return '$_temp0';
  }

  @override
  String get freeTrialCancelAnytime => '免费试用立即开始。续订前随时取消。';

  @override
  String get frontCamera => '正面';

  @override
  String get fullDuration => '满的';

  @override
  String get general => '常规';

  @override
  String get getPremium => '获取高级版';

  @override
  String get googleUser => '谷歌用户';

  @override
  String get goPremium => '升级至高级版';

  @override
  String get gotIt => '知道了';

  @override
  String get grantAccess => '授予访问权限';

  @override
  String get help => '帮助';

  @override
  String get highQualityVideo => '高品质视频';

  @override
  String get howToUse => '如何使用';

  @override
  String get howToUseTitle => '如何使用 ScriptCam';

  @override
  String get importScript => '进口';

  @override
  String get importSuccess => '脚本导入成功';

  @override
  String itemsSelected(int count) {
    return '已选 $count 项';
  }

  @override
  String get keepEditing => '继续编辑';

  @override
  String get language => '语言';

  @override
  String get lifetimeNoRecurringBilling => '终身解锁。没有定期计费。';

  @override
  String get lifetimeOneTimeUnlock => '一次性购买。一次付费，永久解锁。';

  @override
  String get lifetimePlan => '终身计划';

  @override
  String get lifetimePriceNotLoaded => '终身价格尚未从商店加载。';

  @override
  String get light => '浅色';

  @override
  String get lightMode => '浅色模式';

  @override
  String get lineSpacing => '行距';

  @override
  String get loop => '环形';

  @override
  String get managePremiumStatus => '管理您的高级状态';

  @override
  String get minRead => '分钟阅读';

  @override
  String get mirror => '镜像';

  @override
  String get mute => '静音';

  @override
  String get never => '绝不';

  @override
  String get newScript => '新脚本';

  @override
  String get newScriptMultiline => '新\n脚本';

  @override
  String get next => '下一步';

  @override
  String get noAds => '永远没有广告';

  @override
  String get noInternetDesc => '看来您已离线。请检查您的连接并重试。';

  @override
  String get noInternetError => '没有互联网';

  @override
  String get noInternetErrorDesc => '连接到互联网并重试。';

  @override
  String get noInternetTitle => '无互联网连接';

  @override
  String get noRecordingsLeft => '没有剩余录音 · 观看广告以继续';

  @override
  String get noResultsFound => '未找到结果';

  @override
  String get noResultsMessage => '我们找不到任何与您的搜索匹配的脚本。尝试不同的关键字！';

  @override
  String get noSavedScriptSelected => '未选择保存的脚本';

  @override
  String get notAuthenticated => '未登录 Google。';

  @override
  String get off => '离开';

  @override
  String get onboardingAccessCamera => '相机';

  @override
  String get onboardingAccessMic => '麦克风';

  @override
  String get onboardingInteractiveRecLabel => '记录';

  @override
  String get onboardingInteractiveStep1Eyebrow => '主视图';

  @override
  String get onboardingInteractiveStep1Preview =>
      '叠加脚本和框架保持在一起可见。滚动到排练；当节奏感觉合适时开始录音。';

  @override
  String get onboardingInteractiveStep1Subtitle =>
      'ScriptCam 以捕捉为中心。脚本、制作人员名单和设置保持可访问性，而不会使您拍摄的内容变得拥挤。';

  @override
  String get onboardingInteractiveStep1Title => '录制优先工作区';

  @override
  String get onboardingInteractiveStep2Sample =>
      '早上好——感谢您来到这里。\n我们将保持简短和实用。\n如果你偏离了镜头，请故意向后靠并继续。';

  @override
  String get onboardingInteractiveStep2Subtitle =>
      '一键暂停排练。排练或拍摄时，从录制屏幕调整滚动节奏和文本大小。';

  @override
  String get onboardingInteractiveStep2Title => '提词器覆盖';

  @override
  String get onboardingInteractiveStep4CardHint =>
      '您可以随时在 Android 或 iOS 设置中更改这些设置。';

  @override
  String get onboardingInteractiveStep4Subtitle =>
      'ScriptCam 需要摄像头和麦克风，以便您可以看到自己，同时脚本与您的节奏保持同步。';

  @override
  String get onboardingInteractiveStep4Title => '录音访问';

  @override
  String get opacity => '不透明度';

  @override
  String get original => '原件';

  @override
  String get overlaySettings => '叠加设置';

  @override
  String get paste => '粘贴';

  @override
  String get permissionsRequired => '需要摄像头和麦克风权限。';

  @override
  String get preferences => '首选项';

  @override
  String get premium => '高级版';

  @override
  String get premiumActive => '高级活跃';

  @override
  String get premiumBenefitInstantRecord => '高级用户可以获得即时录音和语音同步！';

  @override
  String get premiumDescription => '解锁所有高级功能并享受无广告体验';

  @override
  String get premiumUnlocked => '高级版已解锁！';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get pro => 'PRO';

  @override
  String get processing => '处理中...';

  @override
  String purchaseErrorDetail(String p0) {
    return '购买失败：$p0';
  }

  @override
  String get purchaseFailedInitiate => '无法开始购买。再试一次。';

  @override
  String get qualityHigh => '高的';

  @override
  String get qualityLabel => '质量';

  @override
  String get qualityLow => '低的';

  @override
  String get qualityStandard => '标准';

  @override
  String get range => '范围';

  @override
  String get rateUs => '给我们评分';

  @override
  String get ratio => '比例';

  @override
  String get recent => '最近的';

  @override
  String get recordingFailed => '录制失败';

  @override
  String recordingsDeletedToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已删除 $count 条录像',
      one: '已删除 1 条录像',
    );
    return '$_temp0';
  }

  @override
  String recordingsRemainingHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '还剩 $count 次录像',
      one: '还剩 1 次录像',
    );
    return '$_temp0 · 观看广告获取更多';
  }

  @override
  String get recordNow => '立即录制';

  @override
  String get remoteControl => '蓝牙遥控器和键盘';

  @override
  String get remoteControlLocked => '蓝牙遥控器和键盘是一项高级功能';

  @override
  String get removeAds => '移除广告';

  @override
  String get rename => '重命名';

  @override
  String get resolution => '分辨率';

  @override
  String get restore => '恢复';

  @override
  String get restoredSuccessfully => '购买成功恢复。';

  @override
  String restoreFailed(String error) {
    return '恢复失败：$error';
  }

  @override
  String get restorePurchaseLink => '恢复购买';

  @override
  String get retry => '重试';

  @override
  String get rewardGranted => '奖励：+3 条录音';

  @override
  String get rotate => '旋转';

  @override
  String get save => '保存';

  @override
  String get saveButton => '节省';

  @override
  String get saved => '已保存';

  @override
  String savedAs(String p0) {
    return '另存为$p0';
  }

  @override
  String get saveEditorLabel => '节省';

  @override
  String get saveFailed => '保存失败';

  @override
  String get saveFailedEmpty => 'Nothing to save';

  @override
  String get saveFailedGallery => '无法保存到图库';

  @override
  String get saveFailedNotFound => '找不到保存位置';

  @override
  String get saveVideo => '保存视频';

  @override
  String get savingEllipsis => '保存…';

  @override
  String get scriptContentPlaceholder => '在此处开始编写您的脚本...';

  @override
  String get scriptDeleted => '脚本已删除';

  @override
  String scriptSummary(String p0, String p1) {
    return '$p0 · $p1';
  }

  @override
  String get scriptTitleHint => '例如 YouTube 开场白';

  @override
  String get scriptTitlePlaceholder => '脚本标题...';

  @override
  String get scrollSpeed => '滚动速度';

  @override
  String get searchScripts => '搜索脚本...';

  @override
  String get selectedScriptReady => '选定的脚本准备就绪';

  @override
  String get selectLanguage => '选择语言';

  @override
  String get selectLanguageDesc => '选择您偏好的应用语言';

  @override
  String get selectPlatformDesc => '为您的脚本选择一个平台';

  @override
  String get settings => '设置';

  @override
  String get shareApp => '分享应用';

  @override
  String shareAppMessage(String url) {
    return '使用 ScriptCam 自信地录制专业视频！🎥✨\n\n它具有内置提词器、4K 录制和视频编辑器。在此处试用：\n$url';
  }

  @override
  String get shareAppSubject => '查看 ScriptCam：视频提词器';

  @override
  String get shareVideoSubject => '看看我的视频';

  @override
  String get shareVideoText => '使用 ScriptCam 录制的视频';

  @override
  String get signInCancelled => '登录已取消。';

  @override
  String get softStart => '软启动';

  @override
  String get speed => '速度';

  @override
  String get speedFast => '快速地';

  @override
  String get speedNormal => '普通的';

  @override
  String get speedSlow => '慢的';

  @override
  String get speedTurbo => '涡轮';

  @override
  String get startFreeTrial => '开始免费试用';

  @override
  String get startRecording => '开始录制';

  @override
  String get startYourJourney => '开始您的旅程';

  @override
  String get step1Desc => '首先创建一个新脚本或没有文本的快速录制';

  @override
  String get step1Title => '创建脚本';

  @override
  String get step2Desc => '调整速度、字体大小并启用语音同步以实现免提滚动';

  @override
  String get step2Title => '设置提词器';

  @override
  String get step3Desc => '按下录制并看着摄像头阅读您的脚本';

  @override
  String get step3Title => '录制您的视频';

  @override
  String get step4Desc => '在分享之前使用视频编辑器修剪、调整和应用滤镜';

  @override
  String get step4Title => '编辑和分享';

  @override
  String get step5Desc => '使用蓝牙遥控器或键盘播放、暂停和调整滚动速度。';

  @override
  String get step5Title => '遥控';

  @override
  String get storePricingUnavailable => '目前无法提供商店定价。';

  @override
  String get storeUnavailable => '商店不可用。稍后再试。';

  @override
  String get stripView => '带状视图';

  @override
  String get studioEditor => '工作室编辑';

  @override
  String get support => '支持';

  @override
  String get supportBody => 'ScriptCam 团队您好，';

  @override
  String get supportSubject => 'ScriptCam 支持';

  @override
  String get switchAccount => '切换账户';

  @override
  String get system => '系统';

  @override
  String get systemDefault => '系统默认';

  @override
  String get tabCamera => '相机';

  @override
  String get tabRecordings => '录像';

  @override
  String get tabScripts => '脚本';

  @override
  String get targetFps => '目标 FPS';

  @override
  String get text => '文本';

  @override
  String get textPasted => '文本已粘贴';

  @override
  String get titleRequired => '需要标题';

  @override
  String get transform => '变换';

  @override
  String get trim => '修剪';

  @override
  String get unexpectedError => '出了点问题';

  @override
  String get unexpectedErrorDesc => '出了点问题。请再试一次。';

  @override
  String get unlimitedRecordings => '无限录音';

  @override
  String get unlimitedScripts => '无限脚本';

  @override
  String get unlockAllFeatures => '解锁所有功能并移除广告';

  @override
  String get unlockCreatorPro => '解锁创作者高级版';

  @override
  String get untitledScript => '无标题脚本';

  @override
  String get upgradeForLifetime => '升级以获得终身访问权限';

  @override
  String get upgradeToPro => '升级到 Pro';

  @override
  String get useASavedScript => '使用保存的脚本';

  @override
  String get version => '版本';

  @override
  String get videoDeleted => '视频已删除';

  @override
  String get videoFileNotFound => '找不到视频文件';

  @override
  String get videoName => '文件名';

  @override
  String get videoNameHint => '我的视频';

  @override
  String get videoSettings => '视频设置';

  @override
  String get voiceSync => '语音同步';

  @override
  String get voiceSyncFeature => '语音同步';

  @override
  String get voiceSyncLocked => '语音同步是一项高级功能';

  @override
  String get watchAdGetRecordings => '观看 1 个广告 → 获得 +3 条录音';

  @override
  String get watchAdToRecord => '观看广告以录制';

  @override
  String get watchAdToRecordDesc => '观看一段简短的广告即可解锁该脚本的录制功能。';

  @override
  String get weeklyPlan => '每周';

  @override
  String get weeklyPriceNotLoaded => '每周价格尚未从商店加载。';

  @override
  String get weeklyTrialStorePrice => '3 天免费试用，每周商店价格';

  @override
  String weeklyTrialThenPrice(String price) {
    return '3 天免费试用，然后每周 $price';
  }

  @override
  String get whatAreYouRecording => '你是什么\n今天录音吗？';

  @override
  String get width => '宽度';

  @override
  String get widthFull => '满的';

  @override
  String get widthMedium => '中等的';

  @override
  String get widthNarrow => '狭窄的';

  @override
  String get wifiOnly => '仅 Wi-Fi';

  @override
  String wordCountShort(int count) {
    return '$count 个字';
  }

  @override
  String get words => '字';

  @override
  String get youAreNowPremium => '您现在是高级会员了！';

  @override
  String get stopRecordingTitle => '停止录制？';

  @override
  String get stopRecordingMessage => '您的录制已暂停。确定要退出吗？当前录制将被丢弃。';
}
