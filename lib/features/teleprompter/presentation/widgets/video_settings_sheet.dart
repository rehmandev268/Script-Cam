import 'package:flutter/material.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:camerawesome/pigeon.dart';
import 'package:flutter_application_6/core/utils/responsive_config.dart';
import '../../../../core/constants/app_constants.dart';

class VideoSettingsSheet extends StatelessWidget {
  final CameraState state;
  final VideoRecordingQuality videoQuality;
  final int targetFps;
  final int countdownDuration;
  final Function(VideoRecordingQuality) onQualityChanged;
  final Function(int) onFpsChanged;
  final Function(int) onCountdownChanged;

  const VideoSettingsSheet({
    super.key,
    required this.state,
    required this.videoQuality,
    required this.targetFps,
    required this.countdownDuration,
    required this.onQualityChanged,
    required this.onFpsChanged,
    required this.onCountdownChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
            AppLocalizations.of(context).videoSettings,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            AppLocalizations.of(context).resolution,
            style: TextStyle(color: Colors.white70, fontSize: 14.sp),
          ),
          SizedBox(height: 12.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _QualityOption(
                  label: "SD",
                  quality: VideoRecordingQuality.sd,
                  isSelected: videoQuality == VideoRecordingQuality.sd,
                  onTap: () {
                    onQualityChanged(VideoRecordingQuality.sd);
                    Navigator.pop(context);
                  },
                ),
                _QualityOption(
                  label: "HD",
                  quality: VideoRecordingQuality.hd,
                  isSelected: videoQuality == VideoRecordingQuality.hd,
                  onTap: () {
                    onQualityChanged(VideoRecordingQuality.hd);
                    Navigator.pop(context);
                  },
                ),
                _QualityOption(
                  label: "FHD",
                  quality: VideoRecordingQuality.fhd,
                  isSelected: videoQuality == VideoRecordingQuality.fhd,
                  onTap: () {
                    onQualityChanged(VideoRecordingQuality.fhd);
                    Navigator.pop(context);
                  },
                ),
                _QualityOption(
                  label: "4K",
                  quality: VideoRecordingQuality.uhd,
                  isSelected: videoQuality == VideoRecordingQuality.uhd,
                  onTap: () {
                    onQualityChanged(VideoRecordingQuality.uhd);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            AppLocalizations.of(context).targetFps,
            style: TextStyle(color: Colors.white70, fontSize: 14.sp),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              _FpsOption(
                fps: 30,
                isSelected: targetFps == 30,
                onTap: () {
                  onFpsChanged(30);
                  Navigator.pop(context);
                },
              ),
              SizedBox(width: 12.w),
              _FpsOption(
                fps: 60,
                isSelected: targetFps == 60,
                onTap: () {
                  onFpsChanged(60);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Text(
            AppLocalizations.of(context).countdownTimer,
            style: TextStyle(color: Colors.white70, fontSize: 14.sp),
          ),
          SizedBox(height: 12.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _CountdownOption(
                  label: AppLocalizations.of(context).off,
                  duration: 0,
                  isSelected: countdownDuration == 0,
                  onTap: () {
                    onCountdownChanged(0);
                    Navigator.pop(context);
                  },
                ),
                _CountdownOption(
                  label: "3s",
                  duration: 3,
                  isSelected: countdownDuration == 3,
                  onTap: () {
                    onCountdownChanged(3);
                    Navigator.pop(context);
                  },
                ),
                _CountdownOption(
                  label: "5s",
                  duration: 5,
                  isSelected: countdownDuration == 5,
                  onTap: () {
                    onCountdownChanged(5);
                    Navigator.pop(context);
                  },
                ),
                _CountdownOption(
                  label: "10s",
                  duration: 10,
                  isSelected: countdownDuration == 10,
                  onTap: () {
                    onCountdownChanged(10);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}

class _CountdownOption extends StatelessWidget {
  final String label;
  final int duration;
  final bool isSelected;
  final VoidCallback onTap;

  const _CountdownOption({
    required this.label,
    required this.duration,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 12.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white10,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.white24,
            width: 1.w,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _QualityOption extends StatelessWidget {
  final String label;
  final VideoRecordingQuality quality;
  final bool isSelected;
  final VoidCallback onTap;

  const _QualityOption({
    required this.label,
    required this.quality,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 12.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white10,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.white24,
            width: 1.w,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _FpsOption extends StatelessWidget {
  final int fps;
  final bool isSelected;
  final VoidCallback onTap;

  const _FpsOption({
    required this.fps,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white10,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.white24,
            width: 1.w,
          ),
        ),
        child: Text(
          "$fps FPS",
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}
