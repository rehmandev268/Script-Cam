import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/responsive_config.dart';
import '../../../../../core/constants/app_constants.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.w, bottom: 8.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title.toUpperCase(),
          style: GoogleFonts.manrope(
            fontSize: 11.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.textGrey,
            letterSpacing: 1.0.w,
          ),
        ),
      ),
    );
  }
}
