import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_application_6/core/utils/responsive_config.dart';

class EditorVideoPreview extends StatelessWidget {
  final VideoPlayerController controller;
  final int rotation;
  final bool isFlipped;
  final double? targetAspectRatio;
  final bool showOverlay;
  final VoidCallback onTogglePlay;

  const EditorVideoPreview({
    super.key,
    required this.controller,
    required this.rotation,
    required this.isFlipped,
    this.targetAspectRatio,
    required this.showOverlay,
    required this.onTogglePlay,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            _VideoArea(
              controller: controller,
              rotation: rotation,
              isFlipped: isFlipped,
              targetAspectRatio: targetAspectRatio,
            ),

            _PlayOverlay(
              controller: controller,
              showOverlay: showOverlay,
              onTogglePlay: onTogglePlay,
            ),
          ],
        ),
      ),
    );
  }
}

class _VideoArea extends StatelessWidget {
  final VideoPlayerController controller;
  final int rotation;
  final bool isFlipped;
  final double? targetAspectRatio;

  const _VideoArea({
    required this.controller,
    required this.rotation,
    required this.isFlipped,
    this.targetAspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double videoRatio = controller.value.aspectRatio;
        if (rotation == 90 || rotation == 270) {
          videoRatio = 1 / videoRatio;
        }
        final double displayRatio = targetAspectRatio ?? videoRatio;

        return AspectRatio(
          aspectRatio: displayRatio,
          child: ClipRect(
            child: Transform.rotate(
              angle: rotation * math.pi / 180,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.diagonal3Values(
                  isFlipped ? -1.0 : 1.0,
                  1.0,
                  1.0,
                ),
                child: FittedBox(
                  fit: targetAspectRatio != null ? BoxFit.fill : BoxFit.contain,
                  child: SizedBox(
                    width: controller.value.size.width,
                    height: controller.value.size.height,
                    child: VideoPlayer(controller),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PlayOverlay extends StatelessWidget {
  final VideoPlayerController controller;
  final bool showOverlay;
  final VoidCallback onTogglePlay;

  const _PlayOverlay({
    required this.controller,
    required this.showOverlay,
    required this.onTogglePlay,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final isPlaying = controller.value.isPlaying;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTogglePlay,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const SizedBox.expand(),
              IgnorePointer(
                child: AnimatedOpacity(
                  opacity: showOverlay || !isPlaying ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    padding: const EdgeInsets.all(16).r,
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 32.sp,
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
}
