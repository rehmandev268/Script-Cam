import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter_application_6/core/utils/responsive_config.dart';
import 'glass_button.dart';
import '../../../../core/services/analytics_service.dart';

class CameraBottomControls extends StatelessWidget {
  final CameraState state;
  final bool isRecording;
  final bool isPaused;
  final bool showProControls;
  final VoidCallback onTogglePro;
  final Function(VideoRecordingCameraState) onTogglePause;
  final VoidCallback onStartRecording;
  final bool isEnabled;
  final ValueNotifier<Duration>? recordingDuration;

  const CameraBottomControls({
    super.key,
    required this.state,
    required this.isRecording,
    required this.isPaused,
    required this.showProControls,
    required this.onTogglePro,
    required this.onTogglePause,
    required this.onStartRecording,
    this.isEnabled = true,
    this.recordingDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.h, left: 24.w, right: 24.w),
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.5,
        child: state.when(
          onVideoMode: (videoState) => _IdleControls(
            state: videoState,
            showProControls: showProControls,
            onTogglePro: onTogglePro,
            onStartRecording: isEnabled ? onStartRecording : () {},
          ),
          onVideoRecordingMode: (recordingState) => _RecordingControls(
            recordingState: recordingState,
            isPaused: isPaused,
            onTogglePause: onTogglePause,
            recordingDuration: recordingDuration,
          ),
          onPreparingCamera: (_) => const SizedBox.shrink(),
          onPhotoMode: (_) => const SizedBox.shrink(),
        ),
      ),
    );
  }
}

class _IdleControls extends StatelessWidget {
  final VideoCameraState state;
  final bool showProControls;
  final VoidCallback onTogglePro;
  final VoidCallback onStartRecording;

  const _IdleControls({
    required this.state,
    required this.showProControls,
    required this.onTogglePro,
    required this.onStartRecording,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TeleprompterGlassButton(
          icon: Icons.cameraswitch_rounded,
          onTap: () {
            AnalyticsService().logCameraFlipped(cameraDirection: 'toggle');
            state.switchCameraSensor(
              aspectRatio: CameraAspectRatios.ratio_16_9,
            );
          },
        ),
        GestureDetector(
          onTap: () {
            HapticFeedback.heavyImpact();
            onStartRecording();
          },
          child: Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4.w),
              color: Colors.transparent,
            ),
            padding: EdgeInsets.all(4.w),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        TeleprompterGlassButton(
          icon: showProControls ? Icons.close : Icons.tune_rounded,
          isActive: showProControls,
          onTap: onTogglePro,
        ),
      ],
    );
  }
}

class _RecordingControls extends StatelessWidget {
  final VideoRecordingCameraState recordingState;
  final bool isPaused;
  final Function(VideoRecordingCameraState) onTogglePause;
  final ValueNotifier<Duration>? recordingDuration;

  const _RecordingControls({
    required this.recordingState,
    required this.isPaused,
    required this.onTogglePause,
    this.recordingDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TeleprompterGlassButton(
          icon: isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded,
          isActive: isPaused,
          onTap: () => onTogglePause(recordingState),
        ),
        GestureDetector(
          onTap: () {
            HapticFeedback.heavyImpact();
            recordingState.stopRecording();
          },
          child: Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4.w),
              color: Colors.transparent,
            ),
            padding: EdgeInsets.all(20.w),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ),
        if (recordingDuration != null)
          ValueListenableBuilder<Duration>(
            valueListenable: recordingDuration!,
            builder: (context, duration, _) => Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.82),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.fiber_manual_record,
                    color: Colors.white,
                    size: 11.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    "${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          SizedBox(width: 50.w),
      ],
    );
  }
}
