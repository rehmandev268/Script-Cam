import 'package:flutter/material.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import 'package:flutter_application_6/core/constants/app_constants.dart';
import 'package:flutter_application_6/core/utils/responsive_config.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_application_6/core/services/ads_service/rewarded_ad_helper.dart';

class RewardedAdDialog extends StatefulWidget {
  const RewardedAdDialog({super.key});

  @override
  State<RewardedAdDialog> createState() => _RewardedAdDialogState();
}

class _RewardedAdDialogState extends State<RewardedAdDialog> {
  bool _isLoading = false;

  Future<void> _handleWatchAd() async {
    if (_isLoading) return;

    if (RewardedAdHelper.isAdLoaded) {
      if (mounted) Navigator.pop(context, 'watch');
      return;
    }

    setState(() => _isLoading = true);

    try {
      await RewardedAdHelper.loadAd();
    } catch (e) {
      debugPrint("Error loading ad in dialog: $e");
    }

    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.pop(context, 'watch');
    }
  }

  void _handlePremium() {
    if (mounted) Navigator.pop(context, 'premium');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 24.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.close_rounded,
                  size: 22.sp,
                  color: AppColors.textGrey,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Icon(
            Icons.play_circle_fill_rounded,
            color: AppColors.primary,
            size: 64.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            l10n.watchAdToRecord,
            style: GoogleFonts.manrope(
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : AppColors.textBlack,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            l10n.watchAdToRecordDesc,
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              color: AppColors.textGrey,
              height: 1.5,
            ),
          ),
          SizedBox(height: 24.h),
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.workspace_premium_rounded,
                  color: AppColors.primary,
                  size: 24.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    l10n.premiumBenefitInstantRecord,
                    style: GoogleFonts.manrope(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white70 : AppColors.textBlack,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _isLoading ? null : _handlePremium,
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    l10n.getPremium,
                    style: GoogleFonts.manrope(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleWatchAd,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: _isLoading
                      ? SizedBox(
                          height: 20.r,
                          width: 20.r,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : Text(
                          l10n.watchAdToRecord,
                          style: GoogleFonts.manrope(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
