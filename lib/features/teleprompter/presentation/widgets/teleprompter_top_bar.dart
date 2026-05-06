import 'package:flutter/material.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter_application_6/core/utils/responsive_config.dart';
import 'glass_button.dart';
import '../../../../core/services/analytics_service.dart';

class TeleprompterTopBar extends StatelessWidget {
  final CameraState state;
  final bool isRecording;
  final bool isReadingScript;
  final Duration recordingDuration;
  final Duration readingDuration;
  final VoidCallback onBack;
  final VoidCallback onShowSettings;
  final String Function(Duration) formatDuration;

  const TeleprompterTopBar({
    super.key,
    required this.state,
    required this.isRecording,
    this.isReadingScript = false,
    required this.recordingDuration,
    this.readingDuration = Duration.zero,
    required this.onBack,
    required this.onShowSettings,
    required this.formatDuration,
  });

  @override
  Widget build(BuildContext context) {
    if (isRecording) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TeleprompterGlassButton(icon: Icons.arrow_back, onTap: onBack),
          if (isReadingScript)
            _ReadTimerDisplay(
              duration: readingDuration,
              formatDuration: formatDuration,
            ),
          Row(
            children: [
              TeleprompterGlassButton(
                icon: Icons.settings,
                onTap: onShowSettings,
              ),
              SizedBox(width: 12.w),
              _FlashToggle(state: state),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReadTimerDisplay extends StatelessWidget {
  final Duration duration;
  final String Function(Duration) formatDuration;

  const _ReadTimerDisplay({
    required this.duration,
    required this.formatDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.timer_outlined, color: Colors.white70, size: 13.sp),
          SizedBox(width: 6.w),
          Text(
            formatDuration(duration),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _FlashToggle extends StatelessWidget {
  final CameraState state;

  const _FlashToggle({required this.state});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlashMode>(
      stream: state.sensorConfig.flashMode$,
      builder: (context, snapshot) {
        final flashMode = snapshot.data ?? FlashMode.none;
        final hasFlash = flashMode != FlashMode.none;
        return TeleprompterGlassButton(
          icon: hasFlash ? Icons.flash_on : Icons.flash_off,
          isActive: hasFlash,
          onTap: () {
            final nextFlash = hasFlash ? FlashMode.none : FlashMode.always;
            AnalyticsService().logFlashToggled(
              enabled: nextFlash == FlashMode.always,
            );
            state.sensorConfig.setFlashMode(nextFlash);
          },
        );
      },
    );
  }
}
