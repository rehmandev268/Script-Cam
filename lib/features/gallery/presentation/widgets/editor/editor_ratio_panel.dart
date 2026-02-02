import 'package:flutter/material.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import 'package:flutter_application_6/core/utils/responsive_config.dart';
import 'package:flutter_application_6/core/constants/app_constants.dart';
import 'package:easy_video_editor/easy_video_editor.dart';

class EditorRatioPanel extends StatelessWidget {
  final VideoAspectRatio? selectedRatioEnum;
  final Function(double?, VideoAspectRatio?) onRatioChanged;
  final VoidCallback onRotate;
  final VoidCallback onMirror;

  const EditorRatioPanel({
    super.key,
    required this.selectedRatioEnum,
    required this.onRatioChanged,
    required this.onRotate,
    required this.onMirror,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.transform,
          style: TextStyle(color: Colors.white54, fontSize: 12.sp),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 80.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _ActionButton(
                icon: Icons.rotate_right,
                label: l10n.rotate,
                onTap: onRotate,
              ),
              SizedBox(width: 12.w),
              _ActionButton(
                icon: Icons.flip,
                label: l10n.mirror,
                onTap: onMirror,
              ),
              SizedBox(width: 20.w),
              _RatioButton(
                label: l10n.original,
                ratioVal: null,
                ratioEnum: null,
                icon: Icons.crop_original,
                isSelected: selectedRatioEnum == null,
                onTap: onRatioChanged,
              ),
              _RatioButton(
                label: "1:1",
                ratioVal: 1.0,
                ratioEnum: VideoAspectRatio.ratio1x1,
                icon: Icons.crop_square,
                isSelected: selectedRatioEnum == VideoAspectRatio.ratio1x1,
                onTap: onRatioChanged,
              ),
              _RatioButton(
                label: "16:9",
                ratioVal: 16 / 9,
                ratioEnum: VideoAspectRatio.ratio16x9,
                icon: Icons.crop_landscape,
                isSelected: selectedRatioEnum == VideoAspectRatio.ratio16x9,
                onTap: onRatioChanged,
              ),
              _RatioButton(
                label: "9:16",
                ratioVal: 9 / 16,
                ratioEnum: VideoAspectRatio.ratio9x16,
                icon: Icons.crop_portrait,
                isSelected: selectedRatioEnum == VideoAspectRatio.ratio9x16,
                onTap: onRatioChanged,
              ),
              _RatioButton(
                label: "4:3",
                ratioVal: 4 / 3,
                ratioEnum: VideoAspectRatio.ratio4x3,
                icon: Icons.aspect_ratio,
                isSelected: selectedRatioEnum == VideoAspectRatio.ratio4x3,
                onTap: onRatioChanged,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70.w,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20.sp),
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

class _RatioButton extends StatelessWidget {
  final String label;
  final double? ratioVal;
  final VideoAspectRatio? ratioEnum;
  final IconData icon;
  final bool isSelected;
  final Function(double?, VideoAspectRatio?) onTap;

  const _RatioButton({
    required this.label,
    required this.ratioVal,
    required this.ratioEnum,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(ratioVal, ratioEnum),
      child: Container(
        width: 70.w,
        margin: EdgeInsets.only(right: 12.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.grey[800],
          borderRadius: BorderRadius.circular(8.r),
          border: isSelected ? Border.all(color: Colors.white, width: 1) : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20.sp),
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
