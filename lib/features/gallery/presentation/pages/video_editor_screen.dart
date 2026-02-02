import 'dart:async';
import 'dart:io';
import 'package:easy_video_editor/easy_video_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/core/utils/responsive_config.dart';
import 'package:provider/provider.dart';
import 'package:gal/gal.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter_application_6/core/constants/app_constants.dart';
import 'package:flutter_application_6/core/utils/toast_service.dart';
import 'package:flutter_application_6/widgets/common/adaptive_app_bar.dart';
import 'package:flutter_application_6/widgets/ads/adaptive_banner_ad.dart';
import 'package:flutter_application_6/features/scripts/data/models/script_model.dart';
import 'package:flutter_application_6/core/services/rate_service.dart';
import '../providers/gallery_provider.dart';

import '../widgets/editor/editor_video_preview.dart';
import '../widgets/editor/editor_timeline.dart';
import '../widgets/editor/editor_ratio_panel.dart';
import '../widgets/editor/editor_adjustment_panel.dart';
import '../widgets/editor/editor_tab_selector.dart';
import '../widgets/editor/export_dialog.dart';

enum EditorTab { trim, ratio, adjust }

class ProfessionalVideoEditor extends StatefulWidget {
  final File file;
  final Script? script;
  const ProfessionalVideoEditor({super.key, required this.file, this.script});

  @override
  State<ProfessionalVideoEditor> createState() =>
      _ProfessionalVideoEditorState();
}

class _ProfessionalVideoEditorState extends State<ProfessionalVideoEditor> {
  late VideoPlayerController _controller;
  final ValueNotifier<EditorTab> _activeTab = ValueNotifier(EditorTab.trim);
  bool _isLoaded = false;

  final ValueNotifier<bool> _showOverlay = ValueNotifier(false);
  Timer? _overlayTimer;

  double _startTrim = 0.0;
  double _endTrim = 1.0;
  Duration _videoDuration = Duration.zero;
  final List<String> _thumbnails = [];
  bool _generatingThumbnails = true;

  int _rotation = 0;
  bool _isFlipped = false;
  double? _targetAspectRatio;
  VideoAspectRatio? _selectedRatioEnum;

  double _playbackSpeed = 1.0;
  bool _removeAudio = false;
  final ValueNotifier<double> _progressNotifier = ValueNotifier(0.0);
  bool _isExporting = false;
  double _lastProgress =
      0.0; // Track last progress to ensure monotonic increase
  bool _isSavingToGallery = false; // Track if currently saving to gallery

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  @override
  void dispose() {
    _activeTab.dispose();
    _showOverlay.dispose();
    _overlayTimer?.cancel();
    _progressNotifier.dispose();
    try {
      _controller.removeListener(_onVideoTick);
      _controller.dispose();
    } catch (_) {}
    super.dispose();
  }

  void _initVideo() async {
    _controller = VideoPlayerController.file(widget.file);
    try {
      await _controller.initialize();
      if (mounted) {
        setState(() {
          _videoDuration = _controller.value.duration;
          _isLoaded = true;
          _controller.addListener(_onVideoTick);
          _controller.play();
        });
        Future.delayed(const Duration(milliseconds: 300), _generateThumbnails);
      }
    } catch (e) {
      if (mounted) {
        ToastService.show("Could not load video", isError: true);
        Navigator.pop(context);
      }
    }
  }

  Future<void> _generateThumbnails() async {
    if (_videoDuration.inMilliseconds == 0) return;
    const count = 8;
    final interval = _videoDuration.inMilliseconds ~/ count;
    try {
      final editor = VideoEditorBuilder(videoPath: widget.file.path);
      for (int i = 0; i < count; i++) {
        if (!mounted) break;
        final path = await editor.generateThumbnail(
          positionMs: i * interval,
          quality: 20,
        );
        if (path != null && await File(path).exists()) {
          if (mounted) setState(() => _thumbnails.add(path));
        }
      }
    } finally {
      if (mounted) setState(() => _generatingThumbnails = false);
    }
  }

  void _onVideoTick() {
    if (!_isLoaded) return;
    final durationMs = _controller.value.duration.inMilliseconds;
    if (durationMs == 0) return;

    final currentMs = _controller.value.position.inMilliseconds;
    final startMs = (_startTrim * durationMs).toInt();
    final endMs = (_endTrim * durationMs).toInt();

    if (currentMs >= endMs) {
      _controller.seekTo(Duration(milliseconds: startMs));
      if (!_controller.value.isPlaying) _controller.play();
    } else if (currentMs < startMs && (startMs - currentMs) > 500) {
      _controller.seekTo(Duration(milliseconds: startMs));
    }
  }

  void _togglePlay() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
    _showOverlay.value = true;
    _overlayTimer?.cancel();
    _overlayTimer = Timer(const Duration(milliseconds: 1000), () {
      if (mounted) _showOverlay.value = false;
    });
  }

  Future<void> _handleBackNavigation() async {
    _controller.pause();
    final shouldDiscard = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20).r,
        ),
        title: const Text(
          "Discard Changes?",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          "You have unsaved changes. Edits will be lost.",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Keep Editing"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text("Discard"),
          ),
        ],
      ),
    );
    if (shouldDiscard == true && mounted) Navigator.pop(context);
  }

  void _onSavePressed() {
    if (!_isLoaded) return;
    _controller.pause();
    showDialog(
      context: context,
      builder: (ctx) => ExportDialog(
        onExport: (name, res) {
          Navigator.pop(ctx);
          _processExport(name, res);
        },
      ),
    );
  }

  Future<void> _processExport(String fileName, VideoResolution quality) async {
    // Set exporting state
    setState(() {
      _isExporting = true;
      _progressNotifier.value = 0.0;
      _lastProgress = 0.0; // Reset progress tracking
    });

    final exportStartTime = DateTime.now();
    debugPrint(
      '=== EXPORT STARTED at ${exportStartTime.toIso8601String()} ===',
    );

    try {
      // Calculate trim times
      final totalMs = _controller.value.duration.inMilliseconds;
      final startMs = (_startTrim * totalMs).toInt();
      final endMs = (_endTrim * totalMs).toInt();

      debugPrint('Export Configuration:');
      debugPrint('  - File name: $fileName');
      debugPrint('  - Quality: $quality');
      debugPrint(
        '  - Trim: $startMs - $endMs ms (${((endMs - startMs) / 1000).toStringAsFixed(1)}s)',
      );
      debugPrint('  - Speed: $_playbackSpeed');
      debugPrint('  - Remove Audio: $_removeAudio');
      debugPrint('  - Rotation: $_rotation°');
      debugPrint('  - Flipped: $_isFlipped');
      debugPrint('  - Aspect Ratio: $_selectedRatioEnum');

      // Build video editor chain
      var editor = VideoEditorBuilder(
        videoPath: widget.file.path,
      ).trim(startTimeMs: startMs, endTimeMs: endMs);

      if (_removeAudio) editor = editor.removeAudio();
      if (_playbackSpeed != 1.0) editor = editor.speed(speed: _playbackSpeed);
      if (_selectedRatioEnum != null) {
        editor = editor.crop(aspectRatio: _selectedRatioEnum!);
      }

      if (_rotation != 0) {
        editor = editor.rotate(degree: _getRotationDegree(_rotation));
      }
      if (_isFlipped) {
        editor = editor.flip(flipDirection: FlipDirection.horizontal);
      }

      // editor = editor.compress(resolution: quality);

      // Export video
      final resultPath = await editor.export(
        onProgress: (p) {
          // Ensure monotonic progress (only increase, never decrease)
          if (p > _lastProgress) {
            _lastProgress = p;
            if (mounted) {
              _progressNotifier.value = p;
            }
          }
        },
      );

      final exportEndTime = DateTime.now();
      final exportDuration = exportEndTime.difference(exportStartTime);
      debugPrint('Export completed in ${exportDuration.inSeconds}s');
      debugPrint('Result path: $resultPath');

      // Ensure we show 100% completion
      if (mounted) {
        _progressNotifier.value = 1.0;
        _lastProgress = 1.0;
      }

      if (resultPath == null || resultPath.isEmpty) {
        debugPrint('ERROR: Export returned null or empty path');
        throw Exception('Export failed - no result path returned');
      }

      // Comprehensive file verification
      debugPrint('Verifying exported file...');
      final file = File(resultPath);

      if (!await file.exists()) {
        debugPrint('ERROR: Exported file does not exist at: $resultPath');
        throw Exception('Exported file not found at path');
      }

      final fileSize = await file.length();
      debugPrint(
        'File exists! Size: ${(fileSize / 1024 / 1024).toStringAsFixed(2)} MB',
      );

      if (fileSize == 0) {
        debugPrint('ERROR: Exported file is empty (0 bytes)');
        throw Exception('Exported file is empty');
      }

      if (fileSize < 1024) {
        debugPrint('WARNING: File size is very small ($fileSize bytes)');
      }

      // Save to gallery
      debugPrint('Saving to device gallery...');
      setState(() => _isSavingToGallery = true);

      try {
        await Gal.putVideo(resultPath);
        debugPrint('✓ Video saved to gallery successfully');
      } catch (galError, galStack) {
        debugPrint('ERROR saving to gallery: $galError');
        debugPrint('Gallery error stack: $galStack');
        throw Exception('Failed to save to gallery: $galError');
      } finally {
        if (mounted) {
          setState(() => _isSavingToGallery = false);
        }
      }

      if (!mounted) {
        debugPrint('WARNING: Widget unmounted after gallery save');
        return;
      }

      // Add to provider
      debugPrint('Adding video to provider...');
      try {
        context.read<GalleryProvider>().addVideo(resultPath);
        debugPrint('✓ Video added to provider');
      } catch (providerError) {
        debugPrint('ERROR adding to provider: $providerError');
        // Continue even if provider fails
      }

      // Show success message
      ToastService.show("Saved as $fileName");
      debugPrint('✓ Success toast shown');

      // Increment rate check
      try {
        await RateService.incrementExportAndCheck();
        debugPrint('✓ Rate service updated');
      } catch (rateError) {
        debugPrint('WARNING: Rate service error: $rateError');
        // Continue even if rate service fails
      }

      if (!mounted) {
        debugPrint('WARNING: Widget unmounted before navigation');
        return;
      }

      // Close editor screen
      final totalTime = DateTime.now().difference(exportStartTime);
      debugPrint('=== EXPORT SUCCESS in ${totalTime.inSeconds}s ===');
      debugPrint('Closing editor screen...');
      Navigator.pop(context);
    } catch (e, stackTrace) {
      final errorTime = DateTime.now();
      final timeSinceStart = errorTime.difference(exportStartTime);

      debugPrint('═══════════════════════════════════════');
      debugPrint('ERROR during video export');
      debugPrint('Time since start: ${timeSinceStart.inSeconds}s');
      debugPrint('Error: $e');
      debugPrint('Stack trace:');
      debugPrint('$stackTrace');
      debugPrint('═══════════════════════════════════════');

      if (mounted) {
        setState(() => _isExporting = false);

        // Show user-friendly error message
        String userMessage = "Save Failed";
        if (e.toString().contains('gallery')) {
          userMessage = "Failed to save to gallery";
        } else if (e.toString().contains('not found')) {
          userMessage = "Export file not found";
        } else if (e.toString().contains('empty')) {
          userMessage = "Export produced empty file";
        }

        ToastService.show(userMessage, isError: true);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isExporting = false;
          _lastProgress = 0.0; // Reset for next export
        });
      }
      debugPrint('Export process cleanup completed');
    }
  }

  RotationDegree _getRotationDegree(int deg) {
    if (deg == 90) return RotationDegree.degree90;
    if (deg == 180) return RotationDegree.degree180;
    if (deg == 270) return RotationDegree.degree270;
    return RotationDegree.degree90;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _handleBackNavigation();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AdaptiveAppBar(
          title: "Studio Editor",
          backgroundColor: Colors.black,
          showBackButton: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: _handleBackNavigation,
          ),
          actions: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: ValueListenableBuilder<double>(
                valueListenable: _progressNotifier,
                builder: (context, progress, _) {
                  return ElevatedButton(
                    onPressed: _isExporting ? null : _onSavePressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isExporting
                          ? AppColors.primary.withValues(alpha: 0.7)
                          : AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20).r,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      disabledBackgroundColor: AppColors.primary.withValues(
                        alpha: 0.7,
                      ),
                      disabledForegroundColor: Colors.white,
                    ),
                    child: _isExporting
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 16.w,
                                height: 16.h,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                  value: _isSavingToGallery ? null : progress,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                _isSavingToGallery
                                    ? "Saving..."
                                    : "${(progress * 100).toInt()}%",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : const Text(
                            "SAVE",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                  );
                },
              ),
            ),
          ],
        ),
        body: !_isLoaded
            ? const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              )
            : Column(
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: _showOverlay,
                    builder: (context, overlay, _) => EditorVideoPreview(
                      controller: _controller,
                      rotation: _rotation,
                      isFlipped: _isFlipped,
                      targetAspectRatio: _targetAspectRatio,
                      showOverlay: overlay,
                      onTogglePlay: _togglePlay,
                    ),
                  ),
                  Container(
                    color: const Color(0xFF121212),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ValueListenableBuilder<EditorTab>(
                          valueListenable: _activeTab,
                          builder: (context, tab, _) => Container(
                            height: 160.h,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 10.h,
                            ),
                            child: _buildTabContent(tab),
                          ),
                        ),
                        ValueListenableBuilder<EditorTab>(
                          valueListenable: _activeTab,
                          builder: (context, tab, _) => EditorTabSelector(
                            activeTab: tab,
                            onTabChanged: (newTab) =>
                                setState(() => _activeTab.value = newTab),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SafeArea(top: false, child: AdaptiveBannerWidget()),
                ],
              ),
      ),
    );
  }

  Widget _buildTabContent(EditorTab tab) {
    switch (tab) {
      case EditorTab.trim:
        return EditorTimeline(
          thumbnails: _thumbnails,
          generatingThumbnails: _generatingThumbnails,
          startTrim: _startTrim,
          endTrim: _endTrim,
          videoDuration: _videoDuration,
          onTrimChanged: (v) => setState(() {
            _startTrim = v.start;
            _endTrim = v.end;
          }),
          onTrimChangeEnd: (v) => _controller.seekTo(
            Duration(
              milliseconds: (v.start * _videoDuration.inMilliseconds).toInt(),
            ),
          ),
        );
      case EditorTab.ratio:
        return EditorRatioPanel(
          selectedRatioEnum: _selectedRatioEnum,
          onRatioChanged: (val, enm) => setState(() {
            _targetAspectRatio = val;
            _selectedRatioEnum = enm;
          }),
          onRotate: () => setState(() => _rotation = (_rotation + 90) % 360),
          onMirror: () => setState(() => _isFlipped = !_isFlipped),
        );
      case EditorTab.adjust:
        return EditorAdjustmentPanel(
          playbackSpeed: _playbackSpeed,
          removeAudio: _removeAudio,
          onSpeedChanged: (v) {
            setState(() => _playbackSpeed = v);
            _controller.setPlaybackSpeed(v);
          },
          onToggleAudio: () => setState(() => _removeAudio = !_removeAudio),
        );
    }
  }
}
