import 'package:flutter/material.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final IconData backIcon = Platform.isIOS 
        ? Icons.arrow_back_ios_new_rounded 
        : Icons.arrow_back_rounded;

    Widget? effectiveLeading = leading;
    if (effectiveLeading == null && showBackButton) {
      effectiveLeading = IconButton(
        icon: Icon(
          backIcon,
          color: isDark ? AppColors.textWhite : AppColors.textBlack,
          size: 22.sp, // Responsive Size
        ),
        onPressed: onBackPressed ?? () => Navigator.pop(context),
        splashRadius: 20.r,
      );
    }

    Color titleColor;
    if (backgroundColor == Colors.black || backgroundColor == Colors.black38) {
       titleColor = Colors.white;
    } else {
       titleColor = isDark ? AppColors.textWhite : AppColors.textBlack;
    }

    return AppBar(
      backgroundColor: backgroundColor ?? (isDark ? AppColors.darkBg : AppColors.lightBg),
      elevation: 0,
      centerTitle: true,
      scrolledUnderElevation: 0,
      toolbarHeight: kToolbarHeight.h, // Responsive Height usually handled by system, but good to know
      
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.h),
        child: Container(
          color: (backgroundColor == Colors.black || backgroundColor == Colors.black38) 
              ? Colors.white12 
              : (isDark ? AppColors.borderDark : AppColors.borderLight),
          height: 1.h,
        ),
      ),

      leading: effectiveLeading,
      title: Text(
        title,
        style: GoogleFonts.manrope(
          fontSize: 17.sp, // Responsive Font
          fontWeight: FontWeight.w800,
          color: titleColor,
          letterSpacing: 0.3.w,
        ),
      ),
      actions: actions != null 
          ? [...actions!, SizedBox(width: 8.w)] 
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}