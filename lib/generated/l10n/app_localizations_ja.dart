// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get about => 'アプリについて';

  @override
  String get addOrSelectScriptPrompt =>
      'テレプロンプター オーバーレイを使用して録音を開始するスクリプトを追加または選択します。';

  @override
  String get adjust => '調整';

  @override
  String get adNotAvailable => '広告は利用できません';

  @override
  String get adNotAvailableDesc => '広告を読み込めませんでした。しばらくしてからもう一度試してください。';

  @override
  String get adNotCompleted => '広告が完成していません';

  @override
  String get adNotCompletedDesc => '広告全体を視聴して録画クレジットを獲得してください。';

  @override
  String get all => 'すべて';

  @override
  String get allScriptsTitle => 'すべてのスクリプト';

  @override
  String get appearance => '外観';

  @override
  String get appInfoDescription =>
      'コンテンツクリエイター向けの究極のテレプロンプターおよび動画録画ツール。作成、読み上げ、録画をシームレスに。';

  @override
  String get appInfoTitle => 'ScriptCam';

  @override
  String get appTitle => 'ScriptCam';

  @override
  String get autoBackup => '自動バックアップ';

  @override
  String get autoSync => '自動同期';

  @override
  String get backCamera => '戻る';

  @override
  String get background => '背景';

  @override
  String backupFailedDetail(String error) {
    return 'バックアップ エラー: $error';
  }

  @override
  String get backupNow => '今すぐバックアップ';

  @override
  String get backupVideos => 'バックアップビデオ';

  @override
  String bulkDeleteRecordingsTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 件の録画を削除しますか？',
      one: 'この録画を削除しますか？',
    );
    return '$_temp0';
  }

  @override
  String get cameraPreviewWithOverlay => 'ライブテレプロンプターオーバーレイを備えたカメラプレビュー。';

  @override
  String get cancel => 'キャンセル';

  @override
  String get close => '閉じる';

  @override
  String get cloudBackup => 'クラウドバックアップ';

  @override
  String get connected => '接続済み';

  @override
  String get connectGoogleDrive => 'Googleドライブに接続する';

  @override
  String get connectionError => '接続エラー。インターネットを確認して、もう一度試してください。';

  @override
  String get contactUs => 'お問い合わせ';

  @override
  String get continueButton => '続行';

  @override
  String get couldNotLoadVideo => 'ビデオを読み込めませんでした';

  @override
  String get countdownTimer => 'カウントダウンタイマー';

  @override
  String get created => '作成しました！';

  @override
  String get createNewScript => '新しいスクリプトを作成';

  @override
  String creditsRemaining(int count) {
    return 'クレジット $count';
  }

  @override
  String get cueCards => 'キューカード';

  @override
  String currentCreditsDescription(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'このスクリプトの無料録画はあと$count回分あります。',
      one: 'このスクリプトの無料録画はあと1回分あります。',
    );
    return '$_temp0';
  }

  @override
  String get dark => 'ダーク';

  @override
  String get darkMode => 'ダークモード';

  @override
  String get defaultCamera => 'デフォルトのカメラ';

  @override
  String get delete => '削除';

  @override
  String get deleteScriptMessage => 'この操作は取り消せません。';

  @override
  String get deleteScriptTitle => 'スクリプトを削除しますか？';

  @override
  String get deleteVideoTitle => '動画を削除しますか？';

  @override
  String get discard => '破棄';

  @override
  String get discardChanges => '変更を破棄しますか?';

  @override
  String get discardChangesDesc => '編集内容は失われます。';

  @override
  String get disconnect => '切断する';

  @override
  String get discountBadge => '20%オフ';

  @override
  String get duplicate => '重複';

  @override
  String durationMinutesSecondsShort(int minutes, int seconds) {
    return '$minutes:$seconds';
  }

  @override
  String durationSecondsShort(int seconds) {
    return '$seconds秒';
  }

  @override
  String get earnRecordingCredits => '録音クレジットを獲得する';

  @override
  String get edit => '編集';

  @override
  String get editScript => 'スクリプトを編集';

  @override
  String get editScriptBlockedDuringCountdown => '編集する前に、カウントダウンが終了するまで待ちます。';

  @override
  String get editScriptBlockedWhileRecording => 'スクリプトを編集するには記録を停止してください。';

  @override
  String get emptyCreativeSpaceMessage =>
      'クリエイティブスペースが空です。最初のスクリプトを作成するか、すぐに録画を試してみてください！';

  @override
  String get emptyGallery => '動画はまだありません';

  @override
  String get emptyGalleryDesc => '最初の動画を録画してここに表示しましょう';

  @override
  String errorSharingVideo(String error) {
    return 'ビデオを共有できませんでした: $error';
  }

  @override
  String exportedScriptSubject(String title) {
    return 'エクスポートされたスクリプト: $title';
  }

  @override
  String get exportQuality => '輸出品質';

  @override
  String get exportSuccess => 'スクリプトは正常にエクスポートされました';

  @override
  String get focusLine => '集中線';

  @override
  String get font => 'フォント';

  @override
  String get fontSize => 'フォントサイズ';

  @override
  String freeRecordingsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '無料録画の残り$count回',
      one: '無料録画の残り1回',
    );
    return '$_temp0';
  }

  @override
  String get freeTrialCancelAnytime => '無料トライアルはすぐに始まります。更新前でいつでもキャンセルできます。';

  @override
  String get frontCamera => 'フロント';

  @override
  String get fullDuration => '満杯';

  @override
  String get general => '一般';

  @override
  String get getPremium => 'プレミアムを入手';

  @override
  String get googleUser => 'Google ユーザー';

  @override
  String get goPremium => 'プレミアムに行く';

  @override
  String get gotIt => '了解';

  @override
  String get grantAccess => 'アクセスを許可';

  @override
  String get help => 'ヘルプ';

  @override
  String get highQualityVideo => '高品質ビデオ';

  @override
  String get howToUse => '使い方';

  @override
  String get howToUseTitle => 'ScriptCamの使い方';

  @override
  String get importScript => '輸入';

  @override
  String get importSuccess => 'スクリプトは正常にインポートされました';

  @override
  String itemsSelected(int count) {
    return '$count 件選択';
  }

  @override
  String get keepEditing => '編集を続ける';

  @override
  String get language => '言語';

  @override
  String get lifetimeNoRecurringBilling => '生涯アンロック。定期的な請求はありません。';

  @override
  String get lifetimeOneTimeUnlock => '1回限りの購入。一度支払うと永久にロックが解除されます。';

  @override
  String get lifetimePlan => 'ライフタイムプラン';

  @override
  String get lifetimePriceNotLoaded => '生涯価格はまだストアから読み込まれていません。';

  @override
  String get light => 'ライト';

  @override
  String get lightMode => 'ライトモード';

  @override
  String get lineSpacing => '行間';

  @override
  String get loop => 'ループ';

  @override
  String get managePremiumStatus => 'プレミアムステータスを管理する';

  @override
  String get minRead => '分で読める';

  @override
  String get mirror => 'ミラー';

  @override
  String get mute => 'ミュート';

  @override
  String get never => '一度もない';

  @override
  String get newScript => '新しいスクリプト';

  @override
  String get newScriptMultiline => '新しい\nスクリプト';

  @override
  String get next => '次へ';

  @override
  String get noAds => '広告は永久に表示されません';

  @override
  String get noInternetDesc => 'オフラインのようです。接続を確認して、もう一度試してください。';

  @override
  String get noInternetError => 'インターネットなし';

  @override
  String get noInternetErrorDesc => 'インターネットに接続して、もう一度試してください。';

  @override
  String get noInternetTitle => 'インターネット接続なし';

  @override
  String get noRecordingsLeft => '録画は残っていない · 続行するには広告を視聴してください';

  @override
  String get noResultsFound => '結果が見つかりません';

  @override
  String get noResultsMessage => '検索に一致するスクリプトが見つかりませんでした。別のキーワードを試してください！';

  @override
  String get noSavedScriptSelected => '保存されたスクリプトが選択されていません';

  @override
  String get notAuthenticated => 'Google にサインインしていません。';

  @override
  String get off => 'オフ';

  @override
  String get onboardingAccessCamera => 'カメラ';

  @override
  String get onboardingAccessMic => 'マイクロフォン';

  @override
  String get onboardingInteractiveRecLabel => '録音';

  @override
  String get onboardingInteractiveStep1Eyebrow => 'メインビュー';

  @override
  String get onboardingInteractiveStep1Preview =>
      'オーバーレイ スクリプトとフレームは一緒に表示されたままになります。スクロールしてリハーサルをしてください。ペースが適切だと感じたら録音を開始します。';

  @override
  String get onboardingInteractiveStep1Subtitle =>
      'ScriptCam はキャプチャに重点を置いています。撮影内容を邪魔することなく、スクリプト、クレジット、設定にアクセスできる状態を保ちます。';

  @override
  String get onboardingInteractiveStep1Title => '記録優先のワークスペース';

  @override
  String get onboardingInteractiveStep2Sample =>
      'おはようございます。ここに来ていただきありがとうございます。\nこれを簡潔かつ実用的なものにしていきます。\nレンズから外れてしまった場合は、意図的に戻って作業を続けてください。';

  @override
  String get onboardingInteractiveStep2Subtitle =>
      'ワンタップでリハーサルを一時停止します。リハーサルや撮影時に録画画面からスクロールのペースやテキストのサイズを調整します。';

  @override
  String get onboardingInteractiveStep2Title => 'テレプロンプターオーバーレイ';

  @override
  String get onboardingInteractiveStep4CardHint =>
      'これらは、Android または iOS の設定でいつでも変更できます。';

  @override
  String get onboardingInteractiveStep4Subtitle =>
      'ScriptCam にはカメラとマイクが必要です。これにより、スクリプトが自分のペースと同期している間、自分の姿を見ることができます。';

  @override
  String get onboardingInteractiveStep4Title => '録音アクセス';

  @override
  String get opacity => '不透明度';

  @override
  String get original => 'オリジナル';

  @override
  String get overlaySettings => 'オーバーレイ設定';

  @override
  String get paste => '貼り付け';

  @override
  String get permissionsRequired => 'カメラとマイクの権限が必要です。';

  @override
  String get preferences => '環境設定';

  @override
  String get premium => 'プレミアム';

  @override
  String get premiumActive => 'プレミアムアクティブ';

  @override
  String get premiumBenefitInstantRecord => 'プレミアム ユーザーは即時録音と音声同期を利用できます。';

  @override
  String get premiumDescription => 'すべてのプレミアム機能をロック解除して、広告なしの体験をお楽しみください';

  @override
  String get premiumUnlocked => 'プレミアムのロックが解除されました！';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get pro => 'PRO';

  @override
  String get processing => '処理中...';

  @override
  String purchaseErrorDetail(String p0) {
    return '購入に失敗しました: $p0';
  }

  @override
  String get purchaseFailedInitiate => '購入を開始できませんでした。もう一度やり直してください。';

  @override
  String get qualityHigh => '高い';

  @override
  String get qualityLabel => '品質';

  @override
  String get qualityLow => '低い';

  @override
  String get qualityStandard => '標準';

  @override
  String get range => '範囲';

  @override
  String get rateUs => '評価する';

  @override
  String get ratio => '比率';

  @override
  String get recent => '最近の';

  @override
  String get recordingFailed => '録画に失敗しました';

  @override
  String recordingsDeletedToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '録画を $count 件削除しました',
      one: '録画を 1 件削除しました',
    );
    return '$_temp0';
  }

  @override
  String recordingsRemainingHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '録画権利があと$count回',
      one: '録画権利があと1回',
    );
    return '$_temp0 · 広告を見て追加をゲット';
  }

  @override
  String get recordNow => '今すぐ録音する';

  @override
  String get remoteControl => 'Bluetooth リモコンとキーボード';

  @override
  String get remoteControlLocked => 'Bluetooth リモコンとキーボードはプレミアム機能です';

  @override
  String get removeAds => '広告を削除';

  @override
  String get rename => '名前の変更';

  @override
  String get resolution => '解像度';

  @override
  String get restore => '復元する';

  @override
  String get restoredSuccessfully => '購入は正常に復元されました。';

  @override
  String restoreFailed(String error) {
    return '復元に失敗しました: $error';
  }

  @override
  String get restorePurchaseLink => '購入を復元';

  @override
  String get retry => 'リトライ';

  @override
  String get rewardGranted => '付与された報酬: +3 録音';

  @override
  String get rotate => '回転';

  @override
  String get save => '保存';

  @override
  String get saveButton => '保存';

  @override
  String get saved => '保存しました';

  @override
  String savedAs(String p0) {
    return '$p0として保存されました';
  }

  @override
  String get saveEditorLabel => '保存';

  @override
  String get saveFailed => '保存に失敗しました';

  @override
  String get saveFailedEmpty => '保存するものは何もありません';

  @override
  String get saveFailedGallery => 'ギャラリーに保存できませんでした';

  @override
  String get saveFailedNotFound => '保存場所が見つかりません';

  @override
  String get saveVideo => 'ビデオを保存する';

  @override
  String get savingEllipsis => '保存中…';

  @override
  String get scriptContentPlaceholder => 'ここでスクリプトを書き始めてください...';

  @override
  String get scriptDeleted => 'スクリプトを削除しました';

  @override
  String scriptSummary(String p0, String p1) {
    return '$p0 · $p1';
  }

  @override
  String get scriptTitleHint => '例: YouTubeイントロ';

  @override
  String get scriptTitlePlaceholder => 'スクリプトのタイトル...';

  @override
  String get scrollSpeed => 'スクロール速度';

  @override
  String get searchScripts => 'スクリプトを検索...';

  @override
  String get selectedScriptReady => '選択したスクリプトの準備が完了しました';

  @override
  String get selectLanguage => '言語を選択';

  @override
  String get selectLanguageDesc => 'アプリの優先言語を選択してください';

  @override
  String get selectPlatformDesc => 'スクリプトのプラットフォームを選択';

  @override
  String get settings => '設定';

  @override
  String get shareApp => 'アプリを共有';

  @override
  String shareAppMessage(String url) {
    return 'ScriptCamで自信を持ってプロフェッショナルな動画を録画しましょう！ 🎥✨\n\nテレプロンプター内蔵、4K録画、動画エディタを搭載。試すにはこちら：\n$url';
  }

  @override
  String get shareAppSubject => 'ScriptCamをチェック: 動画テレプロンプター';

  @override
  String get shareVideoSubject => '私のビデオをチェックしてください';

  @override
  String get shareVideoText => 'ScriptCam で録画したビデオ';

  @override
  String get signInCancelled => 'サインインがキャンセルされました。';

  @override
  String get softStart => 'ソフトスタート';

  @override
  String get speed => '速度';

  @override
  String get speedFast => '速い';

  @override
  String get speedNormal => '普通';

  @override
  String get speedSlow => '遅い';

  @override
  String get speedTurbo => 'ターボ';

  @override
  String get startFreeTrial => '無料トライアルを開始する';

  @override
  String get startRecording => '録画を開始';

  @override
  String get startYourJourney => '旅を始めよう';

  @override
  String get step1Desc => '新しいスクリプトを作成するか、テキストなしのクイック録画で始めます';

  @override
  String get step1Title => 'スクリプトを作成';

  @override
  String get step2Desc => '速度、フォントサイズを調整し、音声同期を有効にしてハンズフリースクロール';

  @override
  String get step2Title => 'テレプロンプターを設定';

  @override
  String get step3Desc => '録画を押して、カメラを見ながらスクリプトを読みます';

  @override
  String get step3Title => '動画を録画';

  @override
  String get step4Desc => '動画エディタを使ってトリミング、調整、フィルターを適用してから共有します';

  @override
  String get step4Title => '編集して共有';

  @override
  String get step5Desc =>
      'Bluetooth リモコンまたはキーボードを使用して、再生、一時停止、スクロール速度の調整を行います。';

  @override
  String get step5Title => 'リモコン';

  @override
  String get storePricingUnavailable => 'ストア価格は現在利用できません。';

  @override
  String get storeUnavailable => 'ストアは利用できません。後でもう一度試してください。';

  @override
  String get stripView => 'ストリップビュー';

  @override
  String get studioEditor => 'スタジオ編集者';

  @override
  String get support => 'サポート';

  @override
  String get supportBody => 'こんにちは、ScriptCam チームです。';

  @override
  String get supportSubject => 'ScriptCam のサポート';

  @override
  String get switchAccount => 'アカウントを切り替える';

  @override
  String get system => 'システム';

  @override
  String get systemDefault => 'システムデフォルト';

  @override
  String get tabCamera => 'カメラ';

  @override
  String get tabRecordings => '録画';

  @override
  String get tabScripts => 'スクリプト';

  @override
  String get targetFps => 'ターゲットFPS';

  @override
  String get text => '文章';

  @override
  String get textPasted => 'テキストを貼り付けました';

  @override
  String get titleRequired => 'タイトルが必要です';

  @override
  String get transform => '変換';

  @override
  String get trim => 'トリミング';

  @override
  String get unexpectedError => '何か問題が発生しました';

  @override
  String get unexpectedErrorDesc => '何か問題が発生しました。もう一度試してください。';

  @override
  String get unlimitedRecordings => '無制限の録音';

  @override
  String get unlimitedScripts => '無制限のスクリプト';

  @override
  String get unlockAllFeatures => '全機能のロック解除と広告の削除';

  @override
  String get unlockCreatorPro => 'クリエイターProをロック解除';

  @override
  String get untitledScript => '無題のスクリプト';

  @override
  String get upgradeForLifetime => 'ライフタイムアクセスにアップグレード';

  @override
  String get upgradeToPro => 'Proにアップグレード';

  @override
  String get useASavedScript => '保存したスクリプトを使用する';

  @override
  String get version => 'バージョン';

  @override
  String get videoDeleted => '動画を削除しました';

  @override
  String get videoFileNotFound => 'ビデオファイルが見つかりません';

  @override
  String get videoName => 'ファイル名';

  @override
  String get videoNameHint => 'マイビデオ';

  @override
  String get videoSettings => '動画設定';

  @override
  String get voiceSync => '音声同期';

  @override
  String get voiceSyncFeature => '音声同期';

  @override
  String get voiceSyncLocked => '音声同期はプレミアム機能です';

  @override
  String get watchAdGetRecordings => '広告を 1 回視聴 → +3 録画を取得';

  @override
  String get watchAdToRecord => '広告を見て録画する';

  @override
  String get watchAdToRecordDesc => 'このスクリプトの録画のロックを解除するには、短い広告を視聴してください。';

  @override
  String get weeklyPlan => '毎週';

  @override
  String get weeklyPriceNotLoaded => '週間価格はまだストアから読み込まれていません。';

  @override
  String get weeklyTrialStorePrice => '3日間の無料トライアル、ストアからの毎週の価格';

  @override
  String weeklyTrialThenPrice(String price) {
    return '3 日間の無料トライアル、その後は週あたり $price';
  }

  @override
  String get whatAreYouRecording => 'あなたは何ですか\n今日はレコーディング？';

  @override
  String get width => '幅';

  @override
  String get widthFull => '満杯';

  @override
  String get widthMedium => '中くらい';

  @override
  String get widthNarrow => '狭い';

  @override
  String get wifiOnly => 'Wi‑Fiのみ';

  @override
  String wordCountShort(int count) {
    return '$count 語';
  }

  @override
  String get words => '文字';

  @override
  String get youAreNowPremium => 'これであなたもプレミアムになりました!';
}
