import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io' show Platform;
import '../../core/constants/app_constants.dart';
import '../../core/utils/responsive_config.dart';

class AdaptiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;

  const AdaptiveAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.showBackButton = true,
    this.onBackPressed,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSystemDark = theme.brightness == Brightness.dark;

    final Color effectiveBackgroundColor =
        backgroundColor ??
        (isSystemDark ? AppColors.darkBg : AppColors.lightBg);

    final bool isDarkBackground =
        ThemeData.estimateBrightnessForColor(effectiveBackgroundColor) ==
        Brightness.dark;

    final Color contentColor = isDarkBackground
        ? Colors.white
        : AppColors.textBlack;

    final SystemUiOverlayStyle overlayStyle = isDarkBackground
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;

    final IconData backIcon = Platform.isIOS
        ? Icons.arrow_back_ios_new_rounded
        : Icons.arrow_back_rounded;

    Widget? effectiveLeading = leading;
    if (effectiveLeading == null && showBackButton) {
      effectiveLeading = IconButton(
        icon: Icon(backIcon, color: contentColor, size: 22.sp),
        onPressed: onBackPressed ?? () => Navigator.pop(context),
        splashRadius: 20.r,
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: AppBar(
        automaticallyImplyLeading: showBackButton,
        backgroundColor: effectiveBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: kToolbarHeight.h,
        systemOverlayStyle: overlayStyle,

        iconTheme: IconThemeData(color: contentColor, size: 22.sp),
        actionsIconTheme: IconThemeData(color: contentColor, size: 22.sp),

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(
            height: 1.h,
            color: isDarkBackground
                ? Colors.white12
                : (isSystemDark ? AppColors.borderDark : AppColors.borderLight),
          ),
        ),

        leading: effectiveLeading,
        title: Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 20.sp,
            fontWeight: FontWeight.w800,
            color: contentColor,
            letterSpacing: 0.25,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: actions != null ? [...actions!, SizedBox(width: 8.w)] : null,
      ),
    );
  }

  /// Must match [AppBar.toolbarHeight] plus divider [bottom].
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h + 1.h);
}
