import 'package:flutter/material.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_config.dart';
import '../providers/premium_provider.dart';

class PurchaseSuccessScreen extends StatelessWidget {
  const PurchaseSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final keys = context.read<PremiumProvider>().unlockedFeatureKeys;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 24.h),
          child: Column(
            children: [
              const Spacer(),
              Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 88.sp),
              SizedBox(height: 16.h),
              Text(
                l10n.youAreNowPremium,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 10.h),
              Text(
                l10n.unlockAllFeatures,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, color: AppColors.textGrey),
              ),
              SizedBox(height: 24.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                alignment: WrapAlignment.center,
                children: keys.take(4).map((e) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(e, style: TextStyle(fontSize: 12.sp)),
                  );
                }).toList(),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(l10n.continueButton),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
