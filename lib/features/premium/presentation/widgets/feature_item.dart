import 'package:flutter/material.dart';

import '../../../../core/utils/responsive_config.dart';

class FeatureItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;

  const FeatureItem({
    super.key,
    required this.text,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.sp),
        ),
        SizedBox(width: 16.w),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Icon(Icons.check_circle_rounded, color: color, size: 20.sp),
      ],
    );
  }
}
