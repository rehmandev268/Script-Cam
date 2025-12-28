import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../core/constants/app_constants.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;

  // NEW: Custom properties to override defaults
  final Color? color;
  final BoxBorder? border;

  const GlassContainer({
    super.key,
    required this.child,
    this.blur = 10,
    this.opacity = 0.08,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.onTap,
    this.color, // <--- Added
    this.border, // <--- Added
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // LOGIC: If a custom color is passed, use it with the specified opacity.
    // Otherwise, use the default glass style (White for Dark mode, Black for Light mode).
    final effectiveColor = color != null
        ? color!.withOpacity(opacity)
        : (isDark ? Colors.white : Colors.black).withOpacity(opacity);

    // LOGIC: If a custom border is passed, use it. Otherwise use default.
    final effectiveBorder =
        border ?? Border.all(color: isDark ? Colors.white12 : Colors.black12);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Container(
              padding: padding,
              decoration: BoxDecoration(
                color: effectiveColor,
                border: effectiveBorder,
                borderRadius: BorderRadius.circular(24),
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
        barrierColor: Colors.black.withOpacity(0.6),
        builder: (context) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: ZoomIn(
            duration: const Duration(milliseconds: 200),
            child: Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1E1E1E).withOpacity(0.95)
                      : Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark ? Colors.white12 : Colors.black12,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color:
                            (isDestructive
                                    ? Colors.redAccent
                                    : AppColors.primary)
                                .withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isDestructive ? Icons.delete_forever : Icons.info,
                        color: isDestructive
                            ? Colors.redAccent
                            : AppColors.primary,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      content,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.black54,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: isDark ? Colors.white54 : Colors.black45,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDestructive
                                  ? Colors.redAccent
                                  : AppColors.primary,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            onPressed: () => Navigator.pop(context, true),
                            child: Text(
                              confirmText,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
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
        ),
      ) ??
      false;
}
