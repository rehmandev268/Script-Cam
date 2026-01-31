import 'package:flutter/material.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/theme/theme_provider.dart';
import '../../../../../core/utils/responsive_config.dart';

class ThemeOption extends StatelessWidget {
  final ThemeProvider provider;
  final String title;
  final IconData icon;
  final ThemeMode mode;

  const ThemeOption({
    super.key,
    required this.provider,
    required this.title,
    required this.icon,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = provider.themeMode == mode;

    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          icon,
          color: isSelected ? AppColors.primary : Colors.grey,
          size: 24.sp,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: AppColors.primary, size: 24.sp)
          : null,
      onTap: () {
        provider.setThemeMode(mode);
        Navigator.pop(context);
      },
    );
  }
}
