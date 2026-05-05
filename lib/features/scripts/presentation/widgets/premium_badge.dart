import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_config.dart';
import '../../../premium/presentation/providers/premium_provider.dart';
import '../../../premium/presentation/screen/premium_screen.dart';

class PremiumBadge extends StatelessWidget {
  const PremiumBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isPremium = Provider.of<PremiumProvider>(context).isPremium;
    if (isPremium) return const SizedBox.shrink();

    return Center(
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PremiumScreen()),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.primaryDark],
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star_rounded, size: 14.sp, color: Colors.white),
              SizedBox(width: 4.w),
              Text(
                l10n.pro,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
