import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:ffmpeg_kit_flutter_new_min_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new_min_gpl/log.dart';
import 'package:ffmpeg_kit_flutter_new_min_gpl/return_code.dart';
import 'package:ffmpeg_kit_flutter_new_min_gpl/session.dart';
import 'package:ffmpeg_kit_flutter_new_min_gpl/statistics.dart' show Statistics;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gal/gal.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_config.dart';
import '../../../../core/utils/toast_service.dart';
import '../../../../widgets/common/adaptive_app_bar.dart';
import '../providers/gallery_provider.dart';

enum EditorTool { trim, adjust, transform }

class ProfessionalVideoEditor extends StatefulWidget {
  final File file;
  const ProfessionalVideoEditor({super.key, required this.file});

  @override
  State<ProfessionalVideoEditor> createState() => _ProfessionalVideoEditorState();
}

class _ProfessionalVideoEditorState extends State<ProfessionalVideoEditor> {
  late VideoPlayerController _controller;
  final ValueNotifier<EditorTool> _activeTool = ValueNotifier(EditorTool.trim);
  bool _isLoaded = false;
  final ValueNotifier<bool> _showOverlay = ValueNotifier(false);
  Timer? _overlayTimer;

  double _brightness = 0.0;
  double _contrast = 1.0;
  double _saturation = 1.0;
  double _hue = 0.0;

  int _rotation = 0;
  bool _isFlipped = false;

  double _startTrim = 0.0;
  double _endTrim = 1.0;
  Duration _videoDuration = Duration.zero;
  List<String> _thumbnails = [];
  bool _generatingThumbnails = true;

  Session? _currentSession;
  final ValueNotifier<double> _progressNotifier = ValueNotifier(0.0);

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  @override
  void dispose() {
    _activeTool.dispose();
    _showOverlay.dispose();
    _overlayTimer?.cancel();
    _progressNotifier.dispose();
    if (_isLoaded) {
      _controller.removeListener(_onVideoTick);
      _controller.dispose();
    }
    super.dispose();
  }

  void _initVideo() async {
    _controller = VideoPlayerController.file(widget.file);

    await _controller.initialize().then((_) {
      if (mounted) {
        setState(() {
          _videoDuration = _controller.value.duration;
          _isLoaded = true;
          _controller.addListener(_onVideoTick);
          _controller.play();
        });
        _generateThumbnails();
      }
    }).catchError((error) {
      if (mounted) Navigator.pop(context);
    });
  }

  Future<void> _generateThumbnails() async {
    final durationSec = _videoDuration.inSeconds;
    if (durationSec == 0) return;

    final appDir = await getTemporaryDirectory();
    final String thumbDir = "${appDir.path}/thumbs_${DateTime.now().millisecondsSinceEpoch}";
    await Directory(thumbDir).create();

    final int count = 6;
    final double fps = count / (durationSec > 0 ? durationSec : 1);

    final cmd = "-i \"${widget.file.path}\" -vf \"fps=$fps,scale=-1:80\" \"$thumbDir/thumb%03d.jpg\"";

    await FFmpegKit.execute(cmd);

    final dir = Directory(thumbDir);
    if (await dir.exists()) {
      final List<FileSystemEntity> entities = dir.listSync();
      final List<String> paths = entities
          .where((e) => e.path.endsWith('.jpg'))
          .map((e) => e.path)
          .toList();

      paths.sort();

      if (mounted) {
        setState(() {
          _thumbnails = paths;
          _generatingThumbnails = false;
        });
      }
    }
  }

  void _onVideoTick() {
    if (!_isLoaded || _controller.value.duration == Duration.zero) return;

    final durationMs = _controller.value.duration.inMilliseconds;
    final currentMs = _controller.value.position.inMilliseconds;

    final startMs = (_startTrim * durationMs).toInt();
    final endMs = (_endTrim * durationMs).toInt();

    if (currentMs >= endMs) {
      _controller.seekTo(Duration(milliseconds: startMs));
      if (!_controller.value.isPlaying) _controller.play();
    }
    if (currentMs < startMs && _controller.value.isPlaying) {
      _controller.seekTo(Duration(milliseconds: startMs));
    }
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(d.inMinutes.remainder(60))}:${twoDigits(d.inSeconds.remainder(60))}";
  }

  List<double> _multiplyMatrix(List<double> m1, List<double> m2) {
    var result = List<double>.filled(20, 0.0);
    for (int y = 0; y < 4; y++) {
      for (int x = 0; x < 5; x++) {
        double sum = 0.0;
        for (int z = 0; z < 4; z++) {
          sum += m1[y * 5 + z] * m2[z * 5 + x];
        }
        if (x == 4) sum += m1[y * 5 + 4];
        result[y * 5 + x] = sum;
      }
    }
    return result;
  }

  List<double> _calculateColorMatrix() {
    List<double> matrix = [
      1, 0, 0, 0, 0,
      0, 1, 0, 0, 0,
      0, 0, 1, 0, 0,
      0, 0, 0, 1, 0,
    ];

    double t = (1.0 - _contrast) * 128.0;
    matrix = _multiplyMatrix(matrix, [
      _contrast, 0, 0, 0, t,
      0, _contrast, 0, 0, t,
      0, 0, _contrast, 0, t,
      0, 0, 0, 1, 0,
    ]);

    double b = _brightness * 255.0;
    matrix = _multiplyMatrix(matrix, [
      1, 0, 0, 0, b,
      0, 1, 0, 0, b,
      0, 0, 1, 0, b,
      0, 0, 0, 1, 0,
    ]);

    double lumR = 0.3086, lumG = 0.6094, lumB = 0.0820;
    double oneMinusSat = 1.0 - _saturation;
    matrix = _multiplyMatrix(matrix, [
      (oneMinusSat * lumR) + _saturation, (oneMinusSat * lumG), (oneMinusSat * lumB), 0, 0,
      (oneMinusSat * lumR), (oneMinusSat * lumG) + _saturation, (oneMinusSat * lumB), 0, 0,
      (oneMinusSat * lumR), (oneMinusSat * lumG), (oneMinusSat * lumB) + _saturation, 0, 0,
      0, 0, 0, 1, 0,
    ]);

    double angle = _hue * math.pi / 180.0;
    double cosA = math.cos(angle);
    double sinA = math.sin(angle);
    double c0 = 0.213 + cosA * 0.787 - sinA * 0.213;
    double c1 = 0.715 - cosA * 0.715 - sinA * 0.715;
    double c2 = 0.072 - cosA * 0.072 + sinA * 0.928;
    double c3 = 0.213 - cosA * 0.213 + sinA * 0.143;
    double c4 = 0.715 + cosA * 0.285 + sinA * 0.140;
    double c5 = 0.072 - cosA * 0.072 - sinA * 0.283;
    double c6 = 0.213 - cosA * 0.213 - sinA * 0.787;
    double c7 = 0.715 - cosA * 0.715 + sinA * 0.715;
    double c8 = 0.072 + cosA * 0.928 + sinA * 0.072;
    matrix = _multiplyMatrix(matrix, [
      c0, c1, c2, 0, 0,
      c3, c4, c5, 0, 0,
      c6, c7, c8, 0, 0,
      0, 0, 0, 1, 0,
    ]);
    return matrix;
  }

  void _showRenameDialog() {
    final TextEditingController nameCtrl = TextEditingController(
      text: "video_${DateTime.now().millisecondsSinceEpoch}",
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text("Export Video", style: TextStyle(color: Colors.white, fontSize: 18.sp)),
        content: TextField(
          controller: nameCtrl,
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
          decoration: const InputDecoration(
            labelText: "Filename",
            labelStyle: TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Cancel", style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              if (nameCtrl.text.isNotEmpty) _startExport(nameCtrl.text.trim());
            },
            child: Text("Export", style: TextStyle(fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }

  Future<void> _startExport(String filename) async {
    if (!_isLoaded) return;
    await _controller.pause();

    if (!filename.toLowerCase().endsWith(".mp4")) filename += ".mp4";
    final appDir = await getApplicationDocumentsDirectory();
    final String outputPath = '${appDir.path}/$filename';

    final int totalDurationMs = _controller.value.duration.inMilliseconds;
    final double startSec = (_startTrim * totalDurationMs) / 1000.0;
    final double endSec = (_endTrim * totalDurationMs) / 1000.0;
    final double durationSec = endSec - startSec;

    List<String> filters = [];
    if (_brightness != 0.0 || _contrast != 1.0 || _saturation != 1.0) {
      filters.add('eq=brightness=$_brightness:contrast=$_contrast:saturation=$_saturation');
    }
    if (_hue != 0.0) filters.add('hue=h=$_hue');
    if (_isFlipped) filters.add('hflip');
    if (_rotation == 90) filters.add('transpose=1');
    else if (_rotation == 180) filters.add('transpose=1,transpose=1');
    else if (_rotation == 270) filters.add('transpose=2');

    String filterCmd = filters.isNotEmpty ? "-vf \"${filters.join(',')}\"" : "";

    final startStr = startSec.toStringAsFixed(3);
    final durStr = durationSec.toStringAsFixed(3);
    final cmd = "-ss $startStr -t $durStr -i \"${widget.file.path}\" $filterCmd -c:v libx264 -preset medium -c:a copy \"$outputPath\"";

    if (!mounted) return;
    _showProgressDialog(context, durationSec * 1000);

    await FFmpegKit.executeAsync(
      cmd,
      (Session session) async {
        final returnCode = await session.getReturnCode();
        if (mounted && Navigator.canPop(context)) Navigator.pop(context);

        if (ReturnCode.isSuccess(returnCode)) {
          await Gal.putVideo(outputPath);
          if (mounted) {
            Provider.of<GalleryProvider>(context, listen: false).addVideo(outputPath);
            ToastService.show("Saved to Gallery");
            Navigator.pop(context);
          }
        } else if (ReturnCode.isCancel(returnCode)) {
          if (mounted) ToastService.show("Export Cancelled");
        } else {
          if (mounted) ToastService.show("Export Failed", isError: true);
        }
      },
      (Log log) {},
      (Statistics stats) {
        int time = stats.getTime();
        double progress = (time / (durationSec * 1000)).clamp(0.0, 1.0);
        _progressNotifier.value = progress;
      },
    ).then((session) => _currentSession = session);
  }

  void _showProgressDialog(BuildContext context, double totalDurationMs) {
    _progressNotifier.value = 0.0;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          title: Text("Exporting...", style: TextStyle(color: Colors.white, fontSize: 18.sp)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Please wait while we render your recording.", style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
              SizedBox(height: 20.h),
              ValueListenableBuilder<double>(
                valueListenable: _progressNotifier,
                builder: (context, val, child) {
                  return Column(
                    children: [
                      LinearProgressIndicator(
                        value: val,
                        backgroundColor: Colors.grey[800],
                        color: AppColors.primary,
                      ),
                      SizedBox(height: 10.h),
                      Text("${(val * 100).toInt()}%", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.sp)),
                    ],
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_currentSession != null) FFmpegKit.cancel(_currentSession!.getSessionId());
              },
              child: Text("Cancel", style: TextStyle(color: Colors.redAccent, fontSize: 14.sp)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      
      appBar: AdaptiveAppBar(
        title: "Studio",
        backgroundColor: Colors.black,
        showBackButton: true,
        actions: [
          TextButton(
            onPressed: _showRenameDialog,
            child: Text(
              "EXPORT",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),

      body: !_isLoaded
          ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
          : Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [_buildPreview(), _buildPlayOverlay()],
                  ),
                ),
                Container(
                  height: 300.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF151515),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                  child: ValueListenableBuilder<EditorTool>(
                    valueListenable: _activeTool,
                    builder: (context, tool, _) {
                      return Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                              child: _buildToolContent(tool),
                            ),
                          ),
                          Divider(color: Colors.grey[800], height: 1.h),
                          SafeArea(
                            top: false,
                            child: SizedBox(
                              height: 70.h,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildNavItem(Icons.content_cut, "Trim", EditorTool.trim, tool),
                                  _buildNavItem(Icons.tune, "Adjust", EditorTool.adjust, tool),
                                  _buildNavItem(Icons.crop_rotate, "Transform", EditorTool.transform, tool),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildPreview() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: _rotation.toDouble()),
      duration: const Duration(milliseconds: 300),
      builder: (context, angle, child) {
        return Transform.rotate(
          angle: angle * math.pi / 180,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..scale(_isFlipped ? -1.0 : 1.0, 1.0),
            child: ColorFiltered(
              colorFilter: ColorFilter.matrix(_calculateColorMatrix()),
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlayOverlay() {
    return AnimatedBuilder(
      animation: Listenable.merge([_controller, _showOverlay]),
      builder: (_, __) {
        final isPlaying = _controller.value.isPlaying;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
            _showOverlay.value = true;
            _overlayTimer?.cancel();
            _overlayTimer = Timer(const Duration(milliseconds: 1200), () {
              if (mounted) _showOverlay.value = false;
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              const SizedBox.expand(),
              IgnorePointer(
                child: AnimatedOpacity(
                  opacity: _showOverlay.value ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.w),
                    ),
                    child: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 40.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildToolContent(EditorTool tool) {
    switch (tool) {
      case EditorTool.trim:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Trim Video", style: TextStyle(color: Colors.white70, fontSize: 12.sp)),
                Text(
                  "${_formatDuration(Duration(milliseconds: (_startTrim * _videoDuration.inMilliseconds).toInt()))} - ${_formatDuration(Duration(milliseconds: (_endTrim * _videoDuration.inMilliseconds).toInt()))}",
                  style: TextStyle(color: AppColors.primary, fontSize: 12.sp),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            SizedBox(
              height: 60.h,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4.r),
                        child: _generatingThumbnails
                            ? const Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: _thumbnails.map((path) {
                                  return Expanded(child: Image.file(File(path), fit: BoxFit.cover));
                                }).toList(),
                              ),
                      ),
                    ),
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      rangeTrackShape: ProfessionalTrackShape(),
                      rangeThumbShape: const ProfessionalThumbShape(),
                      trackHeight: 60.h,
                      activeTrackColor: Colors.transparent,
                      inactiveTrackColor: Colors.black.withOpacity(0.7),
                      overlayColor: AppColors.primary.withOpacity(0.1),
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 12.r),
                    ),
                    child: RangeSlider(
                      values: RangeValues(_startTrim, _endTrim),
                      min: 0.0,
                      max: 1.0,
                      onChanged: (values) {
                        setState(() {
                          _startTrim = values.start;
                          _endTrim = values.end;
                        });
                      },
                      onChangeEnd: (values) {
                        final startMs = (values.start * _videoDuration.inMilliseconds).toInt();
                        _controller.seekTo(Duration(milliseconds: startMs));
                        _controller.play();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );

      case EditorTool.adjust:
        return ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildSlider("Brightness", _brightness, -0.5, 0.5, (v) => setState(() => _brightness = v)),
            _buildSlider("Contrast", _contrast, 0.5, 1.5, (v) => setState(() => _contrast = v)),
            _buildSlider("Saturation", _saturation, 0.0, 2.0, (v) => setState(() => _saturation = v)),
            _buildSlider("Hue", _hue, -180, 180, (v) => setState(() => _hue = v)),
          ],
        );

      case EditorTool.transform:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildActionButton(Icons.rotate_right, "Rotate 90°", () {
              setState(() => _rotation = (_rotation + 90) % 360);
            }),
            _buildActionButton(Icons.flip, "Mirror", () {
              setState(() => _isFlipped = !_isFlipped);
            }),
          ],
        );
    }
  }

  Widget _buildNavItem(IconData icon, String label, EditorTool tool, EditorTool activeTool) {
    final isActive = tool == activeTool;
    return GestureDetector(
      onTap: () => _activeTool.value = tool,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isActive ? AppColors.primary : Colors.grey, size: 26.sp),
          SizedBox(height: 4.h),
          Text(label, style: TextStyle(color: isActive ? AppColors.primary : Colors.grey, fontSize: 11.sp)),
        ],
      ),
    );
  }

  Widget _buildSlider(String label, double value, double min, double max, Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
            Text(value.toStringAsFixed(2), style: TextStyle(color: Colors.white70, fontSize: 10.sp)),
          ],
        ),
        SizedBox(
          height: 30.h,
          child: Slider(
            value: value,
            min: min,
            max: max,
            activeColor: AppColors.primary,
            inactiveColor: Colors.grey[800],
            thumbColor: Colors.white,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        width: 100.w,
        height: 80.h,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 28.sp),
            SizedBox(height: 8.h),
            Text(label, style: TextStyle(color: Colors.white, fontSize: 12.sp)),
          ],
        ),
      ),
    );
  }
}

class ProfessionalThumbShape extends RangeSliderThumbShape {
  static const double _thumbWidth = 12.0;
  static const double _thumbHeight = 60.0;
  const ProfessionalThumbShape();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(_thumbWidth, _thumbHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool? isOnTop,
    TextDirection? textDirection,
    required SliderThemeData sliderTheme,
    Thumb? thumb,
    bool? isPressed,
  }) {
    final Canvas canvas = context.canvas;
    final rRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: _thumbWidth, height: _thumbHeight),
      const Radius.circular(4),
    );
    canvas.drawRRect(rRect, Paint()..color = Colors.white);
    final gripPaint = Paint()
      ..color = Colors.black45
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(center.dx, center.dy - 8), Offset(center.dx, center.dy + 8), gripPaint);
  }
}

class ProfessionalTrackShape extends RoundedRectRangeSliderTrackShape {
  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset startThumbCenter,
    required Offset endThumbCenter,
    bool isEnabled = false,
    bool isDiscrete = false,
    required TextDirection textDirection,
    double additionalActiveTrackHeight = 2,
  }) {
    super.paint(
      context,
      offset,
      parentBox: parentBox,
      sliderTheme: sliderTheme,
      enableAnimation: enableAnimation,
      startThumbCenter: startThumbCenter,
      endThumbCenter: endThumbCenter,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
      textDirection: textDirection,
      additionalActiveTrackHeight: additionalActiveTrackHeight,
    );
    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    context.canvas.drawLine(
      Offset(startThumbCenter.dx, offset.dy),
      Offset(endThumbCenter.dx, offset.dy),
      borderPaint,
    );
    context.canvas.drawLine(
      Offset(startThumbCenter.dx, offset.dy + parentBox.size.height),
      Offset(endThumbCenter.dx, offset.dy + parentBox.size.height),
      borderPaint,
    );
  }
}