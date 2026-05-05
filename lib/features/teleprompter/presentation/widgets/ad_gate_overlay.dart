import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/core/constants/app_constants.dart';
import 'package:flutter_application_6/core/utils/responsive_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';

class AdGateOverlay extends StatelessWidget {
  final VoidCallback onWatchAd;
  final VoidCallback onBuyPremium;
  final VoidCallback? onClose;
  final bool isLoading;
  final int currentCredits;

  const AdGateOverlay({
    super.key,
    required this.onWatchAd,
    required this.onBuyPremium,
    this.onClose,
    this.isLoading = false,
    this.currentCredits = 0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        color: Colors.black.withValues(alpha: 0.6),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 32.w),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.all(24.r),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.all(16.r),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.lock_clock_rounded,
                            color: AppColors.primary,
                            size: 40.sp,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          currentCredits > 0
                              ? AppLocalizations.of(
                                  context,
                                ).earnRecordingCredits
                              : AppLocalizations.of(context).watchAdToRecord,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.manrope(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                            color: isDark ? Colors.white : AppColors.textBlack,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          currentCredits > 0
                              ? AppLocalizations.of(
                                  context,
                                ).currentCreditsDescription(currentCredits)
                              : AppLocalizations.of(
                                  context,
                                ).watchAdToRecordDesc,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.manrope(
                            fontSize: 14.sp,
                            color: AppColors.textGrey,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        _buildPremiumFeature(
                          context,
                          Icons.play_circle_fill_rounded,
                          AppLocalizations.of(context).watchAdGetRecordings,
                        ),
                        SizedBox(height: 8.h),
                        _buildPremiumFeature(
                          context,
                          Icons.workspace_premium_rounded,
                          AppLocalizations.of(
                            context,
                          ).premiumBenefitInstantRecord,
                        ),
                        SizedBox(height: 32.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : onWatchAd,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              elevation: 0,
                            ),
                            child: isLoading
                                ? SizedBox(
                                    height: 20.r,
                                    width: 20.r,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    AppLocalizations.of(
                                      context,
                                    ).watchAdToRecord,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.manrope(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: isLoading ? null : onBuyPremium,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.primary,
                              side: const BorderSide(color: AppColors.primary),
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                            ),
                            child: Text(
                              AppLocalizations.of(context).getPremium,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.manrope(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 8.r,
                    right: 8.r,
                    child: IconButton(
                      onPressed: onClose,
                      icon: Icon(
                        Icons.close,
                        size: 22.sp,
                        color: isDark ? Colors.white54 : Colors.black45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumFeature(
    BuildContext context,
    IconData icon,
    String label,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 18.sp),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : AppColors.textBlack,
            ),
          ),
        ),
      ],
    );
  }
}
