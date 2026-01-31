import 'package:flutter/material.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/utils/responsive_config.dart';
import 'stats_pill.dart';

class EditorStatsBar extends StatelessWidget {
  final int wordCount;
  final String estDuration;
  final VoidCallback onPaste;

  const EditorStatsBar({
    super.key,
    required this.wordCount,
    required this.estDuration,
    required this.onPaste,
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
      child: Row(
        children: [
          StatsPill(
            icon: Icons.text_fields,
            text: "$wordCount w",
            backgroundColor: pillColor,
            textColor: textColor,
          ),
          SizedBox(width: 10.w),
          StatsPill(
            icon: Icons.timer_outlined,
            text: estDuration,
            backgroundColor: pillColor,
            textColor: textColor,
          ),
          const Spacer(),
          InkWell(
            onTap: onPaste,
            borderRadius: BorderRadius.circular(8.r),
            child: Padding(
              padding: EdgeInsets.all(8.0.r),
              child: Row(
                children: [
                  Icon(Icons.paste_rounded, size: 16.sp, color: actionColor),
                  SizedBox(width: 4.w),
                  Text(
                    "Paste",
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
    );
  }
}
