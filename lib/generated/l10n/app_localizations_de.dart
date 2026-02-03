// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'ScriptCam';

  @override
  String get onboardingWelcomeTitle => 'Willkommen bei ScriptCam';

  @override
  String get onboardingWelcomeDesc =>
      'Dein All-in-One Teleprompter-Studio. Schreibe Skripte, nimm Videos auf und bearbeite nahtlos.';

  @override
  String get onboardingScriptEditorTitle => 'Skript-Editor';

  @override
  String get onboardingScriptEditorDesc =>
      'Schreibe und verwalte deine Videoskripte mit Leichtigkeit. Organisiere deine Ideen sofort.';

  @override
  String get onboardingTeleprompterTitle => 'Teleprompter';

  @override
  String get onboardingTeleprompterDesc =>
      'Lies dein Skript, während du direkt in die Kamera schaust. Professionelle Aufnahme leicht gemacht.';

  @override
  String get onboardingPermissionsTitle => 'Berechtigungen aktivieren';

  @override
  String get onboardingPermissionsDesc =>
      'Um Videos aufzunehmen und deine Stimme mit dem Skript zu synchronisieren, benötigen wir Zugriff auf deine Kamera und dein Mikrofon.';

  @override
  String get grantAccess => 'Zugriff gewähren';

  @override
  String get start => 'Starten';

  @override
  String get next => 'Weiter';

  @override
  String get permissionsRequired =>
      'Kamera- und Mikrofonberechtigungen sind erforderlich.';

  @override
  String get selectLanguage => 'Sprache wählen';

  @override
  String get selectLanguageDesc => 'Wähle deine bevorzugte Sprache für die App';

  @override
  String get continueButton => 'Weiter';

  @override
  String get settings => 'Einstellungen';

  @override
  String get preferences => 'Präferenzen';

  @override
  String get help => 'Hilfe';

  @override
  String get support => 'Support';

  @override
  String get about => 'Über';

  @override
  String get appearance => 'Erscheinungsbild';

  @override
  String get language => 'Sprache';

  @override
  String get systemDefault => 'Systemstandard';

  @override
  String get lightMode => 'Heller Modus';

  @override
  String get darkMode => 'Dunkler Modus';

  @override
  String get system => 'System';

  @override
  String get light => 'Hell';

  @override
  String get dark => 'Dunkel';

  @override
  String get howToUse => 'Anleitung';

  @override
  String get shareApp => 'App teilen';

  @override
  String get contactUs => 'Kontakt';

  @override
  String get rateUs => 'Bewerten';

  @override
  String get privacyPolicy => 'Datenschutz';

  @override
  String get version => 'Version';

  @override
  String get upgradeToPro => 'Upgrade auf Pro';

  @override
  String get unlockAllFeatures =>
      'Alle Funktionen freischalten & Werbung entfernen';

  @override
  String shareAppMessage(String url) {
    return 'Nimm professionelle Videos mit ScriptCam auf! 🎥✨\n\nMit integriertem Teleprompter, 4K-Aufnahme und Video-Editor. Hier ausprobieren:\n$url';
  }

  @override
  String get shareAppSubject => 'Zieh dir ScriptCam rein: Video Teleprompter';

  @override
  String get goodMorning => 'Guten Morgen';

  @override
  String get goodAfternoon => 'Guten Tag';

  @override
  String get goodEvening => 'Guten Abend';

  @override
  String get readyToCreate => 'Bereit, etwas Großartiges zu schaffen?';

  @override
  String get newScript => 'Neues Skript';

  @override
  String get writeFromScratch => 'Von Grund auf neu';

  @override
  String get quickRecord => 'Schnellaufnahme';

  @override
  String get recordOnTheFly => 'Spontan aufnehmen';

  @override
  String get myScripts => 'Meine Skripte';

  @override
  String get recentFirst => 'Neueste zuerst';

  @override
  String get quickRecordDialogTitle => 'Schnellaufnahme';

  @override
  String get quickRecordDialogDesc =>
      'Gib unten Skriptdetails ein oder überspringe, um die Kamera ohne Text zu öffnen.';

  @override
  String get scriptTitle => 'Skripttitel';

  @override
  String get scriptContent => 'Skriptinhalt';

  @override
  String get scriptTitleHint => 'z.B. YouTube Intro';

  @override
  String get scriptContentHint => 'Füge deinen Skriptinhalt hier ein...';

  @override
  String get startRecording => 'Aufnahme starten';

  @override
  String get editScript => 'Skript bearbeiten';

  @override
  String get save => 'SPEICHERN';

  @override
  String get scriptTitlePlaceholder => 'Skripttitel...';

  @override
  String get scriptContentPlaceholder =>
      'Beginne hier dein Skript zu schreiben...';

  @override
  String get platform => 'PLATTFORM';

  @override
  String get titleRequired => 'Titel erforderlich';

  @override
  String get saved => 'Gespeichert';

  @override
  String get created => 'Erstellt!';

  @override
  String get textPasted => 'Text eingefügt';

  @override
  String get scriptDeleted => 'Skript gelöscht';

  @override
  String get deleteScriptTitle => 'Skript löschen?';

  @override
  String get deleteScriptMessage =>
      'Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get appInfoTitle => 'ScriptCam';

  @override
  String get appInfoVersion => 'Version 1.0.3';

  @override
  String get appInfoDescription =>
      'Das ultimative Teleprompter- und Videoaufnahmetool für Content Creator. Erstellen, lesen und aufnehmen nahtlos.';

  @override
  String get close => 'Schließen';

  @override
  String get emptyScriptsAll => 'Noch keine Skripte';

  @override
  String get emptyScriptsAllDesc =>
      'Erstelle dein erstes Skript, um zu beginnen';

  @override
  String emptyScriptsCategory(String category) {
    return 'Keine $category Skripte';
  }

  @override
  String get emptyScriptsCategoryDesc =>
      'Erstelle ein Skript für diese Plattform';

  @override
  String get gallery => 'Galerie';

  @override
  String get emptyGallery => 'Noch keine Videos';

  @override
  String get emptyGalleryDesc =>
      'Nimm dein erstes Video auf, um es hier zu sehen';

  @override
  String get teleprompter => 'Teleprompter';

  @override
  String get record => 'Aufnehmen';

  @override
  String get stop => 'Stopp';

  @override
  String get pause => 'Pause';

  @override
  String get resume => 'Fortsetzen';

  @override
  String get speed => 'Geschwindigkeit';

  @override
  String get fontSize => 'Schriftgröße';

  @override
  String get mirror => 'Spiegeln';

  @override
  String get voiceSync => 'Sprach-Sync';

  @override
  String get autoScroll => 'Auto-Scroll';

  @override
  String get videoSettings => 'Video-Einstellungen';

  @override
  String get resolution => 'Auflösung';

  @override
  String get quality => 'Qualität';

  @override
  String get premium => 'Premium';

  @override
  String get getPremium => 'Premium holen';

  @override
  String get restorePurchases => 'Käufe wiederherstellen';

  @override
  String get videoEditor => 'Video-Editor';

  @override
  String get trim => 'Schneiden';

  @override
  String get adjust => 'Anpassen';

  @override
  String get filters => 'Filter';

  @override
  String get export => 'Exportieren';

  @override
  String get exporting => 'Exportiere...';

  @override
  String get exportComplete => 'Export fertig!';

  @override
  String get brightness => 'Helligkeit';

  @override
  String get contrast => 'Kontrast';

  @override
  String get saturation => 'Sättigung';

  @override
  String get share => 'Teilen';

  @override
  String get play => 'Abspielen';

  @override
  String get all => 'Alle';

  @override
  String get general => 'Allgemein';

  @override
  String get search => 'Suche';

  @override
  String get searchScripts => 'Skripte suchen...';

  @override
  String get studio => 'Studio';

  @override
  String get startYourJourney => 'Starte deine Reise';

  @override
  String get noResultsFound => 'Keine Ergebnisse gefunden';

  @override
  String get noResultsMessage =>
      'Wir konnten keine Skripte finden, die deiner Suche entsprechen. Versuche es mit anderen Stichwörtern!';

  @override
  String get emptyCreativeSpaceMessage =>
      'Dein kreativer Bereich ist leer. Erstelle dein erstes Skript oder versuche, spontan etwas aufzunehmen!';

  @override
  String get paste => 'Einfügen';

  @override
  String get createNewScript => 'Neues Skript erstellen';

  @override
  String get selectPlatformDesc => 'Wähle eine Plattform für dein Skript';

  @override
  String get pro => 'PRO';

  @override
  String get minRead => 'min Lesezeit';

  @override
  String get words => 'Wörter';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get howToUseTitle => 'Anleitung ScriptCam';

  @override
  String get step1Title => 'Skript erstellen';

  @override
  String get step1Desc =>
      'Beginne mit einem neuen Skript oder einer Schnellaufnahme ohne Text';

  @override
  String get step2Title => 'Teleprompter einrichten';

  @override
  String get step2Desc =>
      'Passe Geschwindigkeit und Schriftgröße an und aktiviere Sprach-Sync für freihändiges Scrollen';

  @override
  String get step3Title => 'Video aufnehmen';

  @override
  String get step3Desc =>
      'Drücke Aufnahme und lies dein Skript, während du in die Kamera schaust';

  @override
  String get step4Title => 'Bearbeiten & Teilen';

  @override
  String get step4Desc =>
      'Nutze den Video-Editor zum Schneiden, Anpassen und Filtern vor dem Teilen';

  @override
  String get gotIt => 'Verstanden';

  @override
  String get deleteVideoTitle => 'Video löschen?';

  @override
  String get videoDeleted => 'Video gelöscht';

  @override
  String get mute => 'Stumm';

  @override
  String get opacity => 'Deckkraft';

  @override
  String get original => 'Original';

  @override
  String get processing => 'Verarbeitung...';

  @override
  String get range => 'Bereich';

  @override
  String get ratio => 'Verhältnis';

  @override
  String get recordingFailed => 'Aufnahme fehlgeschlagen';

  @override
  String get rotate => 'Drehen';

  @override
  String get targetFps => 'Ziel-FPS';

  @override
  String get transform => 'Transformieren';

  @override
  String get premiumDescription =>
      'Schalte alle Premium-Funktionen frei und genieße ein werbefreies Erlebnis';

  @override
  String get removeAds => 'Werbung entfernen';

  @override
  String get unlimitedScripts => 'Unbegrenzte Skripte';

  @override
  String get unlockCreatorPro => 'Creator Pro freischalten';

  @override
  String get upgradeForLifetime => 'Upgrade für lebenslangen Zugriff';

  @override
  String get restorePurchaseLink => 'Kauf wiederherstellen';

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
