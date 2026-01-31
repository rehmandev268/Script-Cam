import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_config.dart';
import '../providers/scripts_provider.dart';

class EmptyScriptsState extends StatelessWidget {
  final String selectedCategory;

  const EmptyScriptsState({super.key, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    final isSearching = context.select<ScriptsProvider, bool>(
      (p) => p.isSearching,
    );
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 80.h),
            Container(
              padding: EdgeInsets.all(24.r),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSearching
                    ? Icons.search_off_rounded
                    : Icons.description_outlined,
                size: 60.sp,
                color: AppColors.primary.withValues(alpha: 0.4),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              isSearching ? "No results found" : "Start Your Journey",
              style: GoogleFonts.manrope(
                color: isDark ? Colors.white : AppColors.textBlack,
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              isSearching
                  ? "We couldn't find any scripts matching your search. Try different keywords!"
                  : "Your creative space is empty. Create your first script or try recording something on the fly!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textGrey,
                fontSize: 14.sp,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (!isSearching) ...[
              SizedBox(height: 32.h),
              // We could add a "Create First Script" button here,
              // but since the FAB or main action cards are present, we'll keep it clean.
            ],
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }
}
