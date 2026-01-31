import 'dart:math' as math;
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:camerawesome/pigeon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/toast_service.dart';
import '../../../../core/services/voice_sync_service.dart';
import '../../../../core/utils/responsive_config.dart';
import '../../../scripts/data/models/script_model.dart';
import '../../../gallery/presentation/providers/gallery_provider.dart';
import '../../../gallery/presentation/pages/video_player_screen.dart';
import '../../../settings/presentation/providers/ui_provider.dart';
import '../../../../core/services/analytics_service.dart';

import '../widgets/camera_side_controls.dart';
import '../widgets/prompter_overlay.dart';
import '../widgets/camera_bottom_controls.dart';
import '../widgets/video_settings_sheet.dart';
import '../widgets/teleprompter_top_bar.dart';

class TeleprompterScreen extends StatefulWidget {
  final Script script;
  const TeleprompterScreen({super.key, required this.script});

  @override
  State<TeleprompterScreen> createState() => _TeleprompterScreenState();
}

class _TeleprompterScreenState extends State<TeleprompterScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  bool _isRecording = false;
  bool _isPaused = false;
  bool _showProControls = false;

  VideoRecordingQuality _videoQuality = VideoRecordingQuality.fhd;
  int _targetFps = 30;
  double _currentBrightness = 0.0;
  double _currentZoom = 0.0;

  late final ValueNotifier<Duration> _recordingDuration;
  late final ValueNotifier<Size> _prompterSize;
  late final ValueNotifier<double> _prompterOpacity;
  late final ValueNotifier<double> _fontSize;
  late final ValueNotifier<double> _scrollSpeed;
  late final ValueNotifier<int> _textOrientation;

  Ticker? _ticker;
  Duration _lastElapsed = Duration.zero;
  late final VoiceSyncService _voiceSync;
  late final UIProvider _uiProvider;
  final ScrollController _scriptScrollController = ScrollController();

  int _lastFoundIndex = 0;
  bool _isPlayingScript = false;
  bool _showScriptControls = true;
  bool _showSettingsPanel = false;
  double _dragX = 0.0;
  double _dragY = 0.0;
  bool _isPositionInitialized = false;
  String? _lastVideoPath;

  TextPainter? _cachedTextPainter;
  double? _cachedPainterWidth;
  double? _cachedPainterFontSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    _prompterOpacity = ValueNotifier(0.2);
    _fontSize = ValueNotifier(24.0.sp);
    _scrollSpeed = ValueNotifier(50.0);
    _textOrientation = ValueNotifier(0);
    _prompterSize = ValueNotifier(Size(double.infinity, 500.h));
    _recordingDuration = ValueNotifier(Duration.zero);

    _ticker = createTicker(_onTick);
    _voiceSync = context.read<VoiceSyncService>();
    _uiProvider = context.read<UIProvider>();
    _voiceSync.initialize();
    _uiProvider.addListener(_handleUIChanges);
    _voiceSync.addListener(_handleVoiceChanges);
  }

  void _handleVoiceChanges() {
    if (!mounted || !_isPlayingScript || !_uiProvider.voiceSyncEnabled) return;

    if (!_voiceSync.isListening &&
        !_isPaused &&
        _scriptScrollController.hasClients) {
      _voiceSync.startListening(_onVoiceResult);
    }
  }

  void _handleUIChanges() {
    if (!mounted || !_isPlayingScript) return;

    if (_uiProvider.voiceSyncEnabled) {
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

    if (_cachedTextPainter == null ||
        _cachedPainterWidth != maxWidth ||
        _cachedPainterFontSize != fs) {
      final textStyle = TextStyle(
        fontSize: fs,
        fontWeight: FontWeight.w700,
        fontFamily: 'Manrope',
        height: 1.4,
      );

      _cachedTextPainter = TextPainter(
        text: TextSpan(text: widget.script.content, style: textStyle),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      _cachedTextPainter!.layout(maxWidth: maxWidth);
      _cachedPainterWidth = maxWidth;
      _cachedPainterFontSize = fs;
    }

    final offset = _cachedTextPainter!.getOffsetForCaret(
      TextPosition(offset: index),
      Rect.fromLTWH(0, 0, 0, fs),
    );

    return offset.dy;
  }

  void _onVoiceResult(String words) {
    if (!mounted || !_isPlayingScript) return;

    final scriptContent = widget.script.content.toLowerCase();
    final cleanedScript = scriptContent.replaceAll(RegExp(r'[^\w\s]'), ' ');
    final spokenWords = words.toLowerCase().trim().split(RegExp(r'\s+'));

    if (spokenWords.isEmpty) return;

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
    final isManualScrolling =
        _isPlayingScript && !context.read<UIProvider>().voiceSyncEnabled;
    if (!isManualScrolling && !_isRecording) {
      _lastElapsed = Duration.zero;
      return;
    }
    if (_lastElapsed == Duration.zero) {
      _lastElapsed = elapsed;
      return;
    }
    final delta = (elapsed - _lastElapsed).inMicroseconds / 1000000.0;
    _lastElapsed = elapsed;
    if (_isRecording && !_isPaused) {
      _recordingDuration.value += Duration(
        microseconds: (delta * 1000000).toInt(),
      );
    }
    if (_scriptScrollController.hasClients && _isPlayingScript) {
      if (_scriptScrollController.offset >=
          _scriptScrollController.position.maxScrollExtent) {
        setState(() => _isPlayingScript = false);
        _stopScrolling();
      } else if (!context.read<UIProvider>().voiceSyncEnabled) {
        _scriptScrollController.jumpTo(
          _scriptScrollController.offset + (_scrollSpeed.value * delta),
        );
      }
    }
  }

  void _startScrolling() {
    final uiProvider = context.read<UIProvider>();
    if (uiProvider.voiceSyncEnabled) {
      _voiceSync.startListening(_onVoiceResult);
    } else {
      if (!(_ticker?.isActive ?? false)) _ticker?.start();
    }

    if (_isRecording && !(_ticker?.isActive ?? false)) {
      _ticker?.start();
    }
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
      if (!_isPlayingScript) _lastFoundIndex = 0;
    });
    if (_isPlayingScript) {
      _startScrolling();
    } else {
      _stopScrolling();
    }
  }

  void _togglePause(VideoRecordingCameraState recordingState) async {
    if (recordingState.captureState == null) return;
    if (_isPaused) {
      await recordingState.resumeRecording(recordingState.captureState!);
      setState(() {
        _isPaused = false;
        if (!_isPlayingScript) {
          _isPlayingScript = true;
          _startScrolling();
        }
      });
    } else {
      await recordingState.pauseRecording(recordingState.captureState!);
      setState(() {
        _isPaused = true;
        _stopScrolling();
      });
    }
  }

  Future<CaptureRequest> _pathBuilder(List<Sensor> sensors) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = 'video_${DateTime.now().millisecondsSinceEpoch}.mp4';
    return SingleCaptureRequest('${appDir.path}/$fileName', sensors.first);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isPositionInitialized) {
      final size = MediaQuery.of(context).size;
      final prompterWidth = size.width;
      final prompterHeight = size.height * 0.5;
      _prompterSize.value = Size(prompterWidth, prompterHeight);
      _dragX = 0;
      _dragY = (size.height - prompterHeight) / 3;
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
    _ticker?.dispose();
    _scriptScrollController.dispose();
    _prompterOpacity.dispose();
    _fontSize.dispose();
    _scrollSpeed.dispose();
    _textOrientation.dispose();
    _prompterSize.dispose();
    _recordingDuration.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
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
          }
        }
        return KeyEventResult.ignored;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: CameraAwesomeBuilder.awesome(
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
            sensor: Sensor.position(SensorPosition.front),
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
          middleContentBuilder: (state) => Stack(
            fit: StackFit.expand,
            children: [
              PrompterOverlay(
                script: widget.script,
                isPlayingScript: _isPlayingScript,
                showScriptControls: _showScriptControls,
                showSettingsPanel: _showSettingsPanel,
                dragX: _dragX,
                dragY: _dragY,
                prompterSize: _prompterSize,
                prompterOpacity: _prompterOpacity,
                fontSize: _fontSize,
                textOrientation: _textOrientation,
                scrollSpeed: _scrollSpeed,
                scrollController: _scriptScrollController,
                onTogglePlay: _toggleScriptPlay,
                onToggleSettings: () =>
                    setState(() => _showSettingsPanel = !_showSettingsPanel),
                onToggleControls: () =>
                    setState(() => _showScriptControls = !_showScriptControls),
                onDrag: (d) => setState(() {
                  _dragX += d.dx;
                  _dragY += d.dy;
                }),
                onResize: (s) => _prompterSize.value = s,
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
                    builder: (context, duration, _) => TeleprompterTopBar(
                      state: state,
                      isRecording: _isRecording,
                      recordingDuration: duration,
                      onBack: () => Navigator.pop(context),
                      onShowSettings: () => _showVideoSettings(state),
                      formatDuration: (d) =>
                          "${d.inMinutes.remainder(60).toString().padLeft(2, "0")}:${d.inSeconds.remainder(60).toString().padLeft(2, "0")}",
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
                    onTogglePro: () =>
                        setState(() => _showProControls = !_showProControls),
                    onTogglePause: (s) => _togglePause(s),
                  ),
                ),
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
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/images/video_placeholder.png',
                          ),
                          fit: BoxFit.cover,
                        ),
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
            ],
          ),
          onMediaCaptureEvent: (event) {
            switch (event.status) {
              case MediaCaptureStatus.capturing:
                if (!_isRecording) {
                  setState(() {
                    _isRecording = true;
                    _isPaused = false;
                    _lastFoundIndex = 0;
                    _recordingDuration.value = Duration.zero;
                  });
                  if (!(_ticker?.isActive ?? false)) _ticker?.start();
                  if (!_isPlayingScript) _toggleScriptPlay();
                  AnalyticsService().logRecordingStarted(
                    scriptId: widget.script.key?.toString() ?? 'unknown',
                    scriptTitle: widget.script.title,
                    isVoiceSyncEnabled: context
                        .read<UIProvider>()
                        .voiceSyncEnabled,
                  );
                }
                break;
              case MediaCaptureStatus.success:
                final path = event.captureRequest.path;
                setState(() {
                  _isRecording = false;
                  _isPaused = false;
                  _lastVideoPath = path;
                });
                _stopScrolling();
                AnalyticsService().logRecordingStopped(
                  scriptId: widget.script.key?.toString() ?? 'unknown',
                  durationSeconds: _recordingDuration.value.inSeconds,
                );
                if (path != null) {
                  context.read<GalleryProvider>().addVideo(path);
                  ToastService.show("Video Saved Successfully");
                }
                break;
              case MediaCaptureStatus.failure:
                setState(() {
                  _isRecording = false;
                  _isPaused = false;
                });
                _stopScrolling();
                ToastService.show("Recording Failed", isError: true);
                break;
            }
          },
        ),
      ),
    );
  }

  void _showVideoSettings(CameraState state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => VideoSettingsSheet(
        state: state,
        videoQuality: _videoQuality,
        targetFps: _targetFps,
        onQualityChanged: (q) => setState(() => _videoQuality = q),
        onFpsChanged: (f) => setState(() => _targetFps = f),
      ),
    );
  }
}
