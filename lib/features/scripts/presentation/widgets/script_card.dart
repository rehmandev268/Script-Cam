import 'package:flutter/material.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_config.dart';
import '../../data/models/script_model.dart';
import 'script_menu_button.dart';

class ScriptCard extends StatelessWidget {
  final Script script;
  final Map<String, dynamic> platformStyle;
  final VoidCallback onTap;
  final VoidCallback onRecord;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ScriptCard({
    super.key,
    required this.script,
    required this.platformStyle,
    required this.onTap,
    required this.onRecord,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final wordCount = script.wordCount;
    final readTime = script.readTime;

    final Color brandColor = platformStyle['color'];
    final IconData brandIcon = platformStyle['icon'];
    final String brandName = platformStyle['name'];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : AppColors.borderLight.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.all(18.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 44.w,
                        height: 44.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              brandColor.withValues(alpha: 0.15),
                              brandColor.withValues(alpha: 0.05),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: FaIcon(
                          brandIcon,
                          color: brandColor,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              script.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.manrope(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.3,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.timer_outlined,
                                  size: 12.sp,
                                  color: AppColors.textGrey,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  "$readTime ${l10n.minRead}",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: AppColors.textGrey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Icon(
                                  Icons.notes_rounded,
                                  size: 12.sp,
                                  color: AppColors.textGrey,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  "$wordCount ${l10n.words}",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: AppColors.textGrey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ScriptMenuButton(
                        script: script,
                        onEdit: onEdit,
                        onDelete: onDelete,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.05)
                              : AppColors.lightBg,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.05)
                                : AppColors.borderLight,
                          ),
                        ),
                        child: Text(
                          (brandName == 'General' ? l10n.general : brandName)
                              .toUpperCase(),
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w800,
                            color: isDark ? Colors.white70 : AppColors.textGrey,
                            letterSpacing: 0.8.w,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: onRecord,
                        icon: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Color(0xFF63F297),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            Icons.videocam_rounded,
                            size: 24.sp,
                            color: Colors.white,
                          ),
                        ),

                        // style: ElevatedButton.styleFrom(
                        //   backgroundColor: Color(0xFF63F297),
                        //   foregroundColor: Colors.white,
                        //   elevation: 0,
                        //   fixedSize: Size(120.w, 30.h),
                        //   // padding: EdgeInsets.symmetric(
                        //   //   // horizontal: 20.w,
                        //   //   // vertical: 10.h,
                        //   // ),
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(12.r),
                        //   ),
                        // ),
                      ),
                    ],
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
