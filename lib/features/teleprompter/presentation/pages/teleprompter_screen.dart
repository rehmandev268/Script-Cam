import 'dart:math' as math;
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:camerawesome/pigeon.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/toast_service.dart';
import '../../../../core/services/voice_sync_service.dart';
import '../../../../core/utils/responsive_config.dart';
import '../../../scripts/data/models/script_model.dart';
import '../../../scripts/presentation/pages/editor_screen.dart';
import '../../../gallery/presentation/providers/gallery_provider.dart';
import '../../../gallery/presentation/pages/video_player_screen.dart';
import '../../../settings/presentation/providers/ui_provider.dart';
import '../../../../core/services/analytics_service.dart';
import '../../../premium/presentation/providers/premium_provider.dart';
import '../../../premium/presentation/screen/premium_screen.dart';

import '../widgets/camera_side_controls.dart';
import '../widgets/prompter_overlay.dart';
import '../widgets/camera_bottom_controls.dart';
import '../widgets/video_settings_sheet.dart';
import '../widgets/teleprompter_top_bar.dart';
import '../widgets/countdown_overlay.dart';
import '../widgets/ad_gate_overlay.dart';
import '../providers/recording_restriction_provider.dart';
import '../../../../core/services/connectivity_service.dart';
import '../../../../core/utils/app_dialogs.dart';

enum RecordingStatus { idle, recording, paused, finalized }

class TeleprompterScreen extends StatefulWidget {
  final Script script;
  const TeleprompterScreen({super.key, required this.script});

  @override
  State<TeleprompterScreen> createState() => _TeleprompterScreenState();
}

class _TeleprompterScreenState extends State<TeleprompterScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  RecordingStatus _recordingStatus = RecordingStatus.idle;
  Duration _accumulatedDuration = Duration.zero;
  DateTime? _startTimestamp;

  bool _showProControls = false;
  bool _isCountingDown = false;

  bool get _isRecording => _recordingStatus != RecordingStatus.idle;
  bool get _isPaused => _recordingStatus == RecordingStatus.paused;

  bool get _canOpenScriptEditor =>
      !_isCountingDown &&
      !_suspendCameraPipeline &&
      _recordingStatus == RecordingStatus.idle;

  VideoRecordingQuality _videoQuality = VideoRecordingQuality.fhd;
  int _targetFps = 30;
  double _currentBrightness = 0.0;
  double _currentZoom = 0.0;

  late final ValueNotifier<Duration> _recordingDuration;
  late final ValueNotifier<Duration> _readingDuration;
  DateTime? _readingStartTimestamp;
  late final ValueNotifier<Size> _prompterSize;
  late final ValueNotifier<double> _prompterOpacity;
  late final ValueNotifier<double> _fontSize;
  late final ValueNotifier<double> _scrollSpeed;
  late final ValueNotifier<int> _textOrientation;
  late final ValueNotifier<double> _lineSpacing;
  late final ValueNotifier<double> _scrollProgress;

  Ticker? _ticker;
  Duration _lastElapsed = Duration.zero;
  double _softStartRamp = 0.0; // 0→1 over ~2s when soft-start enabled
  late final VoiceSyncService _voiceSync;
  late final UIProvider _uiProvider;
  late final PremiumProvider _premiumProvider;
  late final RecordingRestrictionProvider _restrictionProvider;
  final ScrollController _scriptScrollController = ScrollController();
  late String _scriptContent;

  int _lastFoundIndex = 0;
  bool _isPlayingScript = false;
  bool _showScriptControls = true;
  bool _isOverlaySettingsSheetOpen = false;
  bool _adGateDismissed = false;
  /// Tears down [CameraAwesomeBuilder] so preview is released while editing on another route.
  bool _suspendCameraPipeline = false;
  late final ValueNotifier<Offset> _prompterPosition;
  bool _isPositionInitialized = false;
  String? _lastVideoPath;

  TextPainter? _cachedTextPainter;
  double? _cachedPainterWidth;
  double? _cachedPainterFontSize;
  double? _cachedPainterLineSpacing;

  /// Writable script binding (swaps after persisting from teleprompter-only editor flow).
  late Script _activeScript;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    _uiProvider = context.read<UIProvider>();
    _videoQuality = _mapQuality(_uiProvider.defaultExportQuality);

    _prompterOpacity = ValueNotifier(_uiProvider.prompterOpacity);
    _fontSize = ValueNotifier(_uiProvider.prompterFontSize);
    _scrollSpeed = ValueNotifier(_uiProvider.prompterScrollSpeed);
    _textOrientation = ValueNotifier(_uiProvider.prompterTextOrientation);
    _prompterSize = ValueNotifier(
      _uiProvider.prompterWidth > 0 && _uiProvider.prompterHeight > 0
          ? Size(_uiProvider.prompterWidth, _uiProvider.prompterHeight)
          : Size(double.infinity, 500.h),
    );
    _prompterPosition = ValueNotifier(
      Offset(_uiProvider.prompterX, _uiProvider.prompterY),
    );
    _recordingDuration = ValueNotifier(Duration.zero);
    _readingDuration = ValueNotifier(Duration.zero);
    _lineSpacing = ValueNotifier(_uiProvider.lineSpacing);
    _scrollProgress = ValueNotifier(0.0);

    // Add listeners to sync changes to UIProvider
    _prompterOpacity.addListener(
      () => _uiProvider.setPrompterOpacity(_prompterOpacity.value),
    );
    _fontSize.addListener(
      () => _uiProvider.setPrompterFontSize(_fontSize.value),
    );
    _scrollSpeed.addListener(
      () => _uiProvider.setPrompterScrollSpeed(_scrollSpeed.value),
    );
    _textOrientation.addListener(
      () => _uiProvider.setPrompterTextOrientation(_textOrientation.value),
    );
    _lineSpacing.addListener(
      () => _uiProvider.setLineSpacing(_lineSpacing.value),
    );
    _prompterSize.addListener(
      () => _uiProvider.setPrompterSize(
        _prompterSize.value.width,
        _prompterSize.value.height,
      ),
    );
    _prompterPosition.addListener(
      () => _uiProvider.setPrompterPosition(
        _prompterPosition.value.dx,
        _prompterPosition.value.dy,
      ),
    );

    _ticker = createTicker(_onTick);
    _voiceSync = context.read<VoiceSyncService>();
    _premiumProvider = context.read<PremiumProvider>();
    _restrictionProvider = context.read<RecordingRestrictionProvider>();
    _activeScript = widget.script;
    _scriptContent = _activeScript.content;
    _voiceSync.initialize();
    _uiProvider.addListener(_handleUIChanges);
    _voiceSync.addListener(_handleVoiceChanges);
    _premiumProvider.addListener(_handlePremiumChanges);
    _handlePremiumChanges();
  }

  void _handlePremiumChanges() {
    _restrictionProvider.updatePremiumStatus(_premiumProvider.isPremium);
  }

  @override
  void didUpdateWidget(covariant TeleprompterScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.script != widget.script &&
        !_suspendCameraPipeline &&
        !_isRecording &&
        !_isCountingDown) {
      _activeScript = widget.script;
      _scriptContent = _activeScript.content;
      _cachedTextPainter = null;
      _lastFoundIndex = 0;
    }
  }

  void _handleVoiceChanges() {
    final isPremium = context.read<PremiumProvider>().isPremium;
    if (!mounted ||
        !_isPlayingScript ||
        !_uiProvider.voiceSyncEnabled ||
        !isPremium) {
      return;
    }

    if (!_voiceSync.isListening &&
        !_isPaused &&
        _scriptScrollController.hasClients) {
      _voiceSync.startListening(_onVoiceResult);
    }
  }

  void _handleUIChanges() {
    if (!mounted || !_isPlayingScript) return;

    final isPremium = context.read<PremiumProvider>().isPremium;
    if (_uiProvider.voiceSyncEnabled && isPremium) {
      if (!_voiceSync.isListening) {
        _voiceSync.startListening(_onVoiceResult);
      }
    } else {
      if (_voiceSync.isListening) {
        _voiceSync.stopListening();
      }
    }
  }

  double _getYOffsetForIndex(int index) {
    if (!_scriptScrollController.hasClients) return 0.0;

    final horizontalPadding = 32.0.w;
    final maxWidth = math.max(
      100.0.w,
      _prompterSize.value.width - horizontalPadding,
    );
    final fs = _fontSize.value;
    final ls = _lineSpacing.value;

    if (_cachedTextPainter == null ||
        _cachedPainterWidth != maxWidth ||
        _cachedPainterFontSize != fs ||
        _cachedPainterLineSpacing != ls) {
      final textStyle = TextStyle(
        fontSize: fs,
        fontWeight: FontWeight.w700,
        height: ls,
      );

      _cachedTextPainter = TextPainter(
        text: TextSpan(text: _scriptContent, style: textStyle),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      _cachedTextPainter!.layout(maxWidth: maxWidth);
      _cachedPainterWidth = maxWidth;
      _cachedPainterFontSize = fs;
      _cachedPainterLineSpacing = ls;
    }

    final offset = _cachedTextPainter!.getOffsetForCaret(
      TextPosition(offset: index),
      Rect.fromLTWH(0, 0, 0, fs),
    );

    return offset.dy;
  }

  void _onVoiceResult(String words) {
    if (!mounted || !_isPlayingScript) return;

    final scriptContent = _scriptContent.toLowerCase();
    final cleanedScript = scriptContent.replaceAll(RegExp(r'[^\w\s]'), ' ');
    final trimmed = words.toLowerCase().trim();
    if (trimmed.isEmpty) return;

    final spokenWords = trimmed.split(RegExp(r'\s+'));

    // Use a smaller transcript tail for more immediate matching
    final transcriptTail = spokenWords.length > 8
        ? spokenWords.sublist(spokenWords.length - 8)
        : spokenWords;

    // SEARCH STRATEGY:
    // We look forward from our current position to ensure steady progress.
    // indexOf is used instead of lastIndexOf to find the NEAREST match,
    // which prevents the prompter from jumping deep into the script.
    const int lookAhead = 1500;
    const int lookBehind = 50; // Tiny look-behind to catch late recognition
    final int start = math.max(0, _lastFoundIndex - lookBehind);
    final int end = math.min(cleanedScript.length, _lastFoundIndex + lookAhead);
    final String window = cleanedScript.substring(start, end);

    int foundPos = -1;
    int phraseSize = 0;

    // 1. Precise Phrase Matching (3-4 words) - Strongest anchors
    for (int len = 4; len >= 3; len--) {
      if (transcriptTail.length < len) continue;

      // We check the most recent combinations of words
      for (int offset = 0; offset < 2; offset++) {
        int tEnd = transcriptTail.length - offset;
        int tStart = tEnd - len;
        if (tStart < 0) continue;

        final String phrase = transcriptTail.sublist(tStart, tEnd).join(' ');
        if (phrase.length < 6) continue;

        // Find the FIRST match in our look-ahead window
        final int pos = window.indexOf(phrase);
        if (pos != -1) {
          foundPos = pos + phrase.length;
          phraseSize = len;
          break;
        }
      }
      if (foundPos != -1) break;
    }

    // 2. Reliable word matching (2 words or long single word) - Fallback
    if (foundPos == -1) {
      // Bi-grams
      if (transcriptTail.length >= 2) {
        final phrase = transcriptTail
            .sublist(transcriptTail.length - 2)
            .join(' ');
        if (phrase.length > 8) {
          final int pos = window.indexOf(phrase);
          if (pos != -1) {
            foundPos = pos + phrase.length;
            phraseSize = 2;
          }
        }
      }

      // Long single word fallback
      if (foundPos == -1) {
        final lastWord = transcriptTail.last;
        if (lastWord.length > 6) {
          final int pos = window.indexOf(lastWord);
          if (pos != -1) {
            foundPos = pos + lastWord.length;
            phraseSize = 1;
          }
        }
      }
    }

    if (foundPos != -1) {
      final int absoluteIdx = start + foundPos;

      // Progress Guard: Don't jump ahead more than 800 chars in one go
      // unless it's a very confident multi-word match
      if (phraseSize < 3 && absoluteIdx > _lastFoundIndex + 800) return;

      _lastFoundIndex = absoluteIdx;

      final double containerH = _prompterSize.value.height;
      // Focus point at 25% height (upper region of the prompter)
      final double focusLineY = containerH * 0.25;
      final double charY = _getYOffsetForIndex(absoluteIdx);

      // Calculate scroll offset to bring charY to focusLineY
      // Initial state has containerH/2 padding
      final double targetOffset = (containerH / 2 + charY) - focusLineY;

      if (_scriptScrollController.hasClients) {
        final double current = _scriptScrollController.offset;
        final double diff = (targetOffset - current).abs();

        if (diff > 5) {
          // LONG DURATION + SMOOTH CURVE = Gliding feel, no jumping
          // Faster move for small adjustments, slower move for catching up
          final int duration = (diff * 1.2 + 900).toInt().clamp(900, 2500);

          _scriptScrollController.animateTo(
            targetOffset.clamp(
              0.0,
              _scriptScrollController.position.maxScrollExtent,
            ),
            duration: Duration(milliseconds: duration),
            curve: Curves.easeInOutCubic,
          );
        }
      }
    }
  }

  void _onTick(Duration elapsed) {
    if (!mounted) return;

    // 1. Update recording duration display based on status
    if (_recordingStatus == RecordingStatus.recording &&
        _startTimestamp != null) {
      final currentSegment = DateTime.now().difference(_startTimestamp!);
      _recordingDuration.value = _accumulatedDuration + currentSegment;
    } else if (_recordingStatus == RecordingStatus.paused) {
      _recordingDuration.value = _accumulatedDuration;
    } else if (_recordingStatus == RecordingStatus.idle) {
      _recordingDuration.value = Duration.zero;
    }

    // 2. Update reading timer when script is playing (not recording)
    if (_isPlayingScript && _readingStartTimestamp != null) {
      _readingDuration.value = DateTime.now().difference(_readingStartTimestamp!);
    }

    final isPremium = context.read<PremiumProvider>().isPremium;
    final voiceSyncActive = _uiProvider.voiceSyncEnabled && isPremium;
    final isActive =
        _isPlayingScript || (_recordingStatus == RecordingStatus.recording);
    if (!isActive) {
      _lastElapsed = Duration.zero;
      return;
    }
    if (_lastElapsed == Duration.zero) {
      _lastElapsed = elapsed;
      return;
    }
    final delta = (elapsed - _lastElapsed).inMicroseconds / 1000000.0;
    _lastElapsed = elapsed;

    if (_scriptScrollController.hasClients && _isPlayingScript) {
      final maxExt = _scriptScrollController.position.maxScrollExtent;
      if (maxExt > 0) {
        _scrollProgress.value = (_scriptScrollController.offset / maxExt).clamp(
          0.0,
          1.0,
        );
      }
      if (_scriptScrollController.offset >= maxExt) {
        if (_uiProvider.prompterLoopEnabled) {
          // Loop: jump back to top and keep playing
          HapticFeedback.lightImpact();
          _scriptScrollController.jumpTo(0);
          _lastFoundIndex = 0;
          _softStartRamp = _uiProvider.prompterSoftStartEnabled ? 0.0 : 1.0;
        } else {
          // End: haptic + stop
          HapticFeedback.heavyImpact();
          setState(() {
            _isPlayingScript = false;
            _lastFoundIndex = 0;
            _softStartRamp = 0.0;
          });
          _stopScrolling();
        }
      } else if (!voiceSyncActive) {
        // Soft-start ramp: increase from 0→1 over ~2 seconds
        if (_softStartRamp < 1.0) {
          _softStartRamp = (_softStartRamp + delta * 0.5).clamp(0.0, 1.0);
        }
        _scriptScrollController.jumpTo(
          _scriptScrollController.offset + (_scrollSpeed.value * delta * _softStartRamp),
        );
      }
    }
  }

  void _startScrolling() {
    final isPremium = context.read<PremiumProvider>().isPremium;
    if (_uiProvider.voiceSyncEnabled && isPremium) {
      _voiceSync.startListening(_onVoiceResult);
    }
    if (!(_ticker?.isActive ?? false)) _ticker?.start();
  }

  void _stopScrolling() {
    _voiceSync.stopListening();

    if (!_isRecording) {
      _ticker?.stop();
    }
    setState(() => _isPlayingScript = false);
  }

  void _toggleScriptPlay() {
    setState(() {
      _isPlayingScript = !_isPlayingScript;
      if (!_isPlayingScript) {
        _lastFoundIndex = 0;
        _readingStartTimestamp = null;
        _readingDuration.value = Duration.zero;
        _softStartRamp = 0.0;
      } else {
        _readingStartTimestamp = DateTime.now();
        _softStartRamp = _uiProvider.prompterSoftStartEnabled ? 0.0 : 1.0;
      }
    });
    if (_isPlayingScript) {
      _startScrolling();
    } else {
      _stopScrolling();
    }
  }

  Future<void> _openScriptEditorFromTeleprompter() async {
    // Blocks recording and paused paths (any non-idle capture state).
    if (_recordingStatus != RecordingStatus.idle) {
      ToastService.show(
        AppLocalizations.of(context).editScriptBlockedWhileRecording,
        isError: true,
      );
      return;
    }

    if (_suspendCameraPipeline) {
      return;
    }

    if (_isCountingDown) {
      ToastService.show(
        AppLocalizations.of(context).editScriptBlockedDuringCountdown,
        isError: true,
      );
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();
    if (_isPlayingScript) {
      _stopScrolling();
    }

    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    if (!mounted) return;

    setState(() => _suspendCameraPipeline = true);

    TeleprompterScriptEditResult? sessionResult;
    try {
      sessionResult =
          await Navigator.of(context).push<TeleprompterScriptEditResult?>(
        MaterialPageRoute(
          builder: (_) {
            if (_activeScript.isInBox) {
              return EditorScreen(scriptToEdit: _activeScript);
            }
            return EditorScreen(
              teleprompterInitialTitle: _activeScript.title,
              teleprompterInitialContent: _activeScript.content,
              saveReturnsToTeleprompterOnly: true,
            );
          },
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _suspendCameraPipeline = false;
          if (sessionResult != null) {
            if (sessionResult.persistedScript != null) {
              _activeScript = sessionResult.persistedScript!;
            } else if (sessionResult.title.isNotEmpty ||
                sessionResult.content.isNotEmpty) {
              _activeScript.title = sessionResult.title;
              _activeScript.content = sessionResult.content;
            }
          }
          _scriptContent = _activeScript.content;
          _cachedTextPainter = null;
          _lastFoundIndex = 0;
        });
      }
      if (mounted) {
        await SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: [],
        );
      }
    }
  }

  void _togglePause(VideoRecordingCameraState recordingState) async {
    if (recordingState.captureState == null) return;
    if (_recordingStatus == RecordingStatus.paused) {
      await recordingState.resumeRecording(recordingState.captureState!);
      setState(() {
        _recordingStatus = RecordingStatus.recording;
        _startTimestamp = DateTime.now();
        if (!_isPlayingScript) {
          _isPlayingScript = true;
          _startScrolling();
        }
      });
    } else if (_recordingStatus == RecordingStatus.recording) {
      await recordingState.pauseRecording(recordingState.captureState!);
      setState(() {
        if (_startTimestamp != null) {
          _accumulatedDuration += DateTime.now().difference(_startTimestamp!);
        }
        _recordingStatus = RecordingStatus.paused;
        _startTimestamp = null;
        _stopScrolling();
      });
    }
  }

  Future<CaptureRequest> _pathBuilder(List<Sensor> sensors) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = 'video_${DateTime.now().millisecondsSinceEpoch}.mp4';

    if (sensors.isEmpty) {
      // Fallback if no sensors detected
      return SingleCaptureRequest(
        '${appDir.path}/$fileName',
        Sensor.position(SensorPosition.front),
      );
    }

    return SingleCaptureRequest('${appDir.path}/$fileName', sensors.first);
  }

  VideoRecordingQuality _mapQuality(String quality) {
    switch (quality) {
      case 'sd':
        return VideoRecordingQuality.sd;
      case 'hd':
        return VideoRecordingQuality.hd;
      case 'uhd':
        return VideoRecordingQuality.uhd;
      case 'fhd':
      default:
        return VideoRecordingQuality.fhd;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isPositionInitialized) {
      if (_uiProvider.prompterWidth == 0 || _uiProvider.prompterHeight == 0) {
        final size = MediaQuery.of(context).size;
        final topSafe = MediaQuery.of(context).padding.top;
        final prompterWidth = size.width;
        final prompterHeight = size.height * 0.5;
        _prompterSize.value = Size(prompterWidth, prompterHeight);
        _prompterPosition.value = Offset(0, topSafe + 16.h);
      }
      _isPositionInitialized = true;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );

    _uiProvider.removeListener(_handleUIChanges);
    _voiceSync.removeListener(_handleVoiceChanges);
    _premiumProvider.removeListener(_handlePremiumChanges);
    _voiceSync.stopListening();
    _ticker?.dispose();
    _scriptScrollController.dispose();
    _prompterOpacity.dispose();
    _fontSize.dispose();
    _scrollSpeed.dispose();
    _textOrientation.dispose();
    _lineSpacing.dispose();
    _scrollProgress.dispose();
    _prompterSize.dispose();
    _prompterPosition.dispose();
    _recordingDuration.dispose();
    _readingDuration.dispose();
    super.dispose();
  }

  Offset _clampPrompterPosition(Offset proposed) {
    final media = MediaQuery.of(context);
    final screen = media.size;
    final size = _prompterSize.value;

    final minX = 0.0;
    final maxX = math.max(0.0, screen.width - size.width);

    // Allow reaching top corners while still keeping the overlay visible.
    final minY = 0.0;
    final maxY = math.max(
      minY,
      screen.height - size.height - media.padding.bottom - 8.h,
    );

    return Offset(
      proposed.dx.clamp(minX, maxX),
      proposed.dy.clamp(minY, maxY),
    );
  }

  void _onPrompterDrag(Offset delta) {
    _prompterPosition.value = _clampPrompterPosition(
      _prompterPosition.value + delta,
    );
  }

  void _onPrompterResize(Size nextSize) {
    _prompterSize.value = nextSize;
    _prompterPosition.value = _clampPrompterPosition(_prompterPosition.value);
  }

  Future<bool> _handleBack() async {
    // Actively recording — block back entirely
    if (_isRecording && !_isPaused) return false;

    // Paused — ask for confirmation
    if (_isPaused) {
      final l10n = AppLocalizations.of(context);
      final isDark = Theme.of(context).brightness == Brightness.dark;
      final confirmed = await AppDialogs.showConfirmDelete(
        context: context,
        isDark: isDark,
        title: l10n.stopRecordingTitle,
        content: l10n.stopRecordingMessage,
      );
      return confirmed;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final canPop = await _handleBack();
        if (canPop && context.mounted) Navigator.pop(context);
      },
      child: Focus(
      autofocus: false,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          final isPremium = context.read<PremiumProvider>().isPremium;
          if (!isPremium) {
            // Check if it's one of the control keys before showing toast
            final controlKeys = [
              LogicalKeyboardKey.space,
              LogicalKeyboardKey.arrowUp,
              LogicalKeyboardKey.arrowDown,
              LogicalKeyboardKey.keyR,
              LogicalKeyboardKey.audioVolumeUp,
              LogicalKeyboardKey.audioVolumeDown,
              LogicalKeyboardKey.mediaPlayPause,
              LogicalKeyboardKey.mediaPlay,
              LogicalKeyboardKey.mediaPause,
            ];
            if (controlKeys.contains(event.logicalKey)) {
              ToastService.show(AppLocalizations.of(context).remoteControlLocked);
              return KeyEventResult.handled;
            }
            return KeyEventResult.ignored;
          }

          if (event.logicalKey == LogicalKeyboardKey.space) {
            _toggleScriptPlay();
            return KeyEventResult.handled;
          } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
            _scrollSpeed.value = math.min(150.0, _scrollSpeed.value + 5.0);
            return KeyEventResult.handled;
          } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
            _scrollSpeed.value = math.max(10.0, _scrollSpeed.value - 5.0);
            return KeyEventResult.handled;
          } else if (event.logicalKey == LogicalKeyboardKey.keyR) {
            _scriptScrollController.jumpTo(0);
            return KeyEventResult.handled;
          } else if (event.logicalKey == LogicalKeyboardKey.audioVolumeUp ||
              event.logicalKey == LogicalKeyboardKey.audioVolumeDown ||
              event.logicalKey == LogicalKeyboardKey.mediaPlayPause ||
              event.logicalKey == LogicalKeyboardKey.mediaPlay ||
              event.logicalKey == LogicalKeyboardKey.mediaPause) {
            _toggleScriptPlay();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Consumer2<RecordingRestrictionProvider, PremiumProvider>(
          builder: (context, restrictionProvider, premiumProvider, child) {
            if (_suspendCameraPipeline) {
              return const DecoratedBox(
                decoration: BoxDecoration(color: Colors.black),
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              );
            }

            return CameraAwesomeBuilder.awesome(
              previewFit: CameraPreviewFit.cover,
              progressIndicator: const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
              saveConfig: SaveConfig.video(
                pathBuilder: _pathBuilder,
                mirrorFrontCamera: true,
                videoOptions: VideoOptions(
                  enableAudio: true,
                  quality: _videoQuality,
                ),
              ),
              sensorConfig: SensorConfig.single(
                sensor: Sensor.position(
                  _uiProvider.defaultFrontCamera
                      ? SensorPosition.front
                      : SensorPosition.back,
                ),
                aspectRatio: CameraAspectRatios.ratio_16_9,
              ),
              theme: AwesomeTheme(
                bottomActionsBackgroundColor: Colors.transparent,
                buttonTheme: AwesomeButtonTheme(
                  backgroundColor: Colors.transparent,
                  iconSize: 32,
                  foregroundColor: Colors.white,
                ),
              ),
              topActionsBuilder: (state) => const SizedBox.shrink(),
              bottomActionsBuilder: (state) => const SizedBox.shrink(),
              middleContentBuilder: (state) => const SizedBox.shrink(),
              previewDecoratorBuilder: (state, preview) => Stack(
                fit: StackFit.expand,
                children: [
                  ValueListenableBuilder<Offset>(
                    valueListenable: _prompterPosition,
                    builder: (context, position, _) {
                      return PrompterOverlay(
                        scriptContent: _scriptContent,
                        isPlayingScript: _isPlayingScript,
                        showScriptControls: _showScriptControls,
                        showSettingsPanel: _isOverlaySettingsSheetOpen,
                        dragX: position.dx,
                        dragY: position.dy,
                        prompterSize: _prompterSize,
                        prompterOpacity: _prompterOpacity,
                        fontSize: _fontSize,
                        textOrientation: _textOrientation,
                        scrollSpeed: _scrollSpeed,
                        lineSpacing: _lineSpacing,
                        scrollProgress: _scrollProgress,
                        scrollController: _scriptScrollController,
                        onTogglePlay: _toggleScriptPlay,
                        onEditScript: _canOpenScriptEditor
                            ? _openScriptEditorFromTeleprompter
                            : null,
                        onToggleSettings: _openOverlaySettingsSheet,
                        onToggleControls: () => setState(
                          () => _showScriptControls = !_showScriptControls,
                        ),
                        onDrag: _onPrompterDrag,
                        onResize: _onPrompterResize,
                        onTapPause: _isPlayingScript ? _stopScrolling : null,
                      );
                    },
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: IgnorePointer(
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(6.r),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.28),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white24),
                          ),
                          child: Icon(
                            Icons.remove_red_eye_outlined,
                            color: Colors.white70,
                            size: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (_showProControls && !_isRecording)
                    CameraSideControls(
                      state: state,
                      currentBrightness: _currentBrightness,
                      currentZoom: _currentZoom,
                      onBrightnessChanged: (v) =>
                          setState(() => _currentBrightness = v),
                      onZoomChanged: (v) => setState(() => _currentZoom = v),
                    ),

                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SafeArea(
                      child: ValueListenableBuilder<Duration>(
                        valueListenable: _recordingDuration,
                        builder: (context, duration, _) => Column(
                          children: [
                            ValueListenableBuilder<Duration>(
                              valueListenable: _readingDuration,
                              builder: (context, readDur, _) =>
                                  TeleprompterTopBar(
                                    state: state,
                                    isRecording: _isRecording,
                                    isReadingScript: _isPlayingScript && !_isRecording,
                                    recordingDuration: duration,
                                    readingDuration: readDur,
                                    onBack: () => Navigator.pop(context),
                                    onShowSettings: () => _showVideoSettings(state),
                                    formatDuration: (d) =>
                                        "${d.inMinutes.remainder(60).toString().padLeft(2, "0")}:${d.inSeconds.remainder(60).toString().padLeft(2, "0")}",
                                  ),
                            ),
                            if (!premiumProvider.isPremium && !_isRecording)
                              _buildRecordingCounter(restrictionProvider),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SafeArea(
                      child: CameraBottomControls(
                        state: state,
                        isRecording: _isRecording,
                        isPaused: _isPaused,
                        showProControls: _showProControls,
                        isEnabled: !restrictionProvider.isLimitReached,
                        recordingDuration: _recordingDuration,
                        onTogglePro: () => setState(
                          () => _showProControls = !_showProControls,
                        ),
                        onTogglePause: (s) => _togglePause(s),
                        onStartRecording: () {
                          if (restrictionProvider.isLimitReached) {
                            return;
                          }

                          if (state is VideoCameraState) {
                            if (_uiProvider.countdownDuration > 0) {
                              setState(() => _isCountingDown = true);
                            } else {
                              state.when(
                                onVideoMode: (videoState) =>
                                    videoState.startRecording(),
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  if (_isCountingDown)
                    CountdownOverlay(
                      duration: _uiProvider.countdownDuration,
                      onFinished: () {
                        setState(() => _isCountingDown = false);
                        state.when(
                          onVideoMode: (videoState) =>
                              videoState.startRecording(),
                        );
                      },
                    ),
                  if (_lastVideoPath != null && !_isRecording)
                    Positioned(
                      bottom: 120.h,
                      left: 24.w,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  FullScreenVideoPlayer(path: _lastVideoPath!),
                            ),
                          );
                        },
                        child: Container(
                          width: 60.w,
                          height: 80.h,
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.play_circle_fill,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (restrictionProvider.isLimitReached && !_adGateDismissed)
                    AdGateOverlay(
                      currentCredits: restrictionProvider.remainingRecordings,
                      isLoading: restrictionProvider.isLoading,
                      onWatchAd: () {
                        setState(() => _adGateDismissed = false);
                        _handleWatchAd(restrictionProvider);
                      },
                      onBuyPremium: _handleBuyPremium,
                      onClose: () => setState(() => _adGateDismissed = true),
                    ),
                ],
              ),
              onMediaCaptureEvent: (event) {
                switch (event.status) {
                  case MediaCaptureStatus.capturing:
                    if (_recordingStatus == RecordingStatus.idle) {
                      setState(() {
                        _recordingStatus = RecordingStatus.recording;
                        _accumulatedDuration = Duration.zero;
                        _startTimestamp = DateTime.now();
                        _lastFoundIndex = 0;
                        _recordingDuration.value = Duration.zero;
                      });
                      if (!(_ticker?.isActive ?? false)) _ticker?.start();
                      if (!_isPlayingScript) _toggleScriptPlay();
                      AnalyticsService().logRecordingStarted(
                        scriptId: _activeScript.key?.toString() ?? 'unknown',
                        scriptTitle: _activeScript.title,
                        isVoiceSyncEnabled:
                            _uiProvider.voiceSyncEnabled &&
                            premiumProvider.isPremium,
                      );
                    }
                    break;
                  case MediaCaptureStatus.success:
                    final path = event.captureRequest.path;
                    Duration finalDuration = _recordingDuration.value;
                    if (_recordingStatus == RecordingStatus.recording &&
                        _startTimestamp != null) {
                      finalDuration =
                          _accumulatedDuration +
                          DateTime.now().difference(_startTimestamp!);
                    } else if (_recordingStatus == RecordingStatus.paused) {
                      finalDuration = _accumulatedDuration;
                    }

                    setState(() {
                      _recordingStatus = RecordingStatus.idle;
                      _accumulatedDuration = Duration.zero;
                      _startTimestamp = null;
                      _lastVideoPath = path;
                    });
                    _stopScrolling();
                    AnalyticsService().logRecordingStopped(
                      scriptId: _activeScript.key?.toString() ?? 'unknown',
                      durationSeconds: finalDuration.inSeconds,
                    );
                    if (path != null && mounted) {
                      restrictionProvider.decrementRecordings();
                      context.read<GalleryProvider>().addVideo(path);
                      ToastService.show(AppLocalizations.of(context).saved);
                    }
                    break;
                  case MediaCaptureStatus.failure:
                    setState(() {
                      _recordingStatus = RecordingStatus.idle;
                      _accumulatedDuration = Duration.zero;
                      _startTimestamp = null;
                    });
                    _stopScrolling();
                    if (mounted) {
                      ToastService.show(
                        AppLocalizations.of(context).recordingFailed,
                        isError: true,
                      );
                    }
                    break;
                }
              },
            );
          },
        ),
      ),
    ),   // Focus
    );   // PopScope
  }

  Widget _buildRecordingCounter(RecordingRestrictionProvider provider) {
    final count = provider.remainingRecordings;
    final isWarning = count == 1;

    return Container(
      margin: EdgeInsets.only(top: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: isWarning
            ? AppColors.primary.withValues(alpha: 0.8)
            : Colors.black.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isWarning ? AppColors.primary : Colors.white24,
          width: 1,
        ),
      ),
      child: Text(
        AppLocalizations.of(context).freeRecordingsLeft(count),
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
          fontWeight: isWarning ? FontWeight.w800 : FontWeight.w600,
        ),
      ),
    );
  }

  void _handleWatchAd(RecordingRestrictionProvider provider) {
    final connectivity = context.read<ConnectivityService>();
    provider.watchAd(
      connectivity: connectivity,
      onRewardGranted: () {
        if (mounted) {
          setState(() => _adGateDismissed = false);
          ToastService.show(AppLocalizations.of(context).rewardGranted);
        }
      },
      onFailure: (titleKey, messageKey) {
        if (mounted) {
          _showErrorDialog(titleKey, messageKey, provider);
        }
      },
    );
  }

  void _showErrorDialog(
    String titleKey,
    String messageKey,
    RecordingRestrictionProvider provider,
  ) {
    showDialog(
      context: context,
      builder: (ctx) {
        final l10n = AppLocalizations.of(ctx);
        final title = _resolveKey(l10n, titleKey);
        final message = _resolveKey(l10n, messageKey);
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.cancel),
            ),
            if (titleKey != 'noInternetError')
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  _handleWatchAd(provider);
                },
                child: Text(l10n.retry),
              ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                _handleBuyPremium();
              },
              child: Text(l10n.goPremium),
            ),
          ],
        );
      },
    );
  }

  String _resolveKey(AppLocalizations l10n, String key) {
    switch (key) {
      case 'noInternetError':
        return l10n.noInternetError;
      case 'noInternetErrorDesc':
        return l10n.noInternetErrorDesc;
      case 'adNotAvailable':
        return l10n.adNotAvailable;
      case 'adNotAvailableDesc':
        return l10n.adNotAvailableDesc;
      case 'adNotCompleted':
        return l10n.adNotCompleted;
      case 'adNotCompletedDesc':
        return l10n.adNotCompletedDesc;
      case 'unexpectedError':
        return l10n.unexpectedError;
      case 'unexpectedErrorDesc':
        return l10n.unexpectedErrorDesc;
      default:
        return key;
    }
  }

  void _handleBuyPremium() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PremiumScreen()),
    );
  }

  void _showVideoSettings(CameraState state) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      useSafeArea: false,
      backgroundColor: Colors.transparent,
      builder: (_) => VideoSettingsSheet(
        state: state,
        videoQuality: _videoQuality,
        targetFps: _targetFps,
        countdownDuration: _uiProvider.countdownDuration,
        onQualityChanged: (q) => setState(() => _videoQuality = q),
        onFpsChanged: (f) => setState(() => _targetFps = f),
        onCountdownChanged: (d) => _uiProvider.setCountdownDuration(d),
      ),
    );
  }

  Future<void> _openOverlaySettingsSheet() async {
    if (_isOverlaySettingsSheetOpen) {
      Navigator.of(context, rootNavigator: true).maybePop();
      return;
    }

    setState(() => _isOverlaySettingsSheetOpen = true);

    await showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => PrompterSettingsSheet(
        fontSize: _fontSize,
        prompterOpacity: _prompterOpacity,
        scrollSpeed: _scrollSpeed,
        lineSpacing: _lineSpacing,
      ),
    );

    if (mounted) {
      setState(() => _isOverlaySettingsSheetOpen = false);
    }
  }
}
