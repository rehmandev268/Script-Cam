import 'package:flutter/material.dart';

import '../../../../../core/utils/responsive_config.dart';
import '../../../../../core/constants/app_constants.dart';

class SettingsGroup extends StatelessWidget {
  final List<Widget> children;
  final bool isDark;

  const SettingsGroup({
    super.key,
    required this.children,
    required this.isDark,
  });

  BoxDecoration _groupDecoration(bool isDark) {
    return BoxDecoration(
      color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      borderRadius: BorderRadius.circular(16.r),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _groupDecoration(isDark),
      child: Column(children: children),
    );
  }
}
