import 'package:flutter/material.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import 'package:flutter_application_6/core/utils/responsive_config.dart';
import 'package:flutter_application_6/core/constants/app_constants.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyGalleryState extends StatelessWidget {
  final VoidCallback onGoToStudio;

  const EmptyGalleryState({super.key, required this.onGoToStudio});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40.0.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Container(
                padding: EdgeInsets.all(30.r),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  shape: BoxShape.circle,
                  border:
                      Theme.of(context).cardTheme.shape
                          is RoundedRectangleBorder
                      ? Border.fromBorderSide(
                          (Theme.of(context).cardTheme.shape
                                  as RoundedRectangleBorder)
                              .side,
                        )
                      : null,
                ),
                child: Icon(
                  Icons.video_library_outlined,
                  size: 40.sp,
                  color: AppColors.textGrey,
                ),
              ),
              SizedBox(height: 25.h),
              Text(
                AppLocalizations.of(context).emptyGallery,
                style: GoogleFonts.manrope(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                AppLocalizations.of(context).emptyGalleryDesc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textGrey,
                  height: 1.5,
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(height: 30.h),
              ElevatedButton.icon(
                onPressed: onGoToStudio,
                icon: Icon(Icons.add_rounded, size: 18.sp),
                label: Text(
                  AppLocalizations.of(context).startRecording,
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
