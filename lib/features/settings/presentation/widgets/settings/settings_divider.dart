import 'package:flutter/material.dart';

import '../../../../../core/utils/responsive_config.dart';

class SettingsDivider extends StatelessWidget {
  final bool isDark;

  const SettingsDivider({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1.h,
      thickness: 1.h,
      color: isDark
          ? Colors.white.withValues(alpha: 0.05)
          : Colors.grey.shade100,
      indent: 56.w,
    );
  }
}
