import 'package:flutter/material.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:camerawesome/pigeon.dart';
import 'package:flutter_application_6/core/utils/responsive_config.dart';
import '../../../../core/constants/app_constants.dart';

class VideoSettingsSheet extends StatelessWidget {
  final CameraState state;
  final VideoRecordingQuality videoQuality;
  final int targetFps;
  final Function(VideoRecordingQuality) onQualityChanged;
  final Function(int) onFpsChanged;

  const VideoSettingsSheet({
    super.key,
    required this.state,
    required this.videoQuality,
    required this.targetFps,
    required this.onQualityChanged,
    required this.onFpsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            "Video Quality",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            "Resolution",
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
            "Target FPS",
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
        ],
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
