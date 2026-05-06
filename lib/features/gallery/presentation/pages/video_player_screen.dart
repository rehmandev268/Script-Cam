import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_config.dart';
import '../../../../widgets/common/adaptive_app_bar.dart';
import 'video_editor_screen.dart';

class FullScreenVideoPlayer extends StatefulWidget {
  final String path;
  const FullScreenVideoPlayer({super.key, required this.path});

  @override
  State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _showControls = true;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) {
        if (!mounted) return;
        setState(() {});
        _play();
      });
    _startHideTimer();
  }

  void _play() {
    _controller.play();
    setState(() => _isPlaying = true);
    _startHideTimer();
  }

  void _pause() {
    _controller.pause();
    setState(() => _isPlaying = false);
    _hideTimer?.cancel();
    setState(() => _showControls = true);
  }

  void _toggleControls() {
    setState(() => _showControls = !_showControls);
    if (_showControls && _isPlaying) _startHideTimer();
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      if (_isPlaying && mounted) setState(() => _showControls = false);
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,

      appBar: _showControls
          ? AdaptiveAppBar(
              title: "",
              showBackButton: true,
              backgroundColor: Colors.black38,
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: () {
                    _pause();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ProfessionalVideoEditor(file: File(widget.path)),
                      ),
                    );
                  },
                ),
              ],
            )
          : null,

      body: SafeArea(
        child: GestureDetector(
          onTap: _toggleControls,
          child: Stack(
            alignment: Alignment.center,
            children: [
            Center(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : const CircularProgressIndicator(color: AppColors.primary),
            ),
            AnimatedOpacity(
              opacity: _showControls ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                color: Colors.black38,
                child: Column(
                  children: [
                    const Spacer(),
                    IconButton(
                      iconSize: 80.sp,
                      icon: Icon(
                        _isPlaying
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_fill,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                      onPressed: _isPlaying ? _pause : _play,
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 30.h,
                      ),
                      child: ValueListenableBuilder(
                        valueListenable: _controller,
                        builder: (context, value, _) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _formatDuration(value.position),
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  Text(
                                    _formatDuration(value.duration),
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              SliderTheme(
                                data: SliderThemeData(
                                  thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 8,
                                  ),
                                  thumbColor: AppColors.primary,
                                  activeTrackColor: AppColors.primary,
                                  inactiveTrackColor: Colors.white24,
                                ),
                                child: Slider(
                                  value: value.position.inSeconds.toDouble(),
                                  min: 0.0,
                                  max: value.duration.inSeconds.toDouble(),
                                  onChanged: (value) {
                                    _controller.seekTo(
                                      Duration(seconds: value.toInt()),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
