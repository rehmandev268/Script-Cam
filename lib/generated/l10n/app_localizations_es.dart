// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get about => 'Acerca de';

  @override
  String get addOrSelectScriptPrompt =>
      'Agregue o seleccione un guión para comenzar a grabar con la superposición del teleprompter.';

  @override
  String get adjust => 'Ajustar';

  @override
  String get adNotAvailable => 'Anuncio no disponible';

  @override
  String get adNotAvailableDesc =>
      'No pudimos cargar un anuncio. Inténtalo de nuevo en un momento.';

  @override
  String get adNotCompleted => 'Anuncio no terminado';

  @override
  String get adNotCompletedDesc =>
      'Mire el anuncio completo para obtener créditos de grabación.';

  @override
  String get all => 'Todos';

  @override
  String get allScriptsTitle => 'Todos los guiones';

  @override
  String get appearance => 'Apariencia';

  @override
  String get appInfoDescription =>
      'La herramienta definitiva de teleprompter y grabación de video para creadores de contenido. Crea, lee y graba sin problemas.';

  @override
  String get appInfoTitle => 'ScriptCam';

  @override
  String get appTitle => 'ScriptCam';

  @override
  String get autoBackup => 'Copia de seguridad automática';

  @override
  String get autoSync => 'Sincronización automática';

  @override
  String get backCamera => 'Atrás';

  @override
  String get background => 'Fondo';

  @override
  String backupFailedDetail(String error) {
    return 'Error de copia de seguridad: $error';
  }

  @override
  String get backupNow => 'Copia de seguridad ahora';

  @override
  String get backupVideos => 'Vídeos de copia de seguridad';

  @override
  String bulkDeleteRecordingsTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '¿Eliminar $count grabaciones?',
      one: '¿Eliminar esta grabación?',
    );
    return '$_temp0';
  }

  @override
  String get cameraPreviewWithOverlay =>
      'Vista previa de la cámara con superposición de teleprompter en vivo.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get close => 'Cerrar';

  @override
  String get cloudBackup => 'Copia de seguridad en la nube';

  @override
  String get connected => 'Conectado';

  @override
  String get connectGoogleDrive => 'Conectar Google Drive';

  @override
  String get connectionError =>
      'Error de conexión. Comprueba tu Internet y vuelve a intentarlo.';

  @override
  String get contactUs => 'Contáctanos';

  @override
  String get continueButton => 'Continuar';

  @override
  String get couldNotLoadVideo => 'No se pudo cargar el video';

  @override
  String get countdownTimer => 'Temporizador de cuenta regresiva';

  @override
  String get created => '¡Creado!';

  @override
  String get createNewScript => 'Crear Nuevo Guion';

  @override
  String creditsRemaining(int count) {
    return 'Créditos $count';
  }

  @override
  String get cueCards => 'Tarjetas de referencia';

  @override
  String currentCreditsDescription(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Te quedan $count grabaciones gratis para este guion.',
      one: 'Te queda 1 grabación gratis para este guion.',
    );
    return '$_temp0';
  }

  @override
  String get dark => 'Oscuro';

  @override
  String get darkMode => 'Modo Oscuro';

  @override
  String get defaultCamera => 'Cámara predeterminada';

  @override
  String get delete => 'Eliminar';

  @override
  String get deleteScriptMessage => 'Esta acción no se puede deshacer.';

  @override
  String get deleteScriptTitle => '¿Eliminar Guion?';

  @override
  String get deleteVideoTitle => '¿Eliminar Video?';

  @override
  String get discard => 'Desechar';

  @override
  String get discardChanges => '¿Descartar cambios?';

  @override
  String get discardChangesDesc => 'Tus ediciones se perderán.';

  @override
  String get disconnect => 'Desconectar';

  @override
  String get discountBadge => '20% DE DESCUENTO';

  @override
  String get duplicate => 'Duplicado';

  @override
  String durationMinutesSecondsShort(int minutes, int seconds) {
    return '$minutes:$seconds';
  }

  @override
  String durationSecondsShort(int seconds) {
    return '$seconds s';
  }

  @override
  String get earnRecordingCredits => 'Gana créditos de grabación';

  @override
  String get edit => 'Editar';

  @override
  String get editScript => 'Editar Guion';

  @override
  String get editScriptBlockedDuringCountdown =>
      'Espere a que termine la cuenta regresiva antes de editar.';

  @override
  String get editScriptBlockedWhileRecording =>
      'Detén la grabación para editar tu guión.';

  @override
  String get emptyCreativeSpaceMessage =>
      'Tu espacio creativo está vacío. ¡Crea tu primer guion o intenta grabar algo sobre la marcha!';

  @override
  String get emptyGallery => 'Aún no hay videos';

  @override
  String get emptyGalleryDesc => 'Graba tu primer video para verlo aquí';

  @override
  String errorSharingVideo(String error) {
    return 'No se pudo compartir el video: $error';
  }

  @override
  String exportedScriptSubject(String title) {
    return 'Guión exportado: $title';
  }

  @override
  String get exportQuality => 'Calidad de exportación';

  @override
  String get exportSuccess => 'Script exportado exitosamente';

  @override
  String get focusLine => 'línea de enfoque';

  @override
  String get font => 'Fuente';

  @override
  String get fontSize => 'Tamaño de Fuente';

  @override
  String freeRecordingsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Quedan $count grabaciones gratis',
      one: 'Queda 1 grabación gratis',
    );
    return '$_temp0';
  }

  @override
  String get freeTrialCancelAnytime =>
      'La prueba gratuita comienza de inmediato. Cancele en cualquier momento antes de la renovación.';

  @override
  String get frontCamera => 'Frente';

  @override
  String get fullDuration => 'Lleno';

  @override
  String get general => 'General';

  @override
  String get getPremium => 'Obtener Premium';

  @override
  String get googleUser => 'Usuario de Google';

  @override
  String get goPremium => 'Ir Premium';

  @override
  String get gotIt => '¡Entendido!';

  @override
  String get grantAccess => 'Conceder Acceso';

  @override
  String get help => 'Ayuda';

  @override
  String get highQualityVideo => 'Vídeo de alta calidad';

  @override
  String get howToUse => 'Cómo Usar';

  @override
  String get howToUseTitle => 'Cómo Usar ScriptCam';

  @override
  String get importScript => 'Importar';

  @override
  String get importSuccess => 'Script importado exitosamente';

  @override
  String itemsSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count seleccionados',
      one: '1 seleccionado',
    );
    return '$_temp0';
  }

  @override
  String get keepEditing => 'Sigue editando';

  @override
  String get language => 'Idioma';

  @override
  String get lifetimeNoRecurringBilling =>
      'Desbloqueo de por vida. Sin facturación recurrente.';

  @override
  String get lifetimeOneTimeUnlock =>
      'Compra única. Paga una vez, desbloquea para siempre.';

  @override
  String get lifetimePlan => 'Plan de por vida';

  @override
  String get lifetimePriceNotLoaded =>
      'El precio de por vida aún no se ha cargado desde la tienda.';

  @override
  String get light => 'Claro';

  @override
  String get lightMode => 'Modo Claro';

  @override
  String get lineSpacing => 'Interlineado';

  @override
  String get loop => 'Bucle';

  @override
  String get managePremiumStatus => 'Gestiona tu estado premium';

  @override
  String get minRead => 'min de lectura';

  @override
  String get mirror => 'Espejo';

  @override
  String get mute => 'Silenciar';

  @override
  String get never => 'Nunca';

  @override
  String get newScript => 'Nuevo Guion';

  @override
  String get newScriptMultiline => 'Nuevo\nGuión';

  @override
  String get next => 'Siguiente';

  @override
  String get noAds => 'Sin anuncios para siempre';

  @override
  String get noInternetDesc =>
      'Parece que estás desconectado. Por favor verifique su conexión e inténtelo nuevamente.';

  @override
  String get noInternetError => 'sin internet';

  @override
  String get noInternetErrorDesc =>
      'Conéctese a Internet e inténtelo nuevamente.';

  @override
  String get noInternetTitle => 'Sin conexión a Internet';

  @override
  String get noRecordingsLeft =>
      'No quedan grabaciones · Mira un anuncio para continuar';

  @override
  String get noResultsFound => 'No se encontraron resultados';

  @override
  String get noResultsMessage =>
      'No pudimos encontrar ningún guion que coincida con tu búsqueda. ¡Prueba con palabras clave diferentes!';

  @override
  String get noSavedScriptSelected =>
      'No se ha seleccionado ningún script guardado';

  @override
  String get notAuthenticated => 'No has iniciado sesión en Google.';

  @override
  String get off => 'Apagado';

  @override
  String get onboardingAccessCamera => 'Cámara';

  @override
  String get onboardingAccessMic => 'Micrófono';

  @override
  String get onboardingInteractiveRecLabel => 'REC';

  @override
  String get onboardingInteractiveStep1Eyebrow => 'Vista principal';

  @override
  String get onboardingInteractiveStep1Preview =>
      'El guión superpuesto y el marco permanecen visibles juntos. Desplácese para ensayar; comience a grabar cuando el ritmo le parezca adecuado.';

  @override
  String get onboardingInteractiveStep1Subtitle =>
      'ScriptCam se centra en la captura. Los guiones, créditos y escenarios permanecen accesibles sin saturar lo que filmas.';

  @override
  String get onboardingInteractiveStep1Title =>
      'Espacio de trabajo para grabar primero';

  @override
  String get onboardingInteractiveStep2Sample =>
      'Buenos días, gracias por estar aquí.\nMantendremos esto breve y práctico.\nSi te alejas de la lente, recuéstate deliberadamente y continúa.';

  @override
  String get onboardingInteractiveStep2Subtitle =>
      'Pausa el ensayo con un toque. Ajusta el ritmo de desplazamiento y el tamaño del texto desde la pantalla de grabación cuando ensayes o grabes.';

  @override
  String get onboardingInteractiveStep2Title => 'Superposición de teleprompter';

  @override
  String get onboardingInteractiveStep4CardHint =>
      'Puedes cambiarlos en cualquier momento en la configuración de Android o iOS.';

  @override
  String get onboardingInteractiveStep4Subtitle =>
      'ScriptCam necesita una cámara y un micrófono para que puedas verte a ti mismo mientras el guión se mantiene sincronizado con tu ritmo.';

  @override
  String get onboardingInteractiveStep4Title => 'Acceso a grabación';

  @override
  String get opacity => 'Opacidad';

  @override
  String get original => 'Original';

  @override
  String get overlaySettings => 'Configuración de superposición';

  @override
  String get paste => 'Pegar';

  @override
  String get permissionsRequired =>
      'Se requieren permisos de cámara y micrófono.';

  @override
  String get preferences => 'Preferencias';

  @override
  String get premium => 'Premium';

  @override
  String get premiumActive => 'Premium Activo';

  @override
  String get premiumBenefitInstantRecord =>
      '¡Los usuarios Premium obtienen grabación instantánea y sincronización de voz!';

  @override
  String get premiumDescription =>
      'Desbloquea todas las funciones premium y disfruta de una experiencia sin anuncios';

  @override
  String get premiumUnlocked => '¡Prima desbloqueada!';

  @override
  String get privacyPolicy => 'Política de Privacidad';

  @override
  String get pro => 'PRO';

  @override
  String get processing => 'Procesando...';

  @override
  String purchaseErrorDetail(String p0) {
    return 'Compra fallida: $p0';
  }

  @override
  String get purchaseFailedInitiate =>
      'No se pudo iniciar la compra. Intentar otra vez.';

  @override
  String get qualityHigh => 'Alto';

  @override
  String get qualityLabel => 'Calidad';

  @override
  String get qualityLow => 'Bajo';

  @override
  String get qualityStandard => 'Estándar';

  @override
  String get range => 'Rango';

  @override
  String get rateUs => 'Califícanos';

  @override
  String get ratio => 'Relación';

  @override
  String get recent => 'Reciente';

  @override
  String get recordingFailed => 'La grabación falló';

  @override
  String recordingsDeletedToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count grabaciones eliminadas',
      one: '1 grabación eliminada',
    );
    return '$_temp0';
  }

  @override
  String recordingsRemainingHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Quedan $count grabaciones',
      one: 'Queda 1 grabación',
    );
    return '$_temp0 · Mira un anuncio para obtener más';
  }

  @override
  String get recordNow => 'Grabar ahora';

  @override
  String get remoteControl => 'Control remoto y teclado Bluetooth';

  @override
  String get remoteControlLocked =>
      'El control remoto y el teclado Bluetooth son una característica premium';

  @override
  String get removeAds => 'Eliminar Anuncios';

  @override
  String get rename => 'Rebautizar';

  @override
  String get resolution => 'Resolución';

  @override
  String get restore => 'Restaurar';

  @override
  String get restoredSuccessfully => 'Las compras se restauraron con éxito.';

  @override
  String restoreFailed(String error) {
    return 'Error de restauración: $error';
  }

  @override
  String get restorePurchaseLink => 'Restaurar Compra';

  @override
  String get retry => 'Rever';

  @override
  String get rewardGranted => 'Recompensa concedida: +3 grabaciones';

  @override
  String get rotate => 'Rotar';

  @override
  String get save => 'GUARDAR';

  @override
  String get saveButton => 'Ahorrar';

  @override
  String get saved => 'Guardado';

  @override
  String savedAs(String p0) {
    return 'Guardado como $p0';
  }

  @override
  String get saveEditorLabel => 'Ahorrar';

  @override
  String get saveFailed => 'Error al guardar';

  @override
  String get saveFailedEmpty => 'Nada que salvar';

  @override
  String get saveFailedGallery => 'No se pudo guardar en la galería';

  @override
  String get saveFailedNotFound => 'Guardar ubicación no encontrada';

  @override
  String get saveVideo => 'guardar vídeo';

  @override
  String get savingEllipsis => 'Ahorro…';

  @override
  String get scriptContentPlaceholder => 'Empieza a escribir tu guion aquí...';

  @override
  String get scriptDeleted => 'Guion eliminado';

  @override
  String scriptSummary(String p0, String p1) {
    return '$p0 · $p1';
  }

  @override
  String get scriptTitleHint => 'ej. Intro de YouTube';

  @override
  String get scriptTitlePlaceholder => 'Título del Guion...';

  @override
  String get scrollSpeed => 'Velocidad de desplazamiento';

  @override
  String get searchScripts => 'Buscar guiones...';

  @override
  String get selectedScriptReady => 'Guión seleccionado listo';

  @override
  String get selectLanguage => 'Seleccionar Idioma';

  @override
  String get selectLanguageDesc =>
      'Elige tu idioma preferido para la aplicación';

  @override
  String get selectPlatformDesc => 'Selecciona una plataforma para tu guion';

  @override
  String get settings => 'Configuración';

  @override
  String get shareApp => 'Compartir App';

  @override
  String shareAppMessage(String url) {
    return '¡Graba videos profesionales con confianza usando ScriptCam! 🎥✨\n\nCuenta con un Teleprompter integrado, grabación 4K y Editor de Video. Pruébalo aquí:\n$url';
  }

  @override
  String get shareAppSubject =>
      'Echa un vistazo a ScriptCam: Video Teleprompter';

  @override
  String get shareVideoSubject => 'Mira mi vídeo';

  @override
  String get shareVideoText => 'Vídeo grabado con ScriptCam';

  @override
  String get signInCancelled => 'El inicio de sesión fue cancelado.';

  @override
  String get softStart => 'Arranque suave';

  @override
  String get speed => 'Velocidad';

  @override
  String get speedFast => 'Rápido';

  @override
  String get speedNormal => 'Normal';

  @override
  String get speedSlow => 'Lento';

  @override
  String get speedTurbo => 'Turbo';

  @override
  String get startFreeTrial => 'Iniciar prueba gratuita';

  @override
  String get startRecording => 'Iniciar Grabación';

  @override
  String get startYourJourney => 'Comienza Tu Viaje';

  @override
  String get step1Desc =>
      'Empieza creando un nuevo guion o grabación rápida sin texto';

  @override
  String get step1Title => 'Crear un Guion';

  @override
  String get step2Desc =>
      'Ajusta la velocidad, el tamaño de la fuente y habilita la sincronización de voz para el desplazamiento manos libres';

  @override
  String get step2Title => 'Configurar Teleprompter';

  @override
  String get step3Desc =>
      'Presiona grabar y lee tu guion mientras miras a la cámara';

  @override
  String get step3Title => 'Graba Tu Video';

  @override
  String get step4Desc =>
      'Usa el editor de video para recortar, ajustar y aplicar filtros antes de compartir';

  @override
  String get step4Title => 'Editar y Compartir';

  @override
  String get step5Desc =>
      'Utilice un control remoto o un teclado Bluetooth para reproducir, pausar y ajustar la velocidad de desplazamiento.';

  @override
  String get step5Title => 'Mando a distancia';

  @override
  String get storePricingUnavailable =>
      'Los precios de la tienda no están disponibles en este momento.';

  @override
  String get storeUnavailable =>
      'La tienda no está disponible. Vuelve a intentarlo más tarde.';

  @override
  String get stripView => 'Vista de franja';

  @override
  String get studioEditor => 'Editor de estudio';

  @override
  String get support => 'Soporte';

  @override
  String get supportBody => 'Hola equipo de ScriptCam,';

  @override
  String get supportSubject => 'Soporte de ScriptCam';

  @override
  String get switchAccount => 'Cambiar de cuenta';

  @override
  String get system => 'Sistema';

  @override
  String get systemDefault => 'Predeterminado del sistema';

  @override
  String get tabCamera => 'Cámara';

  @override
  String get tabRecordings => 'Grabaciones';

  @override
  String get tabScripts => 'Guiones';

  @override
  String get targetFps => 'FPS Objetivo';

  @override
  String get text => 'Texto';

  @override
  String get textPasted => 'Texto pegado';

  @override
  String get titleRequired => 'Título requerido';

  @override
  String get transform => 'Transformar';

  @override
  String get trim => 'Recortar';

  @override
  String get unexpectedError => 'algo salió mal';

  @override
  String get unexpectedErrorDesc =>
      'Algo salió mal. Por favor inténtalo de nuevo.';

  @override
  String get unlimitedRecordings => 'Grabaciones ilimitadas';

  @override
  String get unlimitedScripts => 'Guiones Ilimitados';

  @override
  String get unlockAllFeatures =>
      'Desbloquea todas las funciones y elimina anuncios';

  @override
  String get unlockCreatorPro => 'Desbloquear Creator Pro';

  @override
  String get untitledScript => 'Guión sin título';

  @override
  String get upgradeForLifetime => 'Actualizar para Acceso de Por Vida';

  @override
  String get upgradeToPro => 'Actualizar a Pro';

  @override
  String get useASavedScript => 'Utilice un script guardado';

  @override
  String get version => 'Versión';

  @override
  String get videoDeleted => 'Video eliminado';

  @override
  String get videoFileNotFound => 'Archivo de vídeo no encontrado';

  @override
  String get videoName => 'Nombre del archivo';

  @override
  String get videoNameHint => 'Mi vídeo';

  @override
  String get videoSettings => 'Configuración de Video';

  @override
  String get voiceSync => 'Sincronización de Voz';

  @override
  String get voiceSyncFeature => 'Sincronización de voz';

  @override
  String get voiceSyncLocked =>
      'La sincronización de voz es una función premium';

  @override
  String get watchAdGetRecordings => 'Ver 1 anuncio → Obtener +3 grabaciones';

  @override
  String get watchAdToRecord => 'Ver anuncio para grabar';

  @override
  String get watchAdToRecordDesc =>
      'Mire un anuncio breve para desbloquear la grabación de este guión.';

  @override
  String get weeklyPlan => 'Semanalmente';

  @override
  String get weeklyPriceNotLoaded =>
      'Precio semanal aún no cargado desde la tienda.';

  @override
  String get weeklyTrialStorePrice =>
      'Prueba gratuita de 3 días, precio semanal en la tienda';

  @override
  String weeklyTrialThenPrice(String price) {
    return 'Prueba gratuita de 3 días y luego $price por semana';
  }

  @override
  String get whatAreYouRecording => '¿Qué eres?\ngrabando hoy?';

  @override
  String get width => 'Ancho';

  @override
  String get widthFull => 'Lleno';

  @override
  String get widthMedium => 'Medio';

  @override
  String get widthNarrow => 'Angosto';

  @override
  String get wifiOnly => 'Solo Wi-Fi';

  @override
  String wordCountShort(int count) {
    return '$count palabras';
  }

  @override
  String get words => 'palabras';

  @override
  String get youAreNowPremium => '¡Ahora eres Premium!';
}
