import 'package:flutter/material.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_config.dart';
import '../../../premium/presentation/providers/premium_provider.dart';
import '../../../teleprompter/presentation/providers/recording_restriction_provider.dart';

class RecordingIntentZone extends StatelessWidget {
  final VoidCallback
  onPickScript; // Kept for backward compatibility if needed, but we'll use more specific ones
  final VoidCallback? onCreateScript;
  final VoidCallback? onViewAllScripts;
  final VoidCallback onRecordWithoutScript;
  final VoidCallback onCreditsHintTap;
  final bool hasScripts;
  final bool isViewingAllScripts;

  const RecordingIntentZone({
    super.key,
    required this.onPickScript,
    this.onCreateScript,
    this.onViewAllScripts,
    required this.onRecordWithoutScript,
    required this.onCreditsHintTap,
    this.hasScripts = false,
    this.isViewingAllScripts = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Consumer2<PremiumProvider, RecordingRestrictionProvider>(
      builder: (context, premium, restriction, _) {
        final isPremium = premium.isPremium;
        final credits = restriction.remainingRecordings;
        final showHint = !isPremium && credits <= 1;

        return Padding(
          padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.whatAreYouRecording,
                style: GoogleFonts.manrope(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w900,
                  color: isDark ? Colors.white : AppColors.textBlack,
                  height: 1.15,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 28.h),

              // Primary Action: Record Now (Direct, Dominant)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onRecordWithoutScript,
                  icon: Icon(Icons.videocam_rounded, size: 22.sp),
                  label: Text(
                    l10n.recordNow,
                    style: GoogleFonts.manrope(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.2,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 18.h),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Secondary Actions
              Row(
                children: [
                  Flexible(
                    child: _buildAction(
                      context: context,
                      icon: Icons.add_circle_outline_rounded,
                      label: l10n.newScript,
                      onTap: onCreateScript ?? onPickScript,
                    ),
                  ),
                  if (hasScripts) ...[
                    SizedBox(width: 16.w),
                    Flexible(
                      child: _buildAction(
                        context: context,
                        icon: isViewingAllScripts
                            ? Icons.grid_view_rounded
                            : Icons.text_snippet_outlined,
                        label: isViewingAllScripts
                            ? l10n.stripView
                            : l10n.useASavedScript,
                        onTap: onViewAllScripts ?? onPickScript,
                        isActive: isViewingAllScripts,
                      ),
                    ),
                  ],
                ],
              ),

              if (showHint) ...[
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: onCreditsHintTap,
                  child: Text(
                    credits <= 0
                        ? l10n.noRecordingsLeft
                        : l10n.recordingsRemainingHint(credits),
                    style: GoogleFonts.manrope(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: credits <= 0 ? AppColors.primary : AppColors.textGrey,
                      decoration: TextDecoration.underline,
                      decorationColor: credits <= 0
                          ? AppColors.primary
                          : AppColors.textGrey,
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildAction({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18.sp,
            color: isActive ? AppColors.primary : AppColors.primary,
          ),
          SizedBox(width: 8.w),
          Flexible(
            child: Text(
              label,
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
