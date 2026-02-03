// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'ScriptCam';

  @override
  String get onboardingWelcomeTitle => '欢迎使用 ScriptCam';

  @override
  String get onboardingWelcomeDesc => '您的多合一提词器工作室。撰写脚本、录制视频并无缝编辑。';

  @override
  String get onboardingScriptEditorTitle => '脚本编辑器';

  @override
  String get onboardingScriptEditorDesc => '轻松编写和管理您的视频脚本。立即整理您的想法。';

  @override
  String get onboardingTeleprompterTitle => '提词器';

  @override
  String get onboardingTeleprompterDesc => '直视摄像头阅读脚本。专业录制变得简单。';

  @override
  String get onboardingPermissionsTitle => '启用权限';

  @override
  String get onboardingPermissionsDesc => '为了录制视频并将您的声音与脚本同步，我们需要访问您的摄像头和麦克风。';

  @override
  String get grantAccess => '授予访问权限';

  @override
  String get start => '开始';

  @override
  String get next => '下一步';

  @override
  String get permissionsRequired => '需要摄像头和麦克风权限。';

  @override
  String get selectLanguage => '选择语言';

  @override
  String get selectLanguageDesc => '选择您偏好的应用语言';

  @override
  String get continueButton => '继续';

  @override
  String get settings => '设置';

  @override
  String get preferences => '首选项';

  @override
  String get help => '帮助';

  @override
  String get support => '支持';

  @override
  String get about => '关于';

  @override
  String get appearance => '外观';

  @override
  String get language => '语言';

  @override
  String get systemDefault => '系统默认';

  @override
  String get lightMode => '浅色模式';

  @override
  String get darkMode => '深色模式';

  @override
  String get system => '系统';

  @override
  String get light => '浅色';

  @override
  String get dark => '深色';

  @override
  String get howToUse => '如何使用';

  @override
  String get shareApp => '分享应用';

  @override
  String get contactUs => '联系我们';

  @override
  String get rateUs => '给我们评分';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get version => '版本';

  @override
  String get upgradeToPro => '升级到 Pro';

  @override
  String get unlockAllFeatures => '解锁所有功能并移除广告';

  @override
  String shareAppMessage(String url) {
    return '使用 ScriptCam 自信地录制专业视频！🎥✨\n\n它具有内置提词器、4K 录制和视频编辑器。在此处试用：\n$url';
  }

  @override
  String get shareAppSubject => '查看 ScriptCam：视频提词器';

  @override
  String get goodMorning => '早上好';

  @override
  String get goodAfternoon => '下午好';

  @override
  String get goodEvening => '晚上好';

  @override
  String get readyToCreate => '准备好创造\n令人惊叹的内容了吗？';

  @override
  String get newScript => '新脚本';

  @override
  String get writeFromScratch => '从头开始编写';

  @override
  String get quickRecord => '快速录制';

  @override
  String get recordOnTheFly => '即兴录制';

  @override
  String get myScripts => '我的脚本';

  @override
  String get recentFirst => '最近优先';

  @override
  String get quickRecordDialogTitle => '快速录制';

  @override
  String get quickRecordDialogDesc => '在下方输入脚本详细信息，或跳过以在没有文本的情况下打开摄像头。';

  @override
  String get scriptTitle => '脚本标题';

  @override
  String get scriptContent => '脚本内容';

  @override
  String get scriptTitleHint => '例如 YouTube 开场白';

  @override
  String get scriptContentHint => '在此处粘贴您的脚本内容...';

  @override
  String get startRecording => '开始录制';

  @override
  String get editScript => '编辑脚本';

  @override
  String get save => '保存';

  @override
  String get scriptTitlePlaceholder => '脚本标题...';

  @override
  String get scriptContentPlaceholder => '在此处开始编写您的脚本...';

  @override
  String get platform => '平台';

  @override
  String get titleRequired => '需要标题';

  @override
  String get saved => '已保存';

  @override
  String get created => '已创建！';

  @override
  String get textPasted => '文本已粘贴';

  @override
  String get scriptDeleted => '脚本已删除';

  @override
  String get deleteScriptTitle => '删除脚本？';

  @override
  String get deleteScriptMessage => '此操作无法撤销。';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get appInfoTitle => 'ScriptCam';

  @override
  String get appInfoVersion => '版本 1.0.3';

  @override
  String get appInfoDescription => '内容创作者的终极提词器和视频录制工具。无缝创建、阅读和录制。';

  @override
  String get close => '关闭';

  @override
  String get emptyScriptsAll => '暂无脚本';

  @override
  String get emptyScriptsAllDesc => '创建您的第一个脚本以开始';

  @override
  String emptyScriptsCategory(String category) {
    return '没有 $category 脚本';
  }

  @override
  String get emptyScriptsCategoryDesc => '为此平台创建一个脚本';

  @override
  String get gallery => '画廊';

  @override
  String get emptyGallery => '暂无视频';

  @override
  String get emptyGalleryDesc => '录制您的第一个视频以在此处查看';

  @override
  String get teleprompter => '提词器';

  @override
  String get record => '录制';

  @override
  String get stop => '停止';

  @override
  String get pause => '暂停';

  @override
  String get resume => '恢复';

  @override
  String get speed => '速度';

  @override
  String get fontSize => '字体大小';

  @override
  String get mirror => '镜像';

  @override
  String get voiceSync => '语音同步';

  @override
  String get autoScroll => '自动滚动';

  @override
  String get videoSettings => '视频设置';

  @override
  String get resolution => '分辨率';

  @override
  String get quality => '质量';

  @override
  String get premium => '高级版';

  @override
  String get getPremium => '获取高级版';

  @override
  String get restorePurchases => '恢复购买';

  @override
  String get videoEditor => '视频编辑器';

  @override
  String get trim => '修剪';

  @override
  String get adjust => '调整';

  @override
  String get filters => '滤镜';

  @override
  String get export => '导出';

  @override
  String get exporting => '正在导出...';

  @override
  String get exportComplete => '导出完成！';

  @override
  String get brightness => '亮度';

  @override
  String get contrast => '对比度';

  @override
  String get saturation => '饱和度';

  @override
  String get share => '分享';

  @override
  String get play => '播放';

  @override
  String get all => '全部';

  @override
  String get general => '常规';

  @override
  String get search => '搜索';

  @override
  String get searchScripts => '搜索脚本...';

  @override
  String get studio => '工作室';

  @override
  String get startYourJourney => '开始您的旅程';

  @override
  String get noResultsFound => '未找到结果';

  @override
  String get noResultsMessage => '我们找不到任何与您的搜索匹配的脚本。尝试不同的关键字！';

  @override
  String get emptyCreativeSpaceMessage => '您的创意空间是空的。创建您的第一个脚本或尝试即兴录制内容！';

  @override
  String get paste => '粘贴';

  @override
  String get createNewScript => '创建新脚本';

  @override
  String get selectPlatformDesc => '为您的脚本选择一个平台';

  @override
  String get pro => 'PRO';

  @override
  String get minRead => '分钟阅读';

  @override
  String get words => '字';

  @override
  String get edit => '编辑';

  @override
  String get howToUseTitle => '如何使用 ScriptCam';

  @override
  String get step1Title => '创建脚本';

  @override
  String get step1Desc => '首先创建一个新脚本或没有文本的快速录制';

  @override
  String get step2Title => '设置提词器';

  @override
  String get step2Desc => '调整速度、字体大小并启用语音同步以实现免提滚动';

  @override
  String get step3Title => '录制您的视频';

  @override
  String get step3Desc => '按下录制并看着摄像头阅读您的脚本';

  @override
  String get step4Title => '编辑和分享';

  @override
  String get step4Desc => '在分享之前使用视频编辑器修剪、调整和应用滤镜';

  @override
  String get gotIt => '知道了';

  @override
  String get deleteVideoTitle => '删除视频？';

  @override
  String get videoDeleted => '视频已删除';

  @override
  String get mute => '静音';

  @override
  String get opacity => '不透明度';

  @override
  String get original => '原件';

  @override
  String get processing => '处理中...';

  @override
  String get range => '范围';

  @override
  String get ratio => '比例';

  @override
  String get recordingFailed => '录制失败';

  @override
  String get rotate => '旋转';

  @override
  String get targetFps => '目标 FPS';

  @override
  String get transform => '变换';

  @override
  String get premiumDescription => '解锁所有高级功能并享受无广告体验';

  @override
  String get removeAds => '移除广告';

  @override
  String get unlimitedScripts => '无限脚本';

  @override
  String get unlockCreatorPro => '解锁创作者高级版';

  @override
  String get upgradeForLifetime => '升级以获得终身访问权限';

  @override
  String get restorePurchaseLink => '恢复购买';

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
