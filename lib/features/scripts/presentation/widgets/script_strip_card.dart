import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_config.dart';
import '../../data/models/script_model.dart';

class ScriptStripCard extends StatelessWidget {
  final Script script;
  final Map<String, dynamic> platformStyle;
  final VoidCallback onRecord;
  final VoidCallback onTap;

  const ScriptStripCard({
    super.key,
    required this.script,
    required this.platformStyle,
    required this.onRecord,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color brandColor = platformStyle['color'];
    final IconData brandIcon = platformStyle['icon'];
    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : AppColors.borderLight;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 220.w,
        margin: EdgeInsets.only(right: 12.w),
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    color: brandColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: FaIcon(brandIcon, color: brandColor, size: 13.sp),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    onRecord();
                  },
                  child: Container(
                    padding: EdgeInsets.all(7.r),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.videocam_rounded,
                      size: 15.sp,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              script.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.manrope(
                fontSize: 13.sp,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : AppColors.textBlack,
                height: 1.3,
                letterSpacing: -0.2,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              AppLocalizations.of(context).scriptSummary(
                '${script.readTime} min',
                '${script.wordCount} words',
              ),
              style: TextStyle(
                fontSize: 10.sp,
                color: AppColors.textGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScriptStripAddCard extends StatelessWidget {
  final VoidCallback onTap;

  const ScriptStripAddCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: Container(
        width: 100.w,
        margin: EdgeInsets.only(right: 12.w),
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isDark ? Colors.white.withValues(alpha: 0.08) : AppColors.borderLight,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 34.w,
              height: 34.h,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(Icons.add_rounded, size: 20.sp, color: AppColors.primary),
            ),
            SizedBox(height: 6.h),
            Text(
              AppLocalizations.of(context).newScriptMultiline,
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
