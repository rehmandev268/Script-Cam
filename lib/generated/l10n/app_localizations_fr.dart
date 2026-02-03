// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'ScriptCam';

  @override
  String get onboardingWelcomeTitle => 'Bienvenue sur ScriptCam';

  @override
  String get onboardingWelcomeDesc =>
      'Votre studio de téléprompteur tout-en-un. Écrivez des scripts, enregistrez des vidéos et éditez facilement.';

  @override
  String get onboardingScriptEditorTitle => 'Éditeur de Script';

  @override
  String get onboardingScriptEditorDesc =>
      'Écrivez et gérez vos scripts vidéo facilement. Organisez vos idées instantanément.';

  @override
  String get onboardingTeleprompterTitle => 'Téléprompteur';

  @override
  String get onboardingTeleprompterDesc =>
      'Lisez votre script en regardant directement la caméra. L\'enregistrement professionnel simplifié.';

  @override
  String get onboardingPermissionsTitle => 'Activer les Autorisations';

  @override
  String get onboardingPermissionsDesc =>
      'Pour enregistrer des vidéos et synchroniser votre voix avec le script, nous avons besoin d\'accéder à votre caméra et votre microphone.';

  @override
  String get grantAccess => 'Autoriser l\'Accès';

  @override
  String get start => 'Démarrer';

  @override
  String get next => 'Suivant';

  @override
  String get permissionsRequired =>
      'Les autorisations Caméra et Microphone sont requises.';

  @override
  String get selectLanguage => 'Choisir la Langue';

  @override
  String get selectLanguageDesc =>
      'Choisissez votre langue préférée pour l\'application';

  @override
  String get continueButton => 'Continuer';

  @override
  String get settings => 'Paramètres';

  @override
  String get preferences => 'Préférences';

  @override
  String get help => 'Aide';

  @override
  String get support => 'Support';

  @override
  String get about => 'À Propos';

  @override
  String get appearance => 'Apparence';

  @override
  String get language => 'Langue';

  @override
  String get systemDefault => 'Défaut Système';

  @override
  String get lightMode => 'Mode Clair';

  @override
  String get darkMode => 'Mode Sombre';

  @override
  String get system => 'Système';

  @override
  String get light => 'Clair';

  @override
  String get dark => 'Sombre';

  @override
  String get howToUse => 'Comment Utiliser';

  @override
  String get shareApp => 'Partager l\'App';

  @override
  String get contactUs => 'Contactez-nous';

  @override
  String get rateUs => 'Notez-nous';

  @override
  String get privacyPolicy => 'Politique de Confidentialité';

  @override
  String get version => 'Version';

  @override
  String get upgradeToPro => 'Passer à Pro';

  @override
  String get unlockAllFeatures => 'Débloquez tout et supprimez les pubs';

  @override
  String shareAppMessage(String url) {
    return 'Enregistrez des vidéos professionnelles avec ScriptCam ! 🎥✨\n\nAvec Téléprompteur intégré, enregistrement 4K et Éditeur Vidéo. Essayez ici :\n$url';
  }

  @override
  String get shareAppSubject => 'Découvrez ScriptCam : Téléprompteur Vidéo';

  @override
  String get goodMorning => 'Bonjour';

  @override
  String get goodAfternoon => 'Bon Après-midi';

  @override
  String get goodEvening => 'Bonsoir';

  @override
  String get readyToCreate => 'Prêt à créer quelque chose d\'incroyable ?';

  @override
  String get newScript => 'Nouveau Script';

  @override
  String get writeFromScratch => 'Écrire depuis zéro';

  @override
  String get quickRecord => 'Enregistrement Rapide';

  @override
  String get recordOnTheFly => 'Enregistrer à la volée';

  @override
  String get myScripts => 'Mes Scripts';

  @override
  String get recentFirst => 'Récents d\'abord';

  @override
  String get quickRecordDialogTitle => 'Enregistrement Rapide';

  @override
  String get quickRecordDialogDesc =>
      'Entrez les détails du script ci-dessous ou passez pour ouvrir la caméra sans texte.';

  @override
  String get scriptTitle => 'Titre du Script';

  @override
  String get scriptContent => 'Contenu du Script';

  @override
  String get scriptTitleHint => 'ex. Intro YouTube';

  @override
  String get scriptContentHint => 'Collez le contenu de votre script ici...';

  @override
  String get startRecording => 'Commencer l\'Enregistrement';

  @override
  String get editScript => 'Modifier le Script';

  @override
  String get save => 'ENREGISTRER';

  @override
  String get scriptTitlePlaceholder => 'Titre du Script...';

  @override
  String get scriptContentPlaceholder =>
      'Commencez à écrire votre script ici...';

  @override
  String get platform => 'PLATEFORME';

  @override
  String get titleRequired => 'Titre requis';

  @override
  String get saved => 'Enregistré';

  @override
  String get created => 'Créé !';

  @override
  String get textPasted => 'Texte collé';

  @override
  String get scriptDeleted => 'Script supprimé';

  @override
  String get deleteScriptTitle => 'Supprimer le Script ?';

  @override
  String get deleteScriptMessage => 'Cette action est irréversible.';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get appInfoTitle => 'ScriptCam';

  @override
  String get appInfoVersion => 'Version 1.0.3';

  @override
  String get appInfoDescription =>
      'L\'outil ultime de téléprompteur et d\'enregistrement vidéo pour les créateurs. Créez, lisez et enregistrez sans interruption.';

  @override
  String get close => 'Fermer';

  @override
  String get emptyScriptsAll => 'Pas de scripts';

  @override
  String get emptyScriptsAllDesc => 'Créez votre premier script pour commencer';

  @override
  String emptyScriptsCategory(String category) {
    return 'Aucun script $category';
  }

  @override
  String get emptyScriptsCategoryDesc =>
      'Créez un script pour cette plateforme';

  @override
  String get gallery => 'Galerie';

  @override
  String get emptyGallery => 'Pas de vidéos';

  @override
  String get emptyGalleryDesc =>
      'Enregistrez votre première vidéo pour la voir ici';

  @override
  String get teleprompter => 'Téléprompteur';

  @override
  String get record => 'Enregistrer';

  @override
  String get stop => 'Arrêter';

  @override
  String get pause => 'Pause';

  @override
  String get resume => 'Reprendre';

  @override
  String get speed => 'Vitesse';

  @override
  String get fontSize => 'Taille Police';

  @override
  String get mirror => 'Miroir';

  @override
  String get voiceSync => 'Synchro Vocale';

  @override
  String get autoScroll => 'Défilement Auto';

  @override
  String get videoSettings => 'Réglages Vidéo';

  @override
  String get resolution => 'Résolution';

  @override
  String get quality => 'Qualité';

  @override
  String get premium => 'Premium';

  @override
  String get getPremium => 'Obtenir Premium';

  @override
  String get restorePurchases => 'Restaurer les Achats';

  @override
  String get videoEditor => 'Éditeur Vidéo';

  @override
  String get trim => 'Rogner';

  @override
  String get adjust => 'Ajuster';

  @override
  String get filters => 'Filtres';

  @override
  String get export => 'Exporter';

  @override
  String get exporting => 'Exportation...';

  @override
  String get exportComplete => 'Exportation terminée !';

  @override
  String get brightness => 'Luminosité';

  @override
  String get contrast => 'Contraste';

  @override
  String get saturation => 'Saturation';

  @override
  String get share => 'Partager';

  @override
  String get play => 'Lire';

  @override
  String get all => 'Tout';

  @override
  String get general => 'Général';

  @override
  String get search => 'Rechercher';

  @override
  String get searchScripts => 'Rechercher des scripts...';

  @override
  String get studio => 'Studio';

  @override
  String get startYourJourney => 'Commencez Votre Aventure';

  @override
  String get noResultsFound => 'Aucun résultat trouvé';

  @override
  String get noResultsMessage =>
      'Nous n\'avons trouvé aucun script correspondant à votre recherche. Essayez d\'autres mots-clés !';

  @override
  String get emptyCreativeSpaceMessage =>
      'Votre espace créatif est vide. Créez votre premier script ou essayez d\'enregistrer quelque chose à la volée !';

  @override
  String get paste => 'Coller';

  @override
  String get createNewScript => 'Créer Nouveau Script';

  @override
  String get selectPlatformDesc =>
      'Sélectionnez une plateforme pour votre script';

  @override
  String get pro => 'PRO';

  @override
  String get minRead => 'min de lecture';

  @override
  String get words => 'mots';

  @override
  String get edit => 'Modifier';

  @override
  String get howToUseTitle => 'Comment Utiliser ScriptCam';

  @override
  String get step1Title => 'Créer un Script';

  @override
  String get step1Desc =>
      'Commencez par créer un nouveau script ou un enregistrement rapide sans texte';

  @override
  String get step2Title => 'Configurer le Téléprompteur';

  @override
  String get step2Desc =>
      'Ajustez la vitesse, la taille de la police et activez la synchronisation vocale pour le défilement mains libres';

  @override
  String get step3Title => 'Enregistrez Votre Vidéo';

  @override
  String get step3Desc =>
      'Appuyez sur enregistrer et lisez votre script en regardant la caméra';

  @override
  String get step4Title => 'Éditer et Partager';

  @override
  String get step4Desc =>
      'Utilisez l\'éditeur vidéo pour rogner, ajuster et appliquer des filtres avant de partager';

  @override
  String get gotIt => 'Compris';

  @override
  String get deleteVideoTitle => 'Supprimer la Vidéo ?';

  @override
  String get videoDeleted => 'Vidéo supprimée';

  @override
  String get mute => 'Muet';

  @override
  String get opacity => 'Opacité';

  @override
  String get original => 'Original';

  @override
  String get processing => 'Traitement...';

  @override
  String get range => 'Plage';

  @override
  String get ratio => 'Ratio';

  @override
  String get recordingFailed => 'Échec de l\'enregistrement';

  @override
  String get rotate => 'Pivoter';

  @override
  String get targetFps => 'FPS Cible';

  @override
  String get transform => 'Transformer';

  @override
  String get premiumDescription =>
      'Débloquez toutes les fonctionnalités premium et profitez d\'une expérience sans publicité';

  @override
  String get removeAds => 'Supprimer les Pubs';

  @override
  String get unlimitedScripts => 'Scripts Illimités';

  @override
  String get unlockCreatorPro => 'Débloquer Creator Pro';

  @override
  String get upgradeForLifetime => 'Mise à niveau pour un accès à vie';

  @override
  String get restorePurchaseLink => 'Restaurer l\'achat';

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
