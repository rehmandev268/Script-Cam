// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get about => 'Sobre';

  @override
  String get addOrSelectScriptPrompt =>
      'Adicione ou selecione um script para começar a gravar com sobreposição de teleprompter.';

  @override
  String get adjust => 'Ajustar';

  @override
  String get adNotAvailable => 'Anúncio indisponível';

  @override
  String get adNotAvailableDesc =>
      'Não foi possível carregar um anúncio. Tente novamente em alguns instantes.';

  @override
  String get adNotCompleted => 'Anúncio não concluído';

  @override
  String get adNotCompletedDesc =>
      'Assista ao anúncio completo para ganhar créditos de gravação.';

  @override
  String get all => 'Todos';

  @override
  String get allScriptsTitle => 'Todos os scripts';

  @override
  String get appearance => 'Aparência';

  @override
  String get appInfoDescription =>
      'A melhor ferramenta de teleprompter e gravação de vídeo para criadores de conteúdo. Crie, leia e grave sem interrupções.';

  @override
  String get appInfoTitle => 'ScriptCam';

  @override
  String get appTitle => 'ScriptCam';

  @override
  String get autoBackup => 'Backup automático';

  @override
  String get autoSync => 'Sincronização automática';

  @override
  String get backCamera => 'Voltar';

  @override
  String get background => 'Fundo';

  @override
  String backupFailedDetail(String error) {
    return 'Erro de backup: $error';
  }

  @override
  String get backupNow => 'Faça backup agora';

  @override
  String get backupVideos => 'Vídeos de backup';

  @override
  String bulkDeleteRecordingsTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Excluir $count gravações?',
      one: 'Excluir esta gravação?',
    );
    return '$_temp0';
  }

  @override
  String get cameraPreviewWithOverlay =>
      'Visualização da câmera com sobreposição de teleprompter ao vivo.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get close => 'Fechar';

  @override
  String get cloudBackup => 'Backup na nuvem';

  @override
  String get connected => 'Conectado';

  @override
  String get connectGoogleDrive => 'Conecte o Google Drive';

  @override
  String get connectionError =>
      'Erro de conexão. Verifique sua internet e tente novamente.';

  @override
  String get contactUs => 'Fale Conosco';

  @override
  String get continueButton => 'Continuar';

  @override
  String get couldNotLoadVideo => 'Não foi possível carregar o vídeo';

  @override
  String get countdownTimer => 'Temporizador de contagem regressiva';

  @override
  String get created => 'Criado!';

  @override
  String get createNewScript => 'Criar Novo Roteiro';

  @override
  String creditsRemaining(int count) {
    return 'Créditos $count';
  }

  @override
  String get cueCards => 'Cartões de dicas';

  @override
  String currentCreditsDescription(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Você tem $count gravações gratuitas restantes neste roteiro.',
      one: 'Você tem 1 gravação gratuita restante neste roteiro.',
    );
    return '$_temp0';
  }

  @override
  String get dark => 'Escuro';

  @override
  String get darkMode => 'Modo Escuro';

  @override
  String get defaultCamera => 'Câmera padrão';

  @override
  String get delete => 'Excluir';

  @override
  String get deleteScriptMessage => 'Esta ação não pode ser desfeita.';

  @override
  String get deleteScriptTitle => 'Excluir Roteiro?';

  @override
  String get deleteVideoTitle => 'Excluir Vídeo?';

  @override
  String get discard => 'Descartar';

  @override
  String get discardChanges => 'Descartar alterações?';

  @override
  String get discardChangesDesc => 'Suas edições serão perdidas.';

  @override
  String get disconnect => 'Desconectar';

  @override
  String get discountBadge => '20% DE DESCONTO';

  @override
  String get duplicate => 'Duplicado';

  @override
  String durationMinutesSecondsShort(int minutes, int seconds) {
    return '$minutes:$seconds';
  }

  @override
  String durationSecondsShort(int seconds) {
    return '${seconds}s';
  }

  @override
  String get earnRecordingCredits => 'Ganhe créditos de gravação';

  @override
  String get edit => 'Editar';

  @override
  String get editScript => 'Editar Roteiro';

  @override
  String get editScriptBlockedDuringCountdown =>
      'Aguarde o término da contagem regressiva antes de editar.';

  @override
  String get editScriptBlockedWhileRecording =>
      'Pare de gravar para editar seu script.';

  @override
  String get emptyCreativeSpaceMessage =>
      'Seu espaço criativo está vazio. Crie seu primeiro roteiro ou tente gravar algo na hora!';

  @override
  String get emptyGallery => 'Nenhum vídeo ainda';

  @override
  String get emptyGalleryDesc => 'Grave seu primeiro vídeo para vê-lo aqui';

  @override
  String errorSharingVideo(String error) {
    return 'Não foi possível compartilhar o vídeo: $error';
  }

  @override
  String exportedScriptSubject(String title) {
    return 'Script exportado: $title';
  }

  @override
  String get exportQuality => 'Qualidade de exportação';

  @override
  String get exportSuccess => 'Script exportado com sucesso';

  @override
  String get focusLine => 'Linha de foco';

  @override
  String get font => 'Fonte';

  @override
  String get fontSize => 'Tamanho da Fonte';

  @override
  String freeRecordingsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Restam $count gravações gratuitas',
      one: 'Resta 1 gravação gratuita',
    );
    return '$_temp0';
  }

  @override
  String get freeTrialCancelAnytime =>
      'A avaliação gratuita começa imediatamente. Cancele a qualquer momento antes da renovação.';

  @override
  String get frontCamera => 'Frente';

  @override
  String get fullDuration => 'Completo';

  @override
  String get general => 'Geral';

  @override
  String get getPremium => 'Obter Premium';

  @override
  String get googleUser => 'Usuário do Google';

  @override
  String get goPremium => 'Torne-se Premium';

  @override
  String get gotIt => 'Entendi';

  @override
  String get grantAccess => 'Conceder Acesso';

  @override
  String get help => 'Ajuda';

  @override
  String get highQualityVideo => 'Vídeo de alta qualidade';

  @override
  String get howToUse => 'Como Usar';

  @override
  String get howToUseTitle => 'Como Usar o ScriptCam';

  @override
  String get importScript => 'Importar';

  @override
  String get importSuccess => 'Script importado com sucesso';

  @override
  String itemsSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count selecionados',
      one: '1 selecionado',
    );
    return '$_temp0';
  }

  @override
  String get keepEditing => 'Continue editando';

  @override
  String get language => 'Idioma';

  @override
  String get lifetimeNoRecurringBilling =>
      'Desbloqueio vitalício. Sem cobrança recorrente.';

  @override
  String get lifetimeOneTimeUnlock =>
      'Compra única. Pague uma vez e desbloqueie para sempre.';

  @override
  String get lifetimePlan => 'Plano vitalício';

  @override
  String get lifetimePriceNotLoaded =>
      'Preço vitalício ainda não carregado na loja.';

  @override
  String get light => 'Claro';

  @override
  String get lightMode => 'Modo Claro';

  @override
  String get lineSpacing => 'Espaçamento entre linhas';

  @override
  String get loop => 'Laço';

  @override
  String get managePremiumStatus => 'Gerencie seu status premium';

  @override
  String get minRead => 'min de leitura';

  @override
  String get mirror => 'Espelhar';

  @override
  String get mute => 'Mudo';

  @override
  String get never => 'Nunca';

  @override
  String get newScript => 'Novo Roteiro';

  @override
  String get newScriptMultiline => 'Novo\nRoteiro';

  @override
  String get next => 'Próximo';

  @override
  String get noAds => 'Sem anúncios para sempre';

  @override
  String get noInternetDesc =>
      'Parece que você está offline. Verifique sua conexão e tente novamente.';

  @override
  String get noInternetError => 'Sem internet';

  @override
  String get noInternetErrorDesc => 'Conecte-se à Internet e tente novamente.';

  @override
  String get noInternetTitle => 'Sem conexão com a Internet';

  @override
  String get noRecordingsLeft =>
      'Não há mais gravações · Assista a um anúncio para continuar';

  @override
  String get noResultsFound => 'Nenhum resultado encontrado';

  @override
  String get noResultsMessage =>
      'Não conseguimos encontrar nenhum roteiro correspondente à sua busca. Tente palavras-chave diferentes!';

  @override
  String get noSavedScriptSelected => 'Nenhum script salvo selecionado';

  @override
  String get notAuthenticated => 'Não conectado ao Google.';

  @override
  String get off => 'Desligado';

  @override
  String get onboardingAccessCamera => 'Câmera';

  @override
  String get onboardingAccessMic => 'Microfone';

  @override
  String get onboardingInteractiveRecLabel => 'REC';

  @override
  String get onboardingInteractiveStep1Eyebrow => 'Vista principal';

  @override
  String get onboardingInteractiveStep1Preview =>
      'O script de sobreposição e o enquadramento permanecem visíveis juntos. Role para ensaiar; comece a gravar quando o ritmo parecer adequado.';

  @override
  String get onboardingInteractiveStep1Subtitle =>
      'O ScriptCam centra-se na captura. Roteiros, créditos e cenários permanecem acessíveis sem sobrecarregar o que você filma.';

  @override
  String get onboardingInteractiveStep1Title =>
      'Gravando primeiro espaço de trabalho';

  @override
  String get onboardingInteractiveStep2Sample =>
      'Bom dia, obrigado por estar aqui.\nManteremos isso breve e prático.\nSe você se afastar das lentes, acomode-se deliberadamente e siga em frente.';

  @override
  String get onboardingInteractiveStep2Subtitle =>
      'Pause o ensaio com um toque. Ajuste o ritmo de rolagem e o tamanho do texto na tela de gravação ao ensaiar ou filmar.';

  @override
  String get onboardingInteractiveStep2Title => 'Sobreposição de teleprompter';

  @override
  String get onboardingInteractiveStep4CardHint =>
      'Você pode alterá-los a qualquer momento nas configurações do Android ou iOS.';

  @override
  String get onboardingInteractiveStep4Subtitle =>
      'O ScriptCam precisa de câmera e microfone para que você possa se ver enquanto o roteiro fica sincronizado com o seu ritmo.';

  @override
  String get onboardingInteractiveStep4Title => 'Acesso à gravação';

  @override
  String get opacity => 'Opacidade';

  @override
  String get original => 'Original';

  @override
  String get overlaySettings => 'Configurações de sobreposição';

  @override
  String get paste => 'Colar';

  @override
  String get permissionsRequired =>
      'Permissões de câmera e microfone são necessárias.';

  @override
  String get preferences => 'Preferências';

  @override
  String get premium => 'Premium';

  @override
  String get premiumActive => 'Prêmio Ativo';

  @override
  String get premiumBenefitInstantRecord =>
      'Usuários premium obtêm gravação instantânea e sincronização de voz!';

  @override
  String get premiumDescription =>
      'Desbloqueie todos os recursos premium e desfrute de uma experiência sem anúncios';

  @override
  String get premiumUnlocked => 'Prémio desbloqueado!';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String get pro => 'PRO';

  @override
  String get processing => 'Processando...';

  @override
  String purchaseErrorDetail(String p0) {
    return 'Falha na compra: $p0';
  }

  @override
  String get purchaseFailedInitiate =>
      'Não foi possível iniciar a compra. Tente novamente.';

  @override
  String get qualityHigh => 'Alto';

  @override
  String get qualityLabel => 'Qualidade';

  @override
  String get qualityLow => 'Baixo';

  @override
  String get qualityStandard => 'Padrão';

  @override
  String get range => 'Alcance';

  @override
  String get rateUs => 'Avalie-nos';

  @override
  String get ratio => 'Proporção';

  @override
  String get recent => 'Recente';

  @override
  String get recordingFailed => 'Falha na gravação';

  @override
  String recordingsDeletedToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count gravações excluídas',
      one: '1 gravação excluída',
    );
    return '$_temp0';
  }

  @override
  String recordingsRemainingHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Restam $count gravações',
      one: 'Resta 1 gravação',
    );
    return '$_temp0 · Assista a um anúncio para obter mais';
  }

  @override
  String get recordNow => 'Grave agora';

  @override
  String get remoteControl => 'Controle remoto e teclado Bluetooth';

  @override
  String get remoteControlLocked =>
      'Controle remoto e teclado Bluetooth é um recurso premium';

  @override
  String get removeAds => 'Remover Anúncios';

  @override
  String get rename => 'Renomear';

  @override
  String get resolution => 'Resolução';

  @override
  String get restore => 'Restaurar';

  @override
  String get restoredSuccessfully => 'Compras restauradas com sucesso.';

  @override
  String restoreFailed(String error) {
    return 'Falha na restauração: $error';
  }

  @override
  String get restorePurchaseLink => 'Restaurar Compra';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get rewardGranted => 'Recompensa concedida: +3 gravações';

  @override
  String get rotate => 'Girar';

  @override
  String get save => 'SALVAR';

  @override
  String get saveButton => 'Salvar';

  @override
  String get saved => 'Salvo';

  @override
  String savedAs(String p0) {
    return 'Salvo como $p0';
  }

  @override
  String get saveEditorLabel => 'Salvar';

  @override
  String get saveFailed => 'Falha ao salvar';

  @override
  String get saveFailedEmpty => 'Nada para salvar';

  @override
  String get saveFailedGallery => 'Não foi possível salvar na galeria';

  @override
  String get saveFailedNotFound => 'Salvar local não encontrado';

  @override
  String get saveVideo => 'Salvar vídeo';

  @override
  String get savingEllipsis => 'Salvando…';

  @override
  String get scriptContentPlaceholder =>
      'Comece a escrever seu roteiro aqui...';

  @override
  String get scriptDeleted => 'Roteiro excluído';

  @override
  String scriptSummary(String p0, String p1) {
    return '$p0 · $p1';
  }

  @override
  String get scriptTitleHint => 'ex: Introdução do YouTube';

  @override
  String get scriptTitlePlaceholder => 'Título do Roteiro...';

  @override
  String get scrollSpeed => 'Velocidade de rolagem';

  @override
  String get searchScripts => 'Buscar roteiros...';

  @override
  String get selectedScriptReady => 'Script selecionado pronto';

  @override
  String get selectLanguage => 'Selecionar Idioma';

  @override
  String get selectLanguageDesc =>
      'Escolha seu idioma preferido para o aplicativo';

  @override
  String get selectPlatformDesc => 'Selecione uma plataforma para seu roteiro';

  @override
  String get settings => 'Configurações';

  @override
  String get shareApp => 'Compartilhar App';

  @override
  String shareAppMessage(String url) {
    return 'Grave vídeos profissionais com confiança usando ScriptCam! 🎥✨\n\nPossui um Teleprompter integrado, gravação em 4K e Editor de Vídeo. Experimente aqui:\n$url';
  }

  @override
  String get shareAppSubject => 'Confira o ScriptCam: Teleprompter de Vídeo';

  @override
  String get shareVideoSubject => 'Confira meu vídeo';

  @override
  String get shareVideoText => 'Vídeo gravado com ScriptCam';

  @override
  String get signInCancelled => 'O login foi cancelado.';

  @override
  String get softStart => 'Início suave';

  @override
  String get speed => 'Velocidade';

  @override
  String get speedFast => 'Rápido';

  @override
  String get speedNormal => 'Normal';

  @override
  String get speedSlow => 'Lento';

  @override
  String get speedTurbo => 'Turbo';

  @override
  String get startFreeTrial => 'Comece o teste gratuito';

  @override
  String get startRecording => 'Iniciar Gravação';

  @override
  String get startYourJourney => 'Comece Sua Jornada';

  @override
  String get step1Desc =>
      'Comece criando um novo roteiro ou gravação rápida sem texto';

  @override
  String get step1Title => 'Criar um Roteiro';

  @override
  String get step2Desc =>
      'Ajuste a velocidade, tamanho da fonte e ative a sincronização de voz para rolagem sem as mãos';

  @override
  String get step2Title => 'Configurar Teleprompter';

  @override
  String get step3Desc =>
      'Pressione gravar e leia seu roteiro enquanto olha para a câmera';

  @override
  String get step3Title => 'Grave Seu Vídeo';

  @override
  String get step4Desc =>
      'Use o editor de vídeo para cortar, ajustar e aplicar filtros antes de compartilhar';

  @override
  String get step4Title => 'Editar e Compartilhar';

  @override
  String get step5Desc =>
      'Use um controle remoto ou teclado Bluetooth para reproduzir, pausar e ajustar a velocidade de rolagem.';

  @override
  String get step5Title => 'Controle remoto';

  @override
  String get storePricingUnavailable =>
      'Preços da loja indisponíveis no momento.';

  @override
  String get storeUnavailable =>
      'A loja não está disponível. Tente novamente mais tarde.';

  @override
  String get stripView => 'Visualização de faixa';

  @override
  String get studioEditor => 'Editor de estúdio';

  @override
  String get support => 'Suporte';

  @override
  String get supportBody => 'Olá equipe ScriptCam,';

  @override
  String get supportSubject => 'Suporte para ScriptCam';

  @override
  String get switchAccount => 'Trocar de conta';

  @override
  String get system => 'Sistema';

  @override
  String get systemDefault => 'Padrão do Sistema';

  @override
  String get tabCamera => 'Câmera';

  @override
  String get tabRecordings => 'Gravações';

  @override
  String get tabScripts => 'Roteiros';

  @override
  String get targetFps => 'FPS Alvo';

  @override
  String get text => 'Texto';

  @override
  String get textPasted => 'Texto colado';

  @override
  String get titleRequired => 'Título obrigatório';

  @override
  String get transform => 'Transformar';

  @override
  String get trim => 'Cortar';

  @override
  String get unexpectedError => 'Algo deu errado';

  @override
  String get unexpectedErrorDesc =>
      'Algo deu errado. Por favor, tente novamente.';

  @override
  String get unlimitedRecordings => 'Gravações Ilimitadas';

  @override
  String get unlimitedScripts => 'Roteiros Ilimitados';

  @override
  String get unlockAllFeatures =>
      'Desbloqueie todos os recursos e remova anúncios';

  @override
  String get unlockCreatorPro => 'Desbloquear Creator Pro';

  @override
  String get untitledScript => 'Roteiro sem título';

  @override
  String get upgradeForLifetime => 'Atualizar para Acesso Vitalício';

  @override
  String get upgradeToPro => 'Atualizar para Pro';

  @override
  String get useASavedScript => 'Use um script salvo';

  @override
  String get version => 'Versão';

  @override
  String get videoDeleted => 'Vídeo excluído';

  @override
  String get videoFileNotFound => 'Arquivo de vídeo não encontrado';

  @override
  String get videoName => 'Nome do arquivo';

  @override
  String get videoNameHint => 'Meu vídeo';

  @override
  String get videoSettings => 'Configurações de Vídeo';

  @override
  String get voiceSync => 'Sincronização de Voz';

  @override
  String get voiceSyncFeature => 'Sincronização de voz';

  @override
  String get voiceSyncLocked => 'A sincronização de voz é um recurso premium';

  @override
  String get watchAdGetRecordings =>
      'Assistir 1 anúncio → Obtenha +3 gravações';

  @override
  String get watchAdToRecord => 'Assista ao anúncio para gravar';

  @override
  String get watchAdToRecordDesc =>
      'Assista a um pequeno anúncio para desbloquear a gravação deste script.';

  @override
  String get weeklyPlan => 'Semanalmente';

  @override
  String get weeklyPriceNotLoaded =>
      'Preço semanal ainda não carregado na loja.';

  @override
  String get weeklyTrialStorePrice =>
      'Teste gratuito de 3 dias, preço semanal na loja';

  @override
  String weeklyTrialThenPrice(String price) {
    return 'Teste gratuito de 3 dias, depois $price / semana';
  }

  @override
  String get whatAreYouRecording => 'O que você é\ngravando hoje?';

  @override
  String get width => 'Largura';

  @override
  String get widthFull => 'Completo';

  @override
  String get widthMedium => 'Médio';

  @override
  String get widthNarrow => 'Estreito';

  @override
  String get wifiOnly => 'Somente Wi-Fi';

  @override
  String wordCountShort(int count) {
    return '$count palavras';
  }

  @override
  String get words => 'palavras';

  @override
  String get youAreNowPremium => 'Agora você é Premium!';

  @override
  String get stopRecordingTitle => 'Parar gravação?';

  @override
  String get stopRecordingMessage =>
      'Sua gravação está pausada. Tem certeza que deseja sair? A gravação atual será descartada.';
}
