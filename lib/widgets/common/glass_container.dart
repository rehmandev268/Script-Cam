import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/responsive_config.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;

  final Color? color;
  final BoxBorder? border;

  const GlassContainer({
    super.key,
    required this.child,
    this.blur = 10,
    this.opacity = 0.08,
    this.padding,
    this.margin,
    this.onTap,
    this.color,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final effectiveColor = color != null
        ? color!.withValues(alpha: opacity)
        : (isDark ? Colors.white : Colors.black).withValues(alpha: opacity);

    final effectiveBorder =
        border ?? Border.all(color: isDark ? Colors.white12 : Colors.black12);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Container(
              padding: padding ?? EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: effectiveColor,
                border: effectiveBorder,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> showGlassConfirmDialog(
  BuildContext context, {
  required String title,
  required String content,
  required String confirmText,
  bool isDestructive = false,
}) async {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return await showDialog(
        context: context,
        barrierColor: Colors.black.withValues(alpha: 0.6),
        builder: (context) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.r, sigmaY: 5.r),
          child: Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1E1E1E).withValues(alpha: 0.95)
                      : Colors.white.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isDark ? Colors.white12 : Colors.black12,
                  ),
                ),
                padding: EdgeInsets.all(24.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color:
                            (isDestructive
                                    ? Colors.redAccent
                                    : AppColors.primary)
                                .withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isDestructive ? Icons.delete_forever : Icons.info,
                        color: isDestructive
                            ? Colors.redAccent
                            : AppColors.primary,
                        size: 32.sp,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      content,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.black54,
                        fontSize: 14.sp,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text(
                              AppLocalizations.of(context).cancel,
                              style: TextStyle(
                                color: isDark ? Colors.white54 : Colors.black45,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDestructive
                                  ? Colors.redAccent
                                  : AppColors.primary,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                            ),
                            onPressed: () => Navigator.pop(context, true),
                            child: Text(
                              confirmText,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ),
      ) ??
      false;
}
