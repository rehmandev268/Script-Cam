import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_config.dart';

class TeleprompterGlassButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool isActive;
  final double size;

  const TeleprompterGlassButton({
    super.key,
    required this.icon,
    this.onTap,
    this.isActive = false,
    this.size = 50,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8.r, sigmaY: 8.r),
          child: Container(
            width: size.w,
            height: size.h,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primary
                  : Colors.black.withValues(alpha: 0.3),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white24, width: 1.w),
            ),
            child: Icon(icon, color: Colors.white, size: size * 0.48),
          ),
        ),
      ),
    );
  }
}
