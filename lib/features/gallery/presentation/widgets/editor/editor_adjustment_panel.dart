import 'package:flutter/material.dart';
import 'package:flutter_application_6/core/utils/responsive_config.dart';
import 'package:flutter_application_6/core/constants/app_constants.dart';

class EditorAdjustmentPanel extends StatelessWidget {
  final double playbackSpeed;
  final bool removeAudio;
  final ValueChanged<double> onSpeedChanged;
  final VoidCallback onToggleAudio;

  const EditorAdjustmentPanel({
    super.key,
    required this.playbackSpeed,
    required this.removeAudio,
    required this.onSpeedChanged,
    required this.onToggleAudio,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Speed",
                    style: TextStyle(color: Colors.white54, fontSize: 12.sp),
                  ),
                  Text(
                    "${playbackSpeed.toStringAsFixed(1)}x",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              Slider(
                value: playbackSpeed,
                min: 0.5,
                max: 2.0,
                divisions: 6,
                activeColor: AppColors.primary,
                thumbColor: Colors.white,
                label: "${playbackSpeed.toStringAsFixed(1)}x",
                onChanged: onSpeedChanged,
              ),
            ],
          ),
        ),
        SizedBox(width: 20.w),

        _AdjustToggle(
          icon: removeAudio ? Icons.volume_off : Icons.volume_up,
          label: "Mute",
          isActive: removeAudio,
          activeColor: Colors.red,
          onTap: onToggleAudio,
        ),
      ],
    );
  }
}

class _AdjustToggle extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final Color? activeColor;

  const _AdjustToggle({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveActiveColor = activeColor ?? AppColors.primary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12).r,
        decoration: BoxDecoration(
          color: isActive
              ? effectiveActiveColor.withValues(alpha: 0.2)
              : Colors.grey[800],
          borderRadius: BorderRadius.circular(12).r,
          border: isActive ? Border.all(color: effectiveActiveColor) : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive ? effectiveActiveColor : Colors.white,
              size: 20.sp,
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 10.sp),
            ),
          ],
        ),
      ),
    );
  }
}
