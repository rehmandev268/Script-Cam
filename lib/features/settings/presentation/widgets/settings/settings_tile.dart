import 'package:flutter/material.dart';

import '../../../../../core/utils/responsive_config.dart';
import '../../../../../core/constants/app_constants.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? value;
  final Color color;
  final VoidCallback? onTap;
  final bool isDark;
  final Widget? trailing;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.value,
    this.trailing,
    required this.color,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, size: 20.sp, color: color),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (value != null)
                Text(
                  value!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              if (trailing != null) ...[
                SizedBox(width: 8.w),
                trailing!,
              ] else if (onTap != null) ...[
                SizedBox(width: 8.w),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14.sp,
                  color: AppColors.textGrey.withValues(alpha: 0.3),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
