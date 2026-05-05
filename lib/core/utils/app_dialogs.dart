import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import '../constants/app_constants.dart';
import '../utils/responsive_config.dart';

class AppDialogs {
  static Future<void> showAppInfo({
    required BuildContext context,
    required bool isDark,
  }) async {
    final packageInfo = await PackageInfo.fromPlatform();
    final version = packageInfo.version;

    if (!context.mounted) return;

    final l10n = AppLocalizations.of(context);

    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark
            ? AppColors.darkSurface
            : AppColors.lightSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        elevation: 0,
        contentPadding: EdgeInsets.all(24.r),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.movie_filter_rounded,
                size: 40.sp,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              l10n.appInfoTitle,
              style: GoogleFonts.manrope(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              "${l10n.version} $version",
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.textGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              l10n.appInfoDescription,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textGrey,
                height: 1.5,
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text(l10n.close),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<bool> showConfirmDelete({
    required BuildContext context,
    required String title,
    required String content,
    required bool isDark,
  }) async {
    final l10n = AppLocalizations.of(context);
    return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: isDark
                ? AppColors.darkSurface
                : AppColors.lightSurface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            elevation: 0,
            title: Text(
              title,
              style: GoogleFonts.manrope(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              content,
              style: TextStyle(fontSize: 14.sp, color: AppColors.textGrey),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(l10n.cancel),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  foregroundColor: Colors.white,
                  minimumSize: Size(100.w, 44.h),
                ),
                child: Text(l10n.delete),
              ),
            ],
          ),
        ) ??
        false;
  }
}
