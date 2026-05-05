// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get about => 'À Propos';

  @override
  String get addOrSelectScriptPrompt =>
      'Ajoutez ou sélectionnez un script pour commencer l\'enregistrement avec la superposition du téléprompteur.';

  @override
  String get adjust => 'Ajuster';

  @override
  String get adNotAvailable => 'Annonce indisponible';

  @override
  String get adNotAvailableDesc =>
      'Nous n\'avons pas pu charger une annonce. Réessayez dans un instant.';

  @override
  String get adNotCompleted => 'Annonce non terminée';

  @override
  String get adNotCompletedDesc =>
      'Regardez l\'intégralité de l\'annonce pour gagner des crédits d\'enregistrement.';

  @override
  String get all => 'Tout';

  @override
  String get allScriptsTitle => 'Tous les scripts';

  @override
  String get appearance => 'Apparence';

  @override
  String get appInfoDescription =>
      'L\'outil ultime de téléprompteur et d\'enregistrement vidéo pour les créateurs. Créez, lisez et enregistrez sans interruption.';

  @override
  String get appInfoTitle => 'ScriptCam';

  @override
  String get appTitle => 'ScriptCam';

  @override
  String get autoBackup => 'Sauvegarde automatique';

  @override
  String get autoSync => 'Synchronisation automatique';

  @override
  String get backCamera => 'Dos';

  @override
  String get background => 'Arrière-plan';

  @override
  String backupFailedDetail(String error) {
    return 'Erreur de sauvegarde : $error';
  }

  @override
  String get backupNow => 'Sauvegarder maintenant';

  @override
  String get backupVideos => 'Vidéos de sauvegarde';

  @override
  String bulkDeleteRecordingsTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Supprimer $count enregistrements ?',
      one: 'Supprimer cet enregistrement ?',
    );
    return '$_temp0';
  }

  @override
  String get cameraPreviewWithOverlay =>
      'Aperçu de la caméra avec superposition de téléprompteur en direct.';

  @override
  String get cancel => 'Annuler';

  @override
  String get close => 'Fermer';

  @override
  String get cloudBackup => 'Sauvegarde dans le cloud';

  @override
  String get connected => 'Connecté';

  @override
  String get connectGoogleDrive => 'Connectez Google Drive';

  @override
  String get connectionError =>
      'Erreur de connexion. Vérifiez votre connexion Internet et réessayez.';

  @override
  String get contactUs => 'Contactez-nous';

  @override
  String get continueButton => 'Continuer';

  @override
  String get couldNotLoadVideo => 'Impossible de charger la vidéo';

  @override
  String get countdownTimer => 'Compte à rebours';

  @override
  String get created => 'Créé !';

  @override
  String get createNewScript => 'Créer Nouveau Script';

  @override
  String creditsRemaining(int count) {
    return 'Crédits $count';
  }

  @override
  String get cueCards => 'Cartes aide-mémoire';

  @override
  String currentCreditsDescription(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Il vous reste $count enregistrements gratuits pour ce script.',
      one: 'Il vous reste 1 enregistrement gratuit pour ce script.',
    );
    return '$_temp0';
  }

  @override
  String get dark => 'Sombre';

  @override
  String get darkMode => 'Mode Sombre';

  @override
  String get defaultCamera => 'Caméra par défaut';

  @override
  String get delete => 'Supprimer';

  @override
  String get deleteScriptMessage => 'Cette action est irréversible.';

  @override
  String get deleteScriptTitle => 'Supprimer le Script ?';

  @override
  String get deleteVideoTitle => 'Supprimer la Vidéo ?';

  @override
  String get discard => 'Jeter';

  @override
  String get discardChanges => 'Supprimer les modifications ?';

  @override
  String get discardChangesDesc => 'Vos modifications seront perdues.';

  @override
  String get disconnect => 'Déconnecter';

  @override
  String get discountBadge => '20% DE RÉDUCTION';

  @override
  String get duplicate => 'Double';

  @override
  String durationMinutesSecondsShort(int minutes, int seconds) {
    return '$minutes :$seconds';
  }

  @override
  String durationSecondsShort(int seconds) {
    return '$seconds s';
  }

  @override
  String get earnRecordingCredits => 'Gagnez des crédits d\'enregistrement';

  @override
  String get edit => 'Modifier';

  @override
  String get editScript => 'Modifier le Script';

  @override
  String get editScriptBlockedDuringCountdown =>
      'Attendez la fin du compte à rebours avant de modifier.';

  @override
  String get editScriptBlockedWhileRecording =>
      'Arrêtez l\'enregistrement pour modifier votre script.';

  @override
  String get emptyCreativeSpaceMessage =>
      'Votre espace créatif est vide. Créez votre premier script ou essayez d\'enregistrer quelque chose à la volée !';

  @override
  String get emptyGallery => 'Pas de vidéos';

  @override
  String get emptyGalleryDesc =>
      'Enregistrez votre première vidéo pour la voir ici';

  @override
  String errorSharingVideo(String error) {
    return 'Impossible de partager la vidéo : $error';
  }

  @override
  String exportedScriptSubject(String title) {
    return 'Script exporté : $title';
  }

  @override
  String get exportQuality => 'Qualité des exportations';

  @override
  String get exportSuccess => 'Script exporté avec succès';

  @override
  String get focusLine => 'Ligne de mise au point';

  @override
  String get font => 'Fonte';

  @override
  String get fontSize => 'Taille Police';

  @override
  String freeRecordingsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Il reste $count enregistrements gratuits',
      one: 'Il reste 1 enregistrement gratuit',
    );
    return '$_temp0';
  }

  @override
  String get freeTrialCancelAnytime =>
      'L\'essai gratuit commence immédiatement. Annulez à tout moment avant le renouvellement.';

  @override
  String get frontCamera => 'Devant';

  @override
  String get fullDuration => 'Complet';

  @override
  String get general => 'Général';

  @override
  String get getPremium => 'Obtenir Premium';

  @override
  String get googleUser => 'Utilisateur Google';

  @override
  String get goPremium => 'Passez à la version premium';

  @override
  String get gotIt => 'Compris';

  @override
  String get grantAccess => 'Autoriser l\'Accès';

  @override
  String get help => 'Aide';

  @override
  String get highQualityVideo => 'Vidéo de haute qualité';

  @override
  String get howToUse => 'Comment Utiliser';

  @override
  String get howToUseTitle => 'Comment Utiliser ScriptCam';

  @override
  String get importScript => 'Importer';

  @override
  String get importSuccess => 'Script importé avec succès';

  @override
  String itemsSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sélectionnés',
      one: '1 sélectionné',
    );
    return '$_temp0';
  }

  @override
  String get keepEditing => 'Continuer à éditer';

  @override
  String get language => 'Langue';

  @override
  String get lifetimeNoRecurringBilling =>
      'Déverrouillage à vie. Pas de facturation récurrente.';

  @override
  String get lifetimeOneTimeUnlock =>
      'Achat unique. Payez une fois, débloquez pour toujours.';

  @override
  String get lifetimePlan => 'Forfait à vie';

  @override
  String get lifetimePriceNotLoaded =>
      'Le prix à vie n\'est pas encore téléchargé depuis le magasin.';

  @override
  String get light => 'Clair';

  @override
  String get lightMode => 'Mode Clair';

  @override
  String get lineSpacing => 'Espacement des lignes';

  @override
  String get loop => 'Boucle';

  @override
  String get managePremiumStatus => 'Gérez votre statut premium';

  @override
  String get minRead => 'min de lecture';

  @override
  String get mirror => 'Miroir';

  @override
  String get mute => 'Muet';

  @override
  String get never => 'Jamais';

  @override
  String get newScript => 'Nouveau Script';

  @override
  String get newScriptMultiline => 'Nouveau\nScénario';

  @override
  String get next => 'Suivant';

  @override
  String get noAds => 'Pas de publicité pour toujours';

  @override
  String get noInternetDesc =>
      'Il semble que vous soyez hors ligne. Veuillez vérifier votre connexion et réessayer.';

  @override
  String get noInternetError => 'Pas d\'internet';

  @override
  String get noInternetErrorDesc => 'Connectez-vous à Internet et réessayez.';

  @override
  String get noInternetTitle => 'Pas de connexion Internet';

  @override
  String get noRecordingsLeft =>
      'Aucun enregistrement restant · Regardez une annonce pour continuer';

  @override
  String get noResultsFound => 'Aucun résultat trouvé';

  @override
  String get noResultsMessage =>
      'Nous n\'avons trouvé aucun script correspondant à votre recherche. Essayez d\'autres mots-clés !';

  @override
  String get noSavedScriptSelected => 'Aucun script enregistré sélectionné';

  @override
  String get notAuthenticated => 'Non connecté à Google.';

  @override
  String get off => 'Désactivé';

  @override
  String get onboardingAccessCamera => 'Caméra';

  @override
  String get onboardingAccessMic => 'Microphone';

  @override
  String get onboardingInteractiveRecLabel => 'REC';

  @override
  String get onboardingInteractiveStep1Eyebrow => 'Vue principale';

  @override
  String get onboardingInteractiveStep1Preview =>
      'Le script de superposition et le cadrage restent visibles ensemble. Faites défiler pour répéter ; commencez à enregistrer lorsque le rythme vous convient.';

  @override
  String get onboardingInteractiveStep1Subtitle =>
      'ScriptCam se concentre sur la capture. Les scripts, les crédits et les paramètres restent accessibles sans encombrer ce que vous filmez.';

  @override
  String get onboardingInteractiveStep1Title =>
      'Espace de travail axé sur l\'enregistrement';

  @override
  String get onboardingInteractiveStep2Sample =>
      'Bonjour, merci d\'être ici.\nNous resterons brefs et pratiques.\nSi vous vous éloignez de l’objectif, installez-vous délibérément et continuez.';

  @override
  String get onboardingInteractiveStep2Subtitle =>
      'Mettez la répétition en pause d’un seul clic. Ajustez le rythme de défilement et la taille du texte à partir de l\'écran d\'enregistrement lorsque vous répétez ou filmez.';

  @override
  String get onboardingInteractiveStep2Title =>
      'Superposition de téléprompteur';

  @override
  String get onboardingInteractiveStep4CardHint =>
      'Vous pouvez les modifier à tout moment dans les paramètres Android ou iOS.';

  @override
  String get onboardingInteractiveStep4Subtitle =>
      'ScriptCam a besoin d\'une caméra et d\'un microphone pour que vous puissiez vous voir pendant que le script reste synchronisé avec votre rythme.';

  @override
  String get onboardingInteractiveStep4Title => 'Accès à l\'enregistrement';

  @override
  String get opacity => 'Opacité';

  @override
  String get original => 'Original';

  @override
  String get overlaySettings => 'Paramètres de superposition';

  @override
  String get paste => 'Coller';

  @override
  String get permissionsRequired =>
      'Les autorisations Caméra et Microphone sont requises.';

  @override
  String get preferences => 'Préférences';

  @override
  String get premium => 'Premium';

  @override
  String get premiumActive => 'Actif Premium';

  @override
  String get premiumBenefitInstantRecord =>
      'Les utilisateurs Premium bénéficient d\'un enregistrement instantané et de la synchronisation vocale !';

  @override
  String get premiumDescription =>
      'Débloquez toutes les fonctionnalités premium et profitez d\'une expérience sans publicité';

  @override
  String get premiumUnlocked => 'Prime débloquée !';

  @override
  String get privacyPolicy => 'Politique de Confidentialité';

  @override
  String get pro => 'PRO';

  @override
  String get processing => 'Traitement...';

  @override
  String purchaseErrorDetail(String p0) {
    return 'Échec de l\'achat : $p0';
  }

  @override
  String get purchaseFailedInitiate =>
      'Impossible de démarrer l\'achat. Essayer à nouveau.';

  @override
  String get qualityHigh => 'Haut';

  @override
  String get qualityLabel => 'Qualité';

  @override
  String get qualityLow => 'Faible';

  @override
  String get qualityStandard => 'Standard';

  @override
  String get range => 'Plage';

  @override
  String get rateUs => 'Notez-nous';

  @override
  String get ratio => 'Ratio';

  @override
  String get recent => 'Récent';

  @override
  String get recordingFailed => 'Échec de l\'enregistrement';

  @override
  String recordingsDeletedToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count enregistrements supprimés',
      one: '1 enregistrement supprimé',
    );
    return '$_temp0';
  }

  @override
  String recordingsRemainingHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Il reste $count enregistrements',
      one: 'Il reste 1 enregistrement',
    );
    return '$_temp0 · Regardez une pub pour en obtenir plus';
  }

  @override
  String get recordNow => 'Enregistrez maintenant';

  @override
  String get remoteControl => 'Télécommande et clavier Bluetooth';

  @override
  String get remoteControlLocked =>
      'La télécommande et le clavier Bluetooth sont une fonctionnalité Premium';

  @override
  String get removeAds => 'Supprimer les Pubs';

  @override
  String get rename => 'Rebaptiser';

  @override
  String get resolution => 'Résolution';

  @override
  String get restore => 'Restaurer';

  @override
  String get restoredSuccessfully => 'Achats restaurés avec succès.';

  @override
  String restoreFailed(String error) {
    return 'Échec de la restauration : $error';
  }

  @override
  String get restorePurchaseLink => 'Restaurer l\'achat';

  @override
  String get retry => 'Réessayer';

  @override
  String get rewardGranted => 'Récompense accordée : +3 enregistrements';

  @override
  String get rotate => 'Pivoter';

  @override
  String get save => 'ENREGISTRER';

  @override
  String get saveButton => 'Sauvegarder';

  @override
  String get saved => 'Enregistré';

  @override
  String savedAs(String p0) {
    return 'Enregistré sous $p0';
  }

  @override
  String get saveEditorLabel => 'Sauvegarder';

  @override
  String get saveFailed => 'Échec de l\'enregistrement';

  @override
  String get saveFailedEmpty => 'Rien à sauver';

  @override
  String get saveFailedGallery => 'Impossible d\'enregistrer dans la galerie';

  @override
  String get saveFailedNotFound => 'Emplacement de sauvegarde introuvable';

  @override
  String get saveVideo => 'Enregistrer la vidéo';

  @override
  String get savingEllipsis => 'Économie…';

  @override
  String get scriptContentPlaceholder =>
      'Commencez à écrire votre script ici...';

  @override
  String get scriptDeleted => 'Script supprimé';

  @override
  String scriptSummary(String p0, String p1) {
    return '$p0 · $p1';
  }

  @override
  String get scriptTitleHint => 'ex. Intro YouTube';

  @override
  String get scriptTitlePlaceholder => 'Titre du Script...';

  @override
  String get scrollSpeed => 'Vitesse de défilement';

  @override
  String get searchScripts => 'Rechercher des scripts...';

  @override
  String get selectedScriptReady => 'Script sélectionné prêt';

  @override
  String get selectLanguage => 'Choisir la Langue';

  @override
  String get selectLanguageDesc =>
      'Choisissez votre langue préférée pour l\'application';

  @override
  String get selectPlatformDesc =>
      'Sélectionnez une plateforme pour votre script';

  @override
  String get settings => 'Paramètres';

  @override
  String get shareApp => 'Partager l\'App';

  @override
  String shareAppMessage(String url) {
    return 'Enregistrez des vidéos professionnelles avec ScriptCam ! 🎥✨\n\nAvec Téléprompteur intégré, enregistrement 4K et Éditeur Vidéo. Essayez ici :\n$url';
  }

  @override
  String get shareAppSubject => 'Découvrez ScriptCam : Téléprompteur Vidéo';

  @override
  String get shareVideoSubject => 'Regardez ma vidéo';

  @override
  String get shareVideoText => 'Vidéo enregistrée avec ScriptCam';

  @override
  String get signInCancelled => 'La connexion a été annulée.';

  @override
  String get softStart => 'Démarrage progressif';

  @override
  String get speed => 'Vitesse';

  @override
  String get speedFast => 'Rapide';

  @override
  String get speedNormal => 'Normale';

  @override
  String get speedSlow => 'Lent';

  @override
  String get speedTurbo => 'Turbo';

  @override
  String get startFreeTrial => 'Commencer l\'essai gratuit';

  @override
  String get startRecording => 'Commencer l\'Enregistrement';

  @override
  String get startYourJourney => 'Commencez Votre Aventure';

  @override
  String get step1Desc =>
      'Commencez par créer un nouveau script ou un enregistrement rapide sans texte';

  @override
  String get step1Title => 'Créer un Script';

  @override
  String get step2Desc =>
      'Ajustez la vitesse, la taille de la police et activez la synchronisation vocale pour le défilement mains libres';

  @override
  String get step2Title => 'Configurer le Téléprompteur';

  @override
  String get step3Desc =>
      'Appuyez sur enregistrer et lisez votre script en regardant la caméra';

  @override
  String get step3Title => 'Enregistrez Votre Vidéo';

  @override
  String get step4Desc =>
      'Utilisez l\'éditeur vidéo pour rogner, ajuster et appliquer des filtres avant de partager';

  @override
  String get step4Title => 'Éditer et Partager';

  @override
  String get step5Desc =>
      'Utilisez une télécommande ou un clavier Bluetooth pour lire, mettre en pause et régler la vitesse de défilement.';

  @override
  String get step5Title => 'Télécommande';

  @override
  String get storePricingUnavailable =>
      'Les prix en magasin ne sont pas disponibles pour le moment.';

  @override
  String get storeUnavailable =>
      'Le magasin n\'est pas disponible. Réessayez plus tard.';

  @override
  String get stripView => 'Vue en bande';

  @override
  String get studioEditor => 'Éditeur de studio';

  @override
  String get support => 'Support';

  @override
  String get supportBody => 'Bonjour l\'équipe ScriptCam,';

  @override
  String get supportSubject => 'Prise en charge de ScriptCam';

  @override
  String get switchAccount => 'Changer de compte';

  @override
  String get system => 'Système';

  @override
  String get systemDefault => 'Défaut Système';

  @override
  String get tabCamera => 'Caméra';

  @override
  String get tabRecordings => 'Enregistrements';

  @override
  String get tabScripts => 'Scripts';

  @override
  String get targetFps => 'FPS Cible';

  @override
  String get text => 'Texte';

  @override
  String get textPasted => 'Texte collé';

  @override
  String get titleRequired => 'Titre requis';

  @override
  String get transform => 'Transformer';

  @override
  String get trim => 'Rogner';

  @override
  String get unexpectedError => 'Quelque chose s\'est mal passé';

  @override
  String get unexpectedErrorDesc =>
      'Quelque chose s\'est mal passé. Veuillez réessayer.';

  @override
  String get unlimitedRecordings => 'Enregistrements illimités';

  @override
  String get unlimitedScripts => 'Scripts Illimités';

  @override
  String get unlockAllFeatures => 'Débloquez tout et supprimez les pubs';

  @override
  String get unlockCreatorPro => 'Débloquer Creator Pro';

  @override
  String get untitledScript => 'Script sans titre';

  @override
  String get upgradeForLifetime => 'Mise à niveau pour un accès à vie';

  @override
  String get upgradeToPro => 'Passer à Pro';

  @override
  String get useASavedScript => 'Utiliser un script enregistré';

  @override
  String get version => 'Version';

  @override
  String get videoDeleted => 'Vidéo supprimée';

  @override
  String get videoFileNotFound => 'Fichier vidéo introuvable';

  @override
  String get videoName => 'Nom de fichier';

  @override
  String get videoNameHint => 'MaVidéo';

  @override
  String get videoSettings => 'Réglages Vidéo';

  @override
  String get voiceSync => 'Synchro Vocale';

  @override
  String get voiceSyncFeature => 'Synchronisation vocale';

  @override
  String get voiceSyncLocked =>
      'La synchronisation vocale est une fonctionnalité Premium';

  @override
  String get watchAdGetRecordings =>
      'Regarder 1 annonce → Obtenez +3 enregistrements';

  @override
  String get watchAdToRecord => 'Regarder l\'annonce pour l\'enregistrer';

  @override
  String get watchAdToRecordDesc =>
      'Regardez une courte publicité pour débloquer l\'enregistrement de ce script.';

  @override
  String get weeklyPlan => 'Hebdomadaire';

  @override
  String get weeklyPriceNotLoaded =>
      'Le prix hebdomadaire n\'est pas encore chargé depuis le magasin.';

  @override
  String get weeklyTrialStorePrice =>
      'Essai gratuit de 3 jours, prix hebdomadaire en magasin';

  @override
  String weeklyTrialThenPrice(String price) {
    return 'Essai gratuit de 3 jours, puis $price/semaine';
  }

  @override
  String get whatAreYouRecording =>
      'Qu\'est-ce que tu es\ntu enregistres aujourd\'hui ?';

  @override
  String get width => 'Largeur';

  @override
  String get widthFull => 'Complet';

  @override
  String get widthMedium => 'Moyen';

  @override
  String get widthNarrow => 'Étroit';

  @override
  String get wifiOnly => 'Wi-Fi uniquement';

  @override
  String wordCountShort(int count) {
    return '$count mots';
  }

  @override
  String get words => 'mots';

  @override
  String get youAreNowPremium => 'Vous êtes désormais Premium !';
}
