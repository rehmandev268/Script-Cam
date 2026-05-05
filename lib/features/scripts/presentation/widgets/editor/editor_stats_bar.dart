import 'package:flutter/material.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/utils/responsive_config.dart';
import 'stats_pill.dart';

class EditorStatsBar extends StatelessWidget {
  final int wordCount;
  final int durationSeconds;
  final VoidCallback onPaste;
  final VoidCallback onImport;
  final VoidCallback? onTemplates;

  const EditorStatsBar({
    super.key,
    required this.wordCount,
    required this.durationSeconds,
    required this.onPaste,
    required this.onImport,
    this.onTemplates,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pillColor = isDark ? AppColors.darkSurface : Colors.white;
    final textColor = isDark ? AppColors.textWhite70 : AppColors.textGrey;
    final actionColor = isDark ? Colors.white : AppColors.primary;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      color: isDark ? AppColors.darkBg : Colors.transparent,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width - 48.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StatsPill(
                    icon: Icons.text_fields,
                    text: AppLocalizations.of(
                      context,
                    ).wordCountShort(wordCount),
                    backgroundColor: pillColor,
                    textColor: textColor,
                  ),
                  SizedBox(width: 10.w),
                  StatsPill(
                    icon: Icons.timer_outlined,
                    text: _formatDuration(context, durationSeconds),
                    backgroundColor: pillColor,
                    textColor: textColor,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (onTemplates != null)
                    InkWell(
                      onTap: onTemplates,
                      borderRadius: BorderRadius.circular(8.r),
                      child: Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: Row(
                          children: [
                            Icon(
                              Icons.auto_awesome_rounded,
                              size: 16.sp,
                              color: actionColor,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Templates',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                                color: actionColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (onTemplates != null) SizedBox(width: 8.w),
                  InkWell(
                    onTap: onImport,
                    borderRadius: BorderRadius.circular(8.r),
                    child: Padding(
                      padding: EdgeInsets.all(8.0.r),
                      child: Row(
                        children: [
                          Icon(
                            Icons.file_upload_outlined,
                            size: 16.sp,
                            color: actionColor,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            AppLocalizations.of(context).importScript,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                              color: actionColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  InkWell(
                    onTap: onPaste,
                    borderRadius: BorderRadius.circular(8.r),
                    child: Padding(
                      padding: EdgeInsets.all(8.0.r),
                      child: Row(
                        children: [
                          Icon(
                            Icons.paste_rounded,
                            size: 16.sp,
                            color: actionColor,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            AppLocalizations.of(context).paste,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                              color: actionColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(BuildContext context, int totalSeconds) {
    if (totalSeconds < 60) {
      return AppLocalizations.of(context).durationSecondsShort(totalSeconds);
    }
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return AppLocalizations.of(
      context,
    ).durationMinutesSecondsShort(minutes, seconds);
  }
}
