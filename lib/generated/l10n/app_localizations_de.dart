// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get about => 'Über';

  @override
  String get addOrSelectScriptPrompt =>
      'Fügen Sie ein Skript hinzu oder wählen Sie ein Skript aus, um mit der Aufnahme mit Teleprompter-Overlay zu beginnen.';

  @override
  String get adjust => 'Anpassen';

  @override
  String get adNotAvailable => 'Anzeige nicht verfügbar';

  @override
  String get adNotAvailableDesc =>
      'Wir konnten keine Anzeige laden. Versuchen Sie es gleich noch einmal.';

  @override
  String get adNotCompleted => 'Anzeige nicht fertig';

  @override
  String get adNotCompletedDesc =>
      'Sehen Sie sich die vollständige Anzeige an, um Aufnahme-Credits zu erhalten.';

  @override
  String get all => 'Alle';

  @override
  String get allScriptsTitle => 'Alle Skripte';

  @override
  String get appearance => 'Erscheinungsbild';

  @override
  String get appInfoDescription =>
      'Das ultimative Teleprompter- und Videoaufnahmetool für Content Creator. Erstellen, lesen und aufnehmen nahtlos.';

  @override
  String get appInfoTitle => 'ScriptCam';

  @override
  String get appTitle => 'ScriptCam';

  @override
  String get autoBackup => 'Automatische Sicherung';

  @override
  String get autoSync => 'Automatische Synchronisierung';

  @override
  String get backCamera => 'Zurück';

  @override
  String get background => 'Hintergrund';

  @override
  String backupFailedDetail(String error) {
    return 'Sicherungsfehler: $error';
  }

  @override
  String get backupNow => 'Jetzt sichern';

  @override
  String get backupVideos => 'Backup-Videos';

  @override
  String bulkDeleteRecordingsTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Aufnahmen löschen?',
      one: 'Diese Aufnahme löschen?',
    );
    return '$_temp0';
  }

  @override
  String get cameraPreviewWithOverlay =>
      'Kameravorschau mit Live-Teleprompter-Overlay.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get close => 'Schließen';

  @override
  String get cloudBackup => 'Cloud-Backup';

  @override
  String get connected => 'Verbunden';

  @override
  String get connectGoogleDrive => 'Verbinden Sie Google Drive';

  @override
  String get connectionError =>
      'Verbindungsfehler. Überprüfen Sie Ihre Internetverbindung und versuchen Sie es erneut.';

  @override
  String get contactUs => 'Kontakt';

  @override
  String get continueButton => 'Weiter';

  @override
  String get couldNotLoadVideo => 'Video konnte nicht geladen werden';

  @override
  String get countdownTimer => 'Countdown-Timer';

  @override
  String get created => 'Erstellt!';

  @override
  String get createNewScript => 'Neues Skript erstellen';

  @override
  String creditsRemaining(int count) {
    return 'Credits $count';
  }

  @override
  String get cueCards => 'Cue-Karten';

  @override
  String currentCreditsDescription(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Für dieses Skript haben Sie noch $count kostenlose Aufnahmen.',
      one: 'Für dieses Skript haben Sie noch 1 kostenlose Aufnahme.',
    );
    return '$_temp0';
  }

  @override
  String get dark => 'Dunkel';

  @override
  String get darkMode => 'Dunkler Modus';

  @override
  String get defaultCamera => 'Standardkamera';

  @override
  String get delete => 'Löschen';

  @override
  String get deleteScriptMessage =>
      'Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get deleteScriptTitle => 'Skript löschen?';

  @override
  String get deleteVideoTitle => 'Video löschen?';

  @override
  String get discard => 'Verwerfen';

  @override
  String get discardChanges => 'Änderungen verwerfen?';

  @override
  String get discardChangesDesc => 'Ihre Änderungen gehen verloren.';

  @override
  String get disconnect => 'Trennen';

  @override
  String get discountBadge => '20 % RABATT';

  @override
  String get duplicate => 'Duplikat';

  @override
  String durationMinutesSecondsShort(int minutes, int seconds) {
    return '$minutes:$seconds';
  }

  @override
  String durationSecondsShort(int seconds) {
    return '${seconds}s';
  }

  @override
  String get earnRecordingCredits => 'Verdienen Sie Aufnahme-Credits';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get editScript => 'Skript bearbeiten';

  @override
  String get editScriptBlockedDuringCountdown =>
      'Warten Sie, bis der Countdown abgelaufen ist, bevor Sie mit der Bearbeitung beginnen.';

  @override
  String get editScriptBlockedWhileRecording =>
      'Stoppen Sie die Aufnahme, um Ihr Skript zu bearbeiten.';

  @override
  String get emptyCreativeSpaceMessage =>
      'Dein kreativer Bereich ist leer. Erstelle dein erstes Skript oder versuche, spontan etwas aufzunehmen!';

  @override
  String get emptyGallery => 'Noch keine Videos';

  @override
  String get emptyGalleryDesc =>
      'Nimm dein erstes Video auf, um es hier zu sehen';

  @override
  String errorSharingVideo(String error) {
    return 'Video konnte nicht geteilt werden: $error';
  }

  @override
  String exportedScriptSubject(String title) {
    return 'Exportiertes Skript: $title';
  }

  @override
  String get exportQuality => 'Exportqualität';

  @override
  String get exportSuccess => 'Skript erfolgreich exportiert';

  @override
  String get focusLine => 'Fokuslinie';

  @override
  String get font => 'Schriftart';

  @override
  String get fontSize => 'Schriftgröße';

  @override
  String freeRecordingsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Noch $count kostenlose Aufnahmen',
      one: 'Noch 1 kostenlose Aufnahme',
    );
    return '$_temp0';
  }

  @override
  String get freeTrialCancelAnytime =>
      'Die kostenlose Testversion beginnt sofort. Vor der Verlängerung jederzeit kündbar.';

  @override
  String get frontCamera => 'Front';

  @override
  String get fullDuration => 'Voll';

  @override
  String get general => 'Allgemein';

  @override
  String get getPremium => 'Premium holen';

  @override
  String get googleUser => 'Google-Nutzer';

  @override
  String get goPremium => 'Gehen Sie Premium';

  @override
  String get gotIt => 'Verstanden';

  @override
  String get grantAccess => 'Zugriff gewähren';

  @override
  String get help => 'Hilfe';

  @override
  String get highQualityVideo => 'Hochwertiges Video';

  @override
  String get howToUse => 'Anleitung';

  @override
  String get howToUseTitle => 'Anleitung ScriptCam';

  @override
  String get importScript => 'Import';

  @override
  String get importSuccess => 'Skript erfolgreich importiert';

  @override
  String itemsSelected(int count) {
    return '$count ausgewählt';
  }

  @override
  String get keepEditing => 'Bearbeiten Sie weiter';

  @override
  String get language => 'Sprache';

  @override
  String get lifetimeNoRecurringBilling =>
      'Lebenslange Freischaltung. Keine wiederkehrende Abrechnung.';

  @override
  String get lifetimeOneTimeUnlock =>
      'Einmaliger Kauf. Einmal bezahlen, für immer freischalten.';

  @override
  String get lifetimePlan => 'Lebenszeitplan';

  @override
  String get lifetimePriceNotLoaded =>
      'Der Lifetime-Preis wurde noch nicht aus dem Store geladen.';

  @override
  String get light => 'Hell';

  @override
  String get lightMode => 'Heller Modus';

  @override
  String get lineSpacing => 'Zeilenabstand';

  @override
  String get loop => 'Schleife';

  @override
  String get managePremiumStatus => 'Verwalten Sie Ihren Premium-Status';

  @override
  String get minRead => 'min Lesezeit';

  @override
  String get mirror => 'Spiegeln';

  @override
  String get mute => 'Stumm';

  @override
  String get never => 'Niemals';

  @override
  String get newScript => 'Neues Skript';

  @override
  String get newScriptMultiline => 'Neu\nSkript';

  @override
  String get next => 'Weiter';

  @override
  String get noAds => 'Keine Werbung für immer';

  @override
  String get noInternetDesc =>
      'Es scheint, dass Sie offline sind. Bitte überprüfen Sie Ihre Verbindung und versuchen Sie es erneut.';

  @override
  String get noInternetError => 'Kein Internet';

  @override
  String get noInternetErrorDesc =>
      'Stellen Sie eine Verbindung zum Internet her und versuchen Sie es erneut.';

  @override
  String get noInternetTitle => 'Keine Internetverbindung';

  @override
  String get noRecordingsLeft =>
      'Keine Aufnahmen übrig · Sehen Sie sich eine Anzeige an, um fortzufahren';

  @override
  String get noResultsFound => 'Keine Ergebnisse gefunden';

  @override
  String get noResultsMessage =>
      'Wir konnten keine Skripte finden, die deiner Suche entsprechen. Versuche es mit anderen Stichwörtern!';

  @override
  String get noSavedScriptSelected => 'Kein gespeichertes Skript ausgewählt';

  @override
  String get notAuthenticated => 'Nicht bei Google angemeldet.';

  @override
  String get off => 'Aus';

  @override
  String get onboardingAccessCamera => 'Kamera';

  @override
  String get onboardingAccessMic => 'Mikrofon';

  @override
  String get onboardingInteractiveRecLabel => 'REC';

  @override
  String get onboardingInteractiveStep1Eyebrow => 'Hauptansicht';

  @override
  String get onboardingInteractiveStep1Preview =>
      'Overlay-Schrift und Rahmen bleiben gemeinsam sichtbar. Scrollen Sie, um zu proben; Beginnen Sie mit der Aufnahme, wenn sich das Tempo richtig anfühlt.';

  @override
  String get onboardingInteractiveStep1Subtitle =>
      'Bei ScriptCam steht die Aufnahme im Mittelpunkt. Drehbücher, Abspann und Einstellungen bleiben zugänglich, ohne dass die Inhalte, die Sie filmen, überfüllt werden.';

  @override
  String get onboardingInteractiveStep1Title => 'Aufnahme-First-Arbeitsbereich';

  @override
  String get onboardingInteractiveStep2Sample =>
      'Guten Morgen – danke, dass Sie hier sind.\nWir werden dies kurz und praktisch halten.\nWenn Sie von der Linse abweichen, lehnen Sie sich bewusst zurück und machen Sie weiter.';

  @override
  String get onboardingInteractiveStep2Subtitle =>
      'Unterbrechen Sie die Probe mit einem Fingertipp. Passen Sie das Scrolltempo und die Textgröße auf dem Aufnahmebildschirm an, wenn Sie proben oder drehen.';

  @override
  String get onboardingInteractiveStep2Title => 'Teleprompter-Overlay';

  @override
  String get onboardingInteractiveStep4CardHint =>
      'Sie können diese jederzeit in den Android- oder iOS-Einstellungen ändern.';

  @override
  String get onboardingInteractiveStep4Subtitle =>
      'ScriptCam benötigt eine Kamera und ein Mikrofon, damit Sie sich selbst sehen können, während das Skript mit Ihrem Tempo synchronisiert bleibt.';

  @override
  String get onboardingInteractiveStep4Title => 'Aufnahmezugriff';

  @override
  String get opacity => 'Deckkraft';

  @override
  String get original => 'Original';

  @override
  String get overlaySettings => 'Overlay-Einstellungen';

  @override
  String get paste => 'Einfügen';

  @override
  String get permissionsRequired =>
      'Kamera- und Mikrofonberechtigungen sind erforderlich.';

  @override
  String get preferences => 'Präferenzen';

  @override
  String get premium => 'Premium';

  @override
  String get premiumActive => 'Premium Aktiv';

  @override
  String get premiumBenefitInstantRecord =>
      'Premium-Benutzer erhalten sofortige Aufnahme und Sprachsynchronisierung!';

  @override
  String get premiumDescription =>
      'Schalte alle Premium-Funktionen frei und genieße ein werbefreies Erlebnis';

  @override
  String get premiumUnlocked => 'Premium freigeschaltet!';

  @override
  String get privacyPolicy => 'Datenschutz';

  @override
  String get pro => 'PRO';

  @override
  String get processing => 'Verarbeitung...';

  @override
  String purchaseErrorDetail(String p0) {
    return 'Kauf fehlgeschlagen: $p0';
  }

  @override
  String get purchaseFailedInitiate =>
      'Der Kauf konnte nicht gestartet werden. Versuchen Sie es erneut.';

  @override
  String get qualityHigh => 'Hoch';

  @override
  String get qualityLabel => 'Qualität';

  @override
  String get qualityLow => 'Niedrig';

  @override
  String get qualityStandard => 'Standard';

  @override
  String get range => 'Bereich';

  @override
  String get rateUs => 'Bewerten';

  @override
  String get ratio => 'Verhältnis';

  @override
  String get recent => 'Jüngste';

  @override
  String get recordingFailed => 'Aufnahme fehlgeschlagen';

  @override
  String recordingsDeletedToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Aufnahmen gelöscht',
      one: '1 Aufnahme gelöscht',
    );
    return '$_temp0';
  }

  @override
  String recordingsRemainingHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Noch $count Aufnahmen verfügbar',
      one: 'Noch 1 Aufnahme verfügbar',
    );
    return '$_temp0 · Mehr durch Anzeige erhalten';
  }

  @override
  String get recordNow => 'Jetzt aufnehmen';

  @override
  String get remoteControl => 'Bluetooth Remote & Keyboard';

  @override
  String get remoteControlLocked =>
      'Bluetooth-Fernbedienung und Tastatur sind eine Premium-Funktion';

  @override
  String get removeAds => 'Werbung entfernen';

  @override
  String get rename => 'Umbenennen';

  @override
  String get resolution => 'Auflösung';

  @override
  String get restore => 'Wiederherstellen';

  @override
  String get restoredSuccessfully => 'Käufe erfolgreich wiederhergestellt.';

  @override
  String restoreFailed(String error) {
    return 'Wiederherstellung fehlgeschlagen: $error';
  }

  @override
  String get restorePurchaseLink => 'Kauf wiederherstellen';

  @override
  String get retry => 'Wiederholen';

  @override
  String get rewardGranted => 'Gewährte Belohnung: +3 Aufnahmen';

  @override
  String get rotate => 'Drehen';

  @override
  String get save => 'SPEICHERN';

  @override
  String get saveButton => 'Speichern';

  @override
  String get saved => 'Gespeichert';

  @override
  String savedAs(String p0) {
    return 'Gespeichert als $p0';
  }

  @override
  String get saveEditorLabel => 'Speichern';

  @override
  String get saveFailed => 'Speichern fehlgeschlagen';

  @override
  String get saveFailedEmpty => 'Nichts zu retten';

  @override
  String get saveFailedGallery =>
      'Konnte nicht in der Galerie gespeichert werden';

  @override
  String get saveFailedNotFound => 'Speicherort nicht gefunden';

  @override
  String get saveVideo => 'Video speichern';

  @override
  String get savingEllipsis => 'Sparen…';

  @override
  String get scriptContentPlaceholder =>
      'Beginne hier dein Skript zu schreiben...';

  @override
  String get scriptDeleted => 'Skript gelöscht';

  @override
  String scriptSummary(String p0, String p1) {
    return '$p0 · $p1';
  }

  @override
  String get scriptTitleHint => 'z.B. YouTube Intro';

  @override
  String get scriptTitlePlaceholder => 'Skripttitel...';

  @override
  String get scrollSpeed => 'Scrollgeschwindigkeit';

  @override
  String get searchScripts => 'Skripte suchen...';

  @override
  String get selectedScriptReady => 'Ausgewähltes Skript bereit';

  @override
  String get selectLanguage => 'Sprache wählen';

  @override
  String get selectLanguageDesc => 'Wähle deine bevorzugte Sprache für die App';

  @override
  String get selectPlatformDesc => 'Wähle eine Plattform für dein Skript';

  @override
  String get settings => 'Einstellungen';

  @override
  String get shareApp => 'App teilen';

  @override
  String shareAppMessage(String url) {
    return 'Nimm professionelle Videos mit ScriptCam auf! 🎥✨\n\nMit integriertem Teleprompter, 4K-Aufnahme und Video-Editor. Hier ausprobieren:\n$url';
  }

  @override
  String get shareAppSubject => 'Zieh dir ScriptCam rein: Video Teleprompter';

  @override
  String get shareVideoSubject => 'Schauen Sie sich mein Video an';

  @override
  String get shareVideoText => 'Mit ScriptCam aufgenommenes Video';

  @override
  String get signInCancelled => 'Die Anmeldung wurde abgebrochen.';

  @override
  String get softStart => 'Sanfter Start';

  @override
  String get speed => 'Geschwindigkeit';

  @override
  String get speedFast => 'Schnell';

  @override
  String get speedNormal => 'Normal';

  @override
  String get speedSlow => 'Langsam';

  @override
  String get speedTurbo => 'Turbo';

  @override
  String get startFreeTrial => 'Kostenlose Testversion starten';

  @override
  String get startRecording => 'Aufnahme starten';

  @override
  String get startYourJourney => 'Starte deine Reise';

  @override
  String get step1Desc =>
      'Beginne mit einem neuen Skript oder einer Schnellaufnahme ohne Text';

  @override
  String get step1Title => 'Skript erstellen';

  @override
  String get step2Desc =>
      'Passe Geschwindigkeit und Schriftgröße an und aktiviere Sprach-Sync für freihändiges Scrollen';

  @override
  String get step2Title => 'Teleprompter einrichten';

  @override
  String get step3Desc =>
      'Drücke Aufnahme und lies dein Skript, während du in die Kamera schaust';

  @override
  String get step3Title => 'Video aufnehmen';

  @override
  String get step4Desc =>
      'Nutze den Video-Editor zum Schneiden, Anpassen und Filtern vor dem Teilen';

  @override
  String get step4Title => 'Bearbeiten & Teilen';

  @override
  String get step5Desc =>
      'Verwenden Sie eine Bluetooth-Fernbedienung oder Tastatur zum Abspielen, Anhalten und Anpassen der Scrollgeschwindigkeit.';

  @override
  String get step5Title => 'Fernbedienung';

  @override
  String get storePricingUnavailable =>
      'Store-Preise sind derzeit nicht verfügbar.';

  @override
  String get storeUnavailable =>
      'Der Shop ist nicht verfügbar. Versuchen Sie es später noch einmal.';

  @override
  String get stripView => 'Streifenansicht';

  @override
  String get studioEditor => 'Studio-Editor';

  @override
  String get support => 'Support';

  @override
  String get supportBody => 'Hallo ScriptCam-Team,';

  @override
  String get supportSubject => 'ScriptCam-Unterstützung';

  @override
  String get switchAccount => 'Konto wechseln';

  @override
  String get system => 'System';

  @override
  String get systemDefault => 'Systemstandard';

  @override
  String get tabCamera => 'Kamera';

  @override
  String get tabRecordings => 'Aufnahmen';

  @override
  String get tabScripts => 'Skripte';

  @override
  String get targetFps => 'Ziel-FPS';

  @override
  String get text => 'Text';

  @override
  String get textPasted => 'Text eingefügt';

  @override
  String get titleRequired => 'Titel erforderlich';

  @override
  String get transform => 'Transformieren';

  @override
  String get trim => 'Schneiden';

  @override
  String get unexpectedError => 'Etwas ist schief gelaufen';

  @override
  String get unexpectedErrorDesc =>
      'Etwas ist schief gelaufen. Bitte versuchen Sie es erneut.';

  @override
  String get unlimitedRecordings => 'Unbegrenzte Aufnahmen';

  @override
  String get unlimitedScripts => 'Unbegrenzte Skripte';

  @override
  String get unlockAllFeatures =>
      'Alle Funktionen freischalten & Werbung entfernen';

  @override
  String get unlockCreatorPro => 'Creator Pro freischalten';

  @override
  String get untitledScript => 'Unbenanntes Skript';

  @override
  String get upgradeForLifetime => 'Upgrade für lebenslangen Zugriff';

  @override
  String get upgradeToPro => 'Upgrade auf Pro';

  @override
  String get useASavedScript => 'Verwenden Sie ein gespeichertes Skript';

  @override
  String get version => 'Version';

  @override
  String get videoDeleted => 'Video gelöscht';

  @override
  String get videoFileNotFound => 'Videodatei nicht gefunden';

  @override
  String get videoName => 'Dateiname';

  @override
  String get videoNameHint => 'MeinVideo';

  @override
  String get videoSettings => 'Video-Einstellungen';

  @override
  String get voiceSync => 'Sprach-Sync';

  @override
  String get voiceSyncFeature => 'Sprachsynchronisierung';

  @override
  String get voiceSyncLocked =>
      'Sprachsynchronisierung ist eine Premium-Funktion';

  @override
  String get watchAdGetRecordings =>
      '1 Anzeige ansehen → +3 Aufnahmen erhalten';

  @override
  String get watchAdToRecord => 'Sehen Sie sich die Anzeige zum Aufzeichnen an';

  @override
  String get watchAdToRecordDesc =>
      'Sehen Sie sich eine kurze Anzeige an, um die Aufnahme für dieses Skript freizuschalten.';

  @override
  String get weeklyPlan => 'Wöchentlich';

  @override
  String get weeklyPriceNotLoaded =>
      'Der wöchentliche Preis wurde noch nicht aus dem Store geladen.';

  @override
  String get weeklyTrialStorePrice =>
      '3-tägige kostenlose Testversion, Wochenpreis im Store';

  @override
  String weeklyTrialThenPrice(String price) {
    return '3-tägige kostenlose Testversion, dann $price/Woche';
  }

  @override
  String get whatAreYouRecording => 'Was bist du?\nAufnahme heute?';

  @override
  String get width => 'Breite';

  @override
  String get widthFull => 'Voll';

  @override
  String get widthMedium => 'Medium';

  @override
  String get widthNarrow => 'Eng';

  @override
  String get wifiOnly => 'Nur WLAN';

  @override
  String wordCountShort(int count) {
    return '$count Wörter';
  }

  @override
  String get words => 'Wörter';

  @override
  String get youAreNowPremium => 'Du bist jetzt Premium!';
}
