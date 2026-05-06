import 'package:flutter/material.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_config.dart';
import '../../../../widgets/common/adaptive_app_bar.dart';
import '../providers/premium_provider.dart';

class PremiumDetailsScreen extends StatelessWidget {
  const PremiumDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AdaptiveAppBar(title: l10n.premiumActive),
      body: SafeArea(
        top: false,
        child: Consumer<PremiumProvider>(
          builder: (context, provider, _) {
            return Padding(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
              child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkSurface : Colors.white,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: isDark ? AppColors.borderDark : AppColors.borderLight,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.workspace_premium_rounded,
                        color: AppColors.primary,
                        size: 26.sp,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          provider.planTypeKey == 'lifetimePlan'
                              ? l10n.lifetimePlan
                              : 'Weekly Plan',
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkSurface : Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: isDark ? AppColors.borderDark : AppColors.borderLight,
                      ),
                    ),
                    child: ListView(
                      children: provider.unlockedFeatureKeys.map((key) {
                        String text = key;
                        if (key == 'unlimitedRecordings') text = l10n.unlimitedRecordings;
                        if (key == 'noAds') text = l10n.noAds;
                        if (key == 'voiceSyncFeature') text = l10n.voiceSyncFeature;
                        if (key == 'cloudBackup') text = l10n.cloudBackup;
                        if (key == 'highQualityVideo') text = l10n.highQualityVideo;
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle_rounded,
                                color: AppColors.primary,
                                size: 18.sp,
                              ),
                              SizedBox(width: 10.w),
                              Expanded(child: Text(text)),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
              ),
            );
          },
        ),
      ),
    );
  }
}
