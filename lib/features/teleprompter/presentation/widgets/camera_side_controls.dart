import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter_application_6/core/utils/responsive_config.dart';

class CameraSideControls extends StatelessWidget {
  final CameraState state;
  final double currentBrightness;
  final double currentZoom;
  final ValueChanged<double> onBrightnessChanged;
  final ValueChanged<double> onZoomChanged;

  const CameraSideControls({
    super.key,
    required this.state,
    required this.currentBrightness,
    required this.currentZoom,
    required this.onBrightnessChanged,
    required this.onZoomChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(right: 16.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12.r, sigmaY: 12.r),
            child: Container(
              width: 56.w,
              height: 280.h,
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 8.w),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 1.w,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.wb_sunny_rounded,
                    color: Colors.amber,
                    size: 20.sp,
                  ),
                  Expanded(
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 4.h,
                          thumbShape: RoundSliderThumbShape(
                            enabledThumbRadius: 8.r,
                          ),
                          overlayShape: SliderComponentShape.noOverlay,
                          activeTrackColor: Colors.amber,
                          inactiveTrackColor: Colors.white24,
                          thumbColor: Colors.white,
                        ),
                        child: Slider(
                          value: currentBrightness,
                          min: 0.0,
                          max: 1.0,
                          onChanged: (val) {
                            onBrightnessChanged(val);
                            state.sensorConfig.setBrightness(val);
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(width: 24.w, height: 1.h, color: Colors.white12),
                  SizedBox(height: 12.h),
                  _ZoomToggle(
                    label: "2x",
                    isActive: currentZoom > 0.1,
                    onTap: () {
                      onZoomChanged(0.5);
                      state.sensorConfig.setZoom(0.5);
                    },
                  ),
                  SizedBox(height: 10.h),
                  _ZoomToggle(
                    label: "1x",
                    isActive: currentZoom <= 0.1,
                    onTap: () {
                      onZoomChanged(0.0);
                      state.sensorConfig.setZoom(0.0);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ZoomToggle extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _ZoomToggle({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 36.w,
        height: 36.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.black.withValues(alpha: 0.3),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white30, width: 1.w),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }
}
