import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui'; // Required for ImageFilter

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:camerawesome/pigeon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

// --- YOUR PROJECT IMPORTS ---
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/toast_service.dart';
import '../../../scripts/data/models/script_model.dart';
import '../../../gallery/presentation/pages/video_editor_screen.dart';

class TeleprompterScreen extends StatefulWidget {
  final Script script;
  const TeleprompterScreen({super.key, required this.script});

  @override
  State<TeleprompterScreen> createState() => _TeleprompterScreenState();
}

class _TeleprompterScreenState extends State<TeleprompterScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  // --- STATE VARIABLES ---
  bool _permissionsGranted = false;
  double _currentZoom = 0.0;
  double _currentBrightness = 0.0;
  bool _showProControls = true;
  bool _isRecording = false; // For UI Animation

  // --- TELEPROMPTER STATE ---
  final ScrollController _scriptScrollController = ScrollController();
  bool _isPlayingScript = false;
  bool _showScriptControls = true;
  bool _showSettingsPanel = false;
  int _textOrientation = 0;

  // --- DRAGGABLE WINDOW DEFAULTS ---
  double _dragX = 30.0;
  double _dragY = 120.0;
  double _prompterWidth = 300.0;
  double _prompterHeight = 350.0;
  double _prompterOpacity = 0.4;
  double _fontSize = 24.0;
  double _scrollSpeed = 50.0;

  Timer? _scrollTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    _initializePermissions();
  }

  Future<void> _initializePermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
    ].request();

    if (statuses[Permission.camera] == PermissionStatus.granted &&
        statuses[Permission.microphone] == PermissionStatus.granted) {
      if (mounted) setState(() => _permissionsGranted = true);
    } else {
      if (mounted) {
        ToastService.show("Permissions required", isError: true);
        Navigator.pop(context);
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    _scrollTimer?.cancel();
    _scriptScrollController.dispose();
    super.dispose();
  }

  Future<CaptureRequest> _pathBuilder(List<Sensor> sensors) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = 'video_${DateTime.now().millisecondsSinceEpoch}.mp4';
    return SingleCaptureRequest('${appDir.path}/$fileName', sensors.first);
  }

  // --- SCROLL LOGIC ---
  void _startScrolling() {
    _scrollTimer?.cancel();
    const fps = 60;
    _scrollTimer = Timer.periodic(const Duration(milliseconds: 1000 ~/ fps), (
      timer,
    ) {
      if (!_scriptScrollController.hasClients) return;
      if (_scriptScrollController.offset >=
          _scriptScrollController.position.maxScrollExtent) {
        setState(() => _isPlayingScript = false);
        _scrollTimer?.cancel();
      } else {
        _scriptScrollController.jumpTo(
          _scriptScrollController.offset + (_scrollSpeed / fps),
        );
      }
    });
  }

  void _stopScrolling() {
    _scrollTimer?.cancel();
    setState(() => _isPlayingScript = false);
  }

  void _toggleScriptPlay() {
    setState(() => _isPlayingScript = !_isPlayingScript);
    if (_isPlayingScript) {
      _startScrolling();
    } else {
      _scrollTimer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_permissionsGranted) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: AppColors.accent)),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: CameraAwesomeBuilder.awesome(
        saveConfig: SaveConfig.video(
          pathBuilder: _pathBuilder,
          mirrorFrontCamera: true,
          videoOptions: VideoOptions(
            enableAudio: true,
            quality: VideoRecordingQuality.fhd,
          ),
        ),
        sensorConfig: SensorConfig.single(
          sensor: Sensor.position(SensorPosition.front),
          aspectRatio: CameraAspectRatios.ratio_16_9,
          flashMode: FlashMode.none,
        ),
        // Disable default UI elements to use our Custom Builders
        theme: AwesomeTheme(
          bottomActionsBackgroundColor: Colors.transparent,
          buttonTheme: AwesomeButtonTheme(
            backgroundColor: Colors.transparent,
            iconSize: 32,
            foregroundColor: Colors.white,
          ),
        ),

        // 1. TOP BAR (Back + Flash)
        topActionsBuilder: (state) {
          return SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildGlassButton(
                    icon: Icons.arrow_back,
                    onTap: () => Navigator.pop(context),
                  ),

                  StreamBuilder<FlashMode>(
                    stream: state.sensorConfig.flashMode$,
                    builder: (context, snapshot) {
                      final currentMode = snapshot.data ?? FlashMode.none;
                      IconData flashIcon;
                      switch (currentMode) {
                        case FlashMode.none:
                          flashIcon = Icons.flash_off;
                          break;
                        case FlashMode.on:
                          flashIcon = Icons.flash_on;
                          break;
                        case FlashMode.auto:
                          flashIcon = Icons.flash_auto;
                          break;
                        case FlashMode.always:
                          flashIcon = Icons.flashlight_on;
                          break;
                      }

                      return _buildGlassButton(
                        icon: flashIcon,
                        isActive: currentMode != FlashMode.none,
                        onTap: () {
                          FlashMode nextMode;
                          if (currentMode == FlashMode.none) {
                            nextMode = FlashMode.on;
                          } else if (currentMode == FlashMode.on) {
                            nextMode = FlashMode.auto;
                          } else {
                            nextMode = FlashMode.none;
                          }
                          state.sensorConfig.setFlashMode(nextMode);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },

        // 2. BOTTOM BAR (Switch + Shutter + Settings)
        bottomActionsBuilder: (state) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 30, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGlassButton(
                  icon: Icons.cameraswitch_rounded,
                  onTap: () {
                    state.switchCameraSensor(
                      aspectRatio: CameraAspectRatios.ratio_16_9,
                    );
                  },
                ),

                _buildShutterButton(state),

                _buildGlassButton(
                  icon: _showProControls ? Icons.close : Icons.tune_rounded,
                  isActive: _showProControls,
                  onTap: () =>
                      setState(() => _showProControls = !_showProControls),
                ),
              ],
            ),
          );
        },

        onMediaCaptureEvent: (MediaCapture? event) {
          if (event == null) return;
          switch (event.status) {
            case MediaCaptureStatus.capturing:
              setState(() => _isRecording = true);
              if (!_isPlayingScript) {
                setState(() => _isPlayingScript = true);
                _startScrolling();
              }
              break;
            case MediaCaptureStatus.success:
              setState(() => _isRecording = false);
              _stopScrolling();
              final path = event.captureRequest.path;
              if (path != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProfessionalVideoEditor(file: File(path)),
                    ),
                  );
                });
              }
              break;
            case MediaCaptureStatus.failure:
              setState(() => _isRecording = false);
              _stopScrolling();
              ToastService.show("Recording Failed", isError: true);
              break;
            default:
              break;
          }
        },
        middleContentBuilder: (CameraState state) {
          return Stack(
            fit: StackFit.expand,
            children: [
              _buildTeleprompterOverlay(),

              if (_showProControls) _buildSideControls(state),
            ],
          );
        },
      ),
    );
  }

  // --- CUSTOM SHUTTER BUTTON ---
  Widget _buildShutterButton(CameraState state) {
    return GestureDetector(
      onTap: () {
        state.when(
          // 1. If IDLE: We receive VideoCameraState -> Start Recording
          onVideoMode: (videoState) {
            videoState.startRecording();
          },
          // 2. If RECORDING: We receive VideoRecordingCameraState -> Stop Recording
          onVideoRecordingMode: (recordingState) {
            recordingState.stopRecording();
          },
          // 3. Handle other states safely
          onPreparingCamera: (_) {},
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 4),
          color: Colors.transparent,
        ),
        padding: const EdgeInsets.all(4),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: _isRecording ? Colors.red : Colors.white,
            shape: _isRecording ? BoxShape.rectangle : BoxShape.circle,
            borderRadius: _isRecording ? BorderRadius.circular(16) : null,
          ),
        ),
      ),
    );
  }

  // --- SIDEBAR CONTROLS ---
  Widget _buildSideControls(CameraState state) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              width: 56,
              height: 280,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    Icons.wb_sunny_rounded,
                    color: Colors.amber,
                    size: 20,
                  ),

                  // Brightness Slider
                  Expanded(
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 4,
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 8,
                          ),
                          overlayShape: SliderComponentShape.noOverlay,
                          activeTrackColor: Colors.amber,
                          inactiveTrackColor: Colors.white24,
                          thumbColor: Colors.white,
                        ),
                        child: Slider(
                          value: _currentBrightness,
                          min: 0.0,
                          max: 1.0,
                          onChanged: (val) {
                            setState(() => _currentBrightness = val);
                            state.sensorConfig.setBrightness(val);
                          },
                        ),
                      ),
                    ),
                  ),

                  Container(width: 24, height: 1, color: Colors.white12),
                  const SizedBox(height: 12),

                  // Zoom Toggles
                  _buildZoomToggle("2x", _currentZoom > 0.1, () {
                    setState(() => _currentZoom = 0.5);
                    state.sensorConfig.setZoom(0.5);
                  }),
                  const SizedBox(height: 10),
                  _buildZoomToggle("1x", _currentZoom <= 0.1, () {
                    setState(() => _currentZoom = 0.0);
                    state.sensorConfig.setZoom(0.0);
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildZoomToggle(String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.black.withValues(alpha: 0.3),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white30),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  // --- TELEPROMPTER OVERLAY ---
  Widget _buildTeleprompterOverlay() {
    return Positioned(
      left: _dragX,
      top: _dragY,
      child: GestureDetector(
        onPanUpdate: (d) => setState(() {
          _dragX += d.delta.dx;
          _dragY += d.delta.dy;
        }),
        onTap: () => setState(() => _showScriptControls = !_showScriptControls),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: _prompterWidth,
              height: _prompterHeight,
              decoration: BoxDecoration(
                color: const Color(
                  0xFF1C1C1E,
                ).withValues(alpha: _prompterOpacity),
                border: Border.all(
                  color: _showScriptControls
                      ? Colors.white24
                      : Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    bottom: _showScriptControls ? 64 : 0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                      child: RotatedBox(
                        quarterTurns: _textOrientation,
                        child: ShaderMask(
                          shaderCallback: (r) => const LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.white,
                              Colors.white,
                              Colors.transparent,
                            ],
                            stops: [0.0, 0.1, 0.9, 1.0],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ).createShader(r),
                          blendMode: BlendMode.dstIn,
                          child: SingleChildScrollView(
                            controller: _scriptScrollController,
                            padding: EdgeInsets.symmetric(
                              vertical: _prompterHeight / 2,
                            ),
                            child: Text(
                              widget.script.content,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: _fontSize,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                height: 1.4,
                                shadows: const [
                                  Shadow(
                                    color: Colors.black45,
                                    offset: Offset(0, 1),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  if (_showSettingsPanel && _showScriptControls)
                    Positioned.fill(
                      bottom: 64,
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.85),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildSettingRow(
                              Icons.text_fields,
                              "Size",
                              _fontSize,
                              16,
                              50,
                              (v) => setState(() => _fontSize = v),
                            ),
                            const SizedBox(height: 16),
                            _buildSettingRow(
                              Icons.opacity,
                              "Opacity",
                              _prompterOpacity,
                              0.2,
                              0.9,
                              (v) => setState(() => _prompterOpacity = v),
                            ),
                            const SizedBox(height: 16),
                            _buildSettingRow(
                              Icons.speed,
                              "Speed",
                              _scrollSpeed,
                              10,
                              150,
                              (v) => setState(() => _scrollSpeed = v),
                            ),
                          ],
                        ),
                      ),
                    ),

                  if (_showScriptControls)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 64,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.4),
                          border: const Border(
                            top: BorderSide(color: Colors.white10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(
                                _showSettingsPanel ? Icons.close : Icons.tune,
                                color: Colors.white70,
                              ),
                              iconSize: 24,
                              onPressed: () => setState(
                                () => _showSettingsPanel = !_showSettingsPanel,
                              ),
                            ),

                            GestureDetector(
                              onTap: _toggleScriptPlay,
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: const BoxDecoration(
                                  color: AppColors.accent,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  _isPlayingScript
                                      ? Icons.pause_rounded
                                      : Icons.play_arrow_rounded,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),

                            IconButton(
                              icon: const Icon(
                                Icons.rotate_right,
                                color: Colors.white70,
                              ),
                              iconSize: 24,
                              onPressed: () => setState(
                                () => _textOrientation =
                                    (_textOrientation + 1) % 4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  if (_showScriptControls)
                    Positioned(
                      right: 4,
                      bottom: 4,
                      child: GestureDetector(
                        onPanUpdate: (d) => setState(() {
                          _prompterWidth = math.max(
                            200,
                            _prompterWidth + d.delta.dx,
                          );
                          _prompterHeight = math.max(
                            200,
                            _prompterHeight + d.delta.dy,
                          );
                        }),
                        child: const Icon(
                          Icons.crop_free_rounded,
                          color: Colors.white38,
                          size: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- STANDARD GLASS BUTTON ---
  Widget _buildGlassButton({
    required IconData icon,
    VoidCallback? onTap,
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.accent
                  : Colors.black.withValues(alpha: 0.3),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white24),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingRow(
    IconData icon,
    String label,
    double val,
    double min,
    double max,
    Function(double) onChanged,
  ) {
    return Row(
      children: [
        Icon(icon, color: Colors.white54, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 4,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              activeTrackColor: AppColors.accent,
              inactiveTrackColor: Colors.white24,
              thumbColor: Colors.white,
              overlayShape: SliderComponentShape.noOverlay,
            ),
            child: Slider(value: val, min: min, max: max, onChanged: onChanged),
          ),
        ),
      ],
    );
  }
}
