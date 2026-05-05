import 'package:flutter/material.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import 'package:flutter_application_6/core/constants/app_constants.dart';
import 'package:flutter_application_6/core/utils/responsive_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/services/connectivity_service.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Use the generated illustration
              Container(
                height: 250.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/no_internet.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 48.h),
              Text(
                l10n.noInternetTitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : AppColors.textBlack,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                l10n.noInternetDesc,
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  fontSize: 16.sp,
                  color: isDark ? Colors.white70 : AppColors.textGrey,
                  height: 1.5,
                ),
              ),
              const Spacer(),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<ConnectivityService>().checkConnection();
                  },
                  child: Text(
                    l10n.retry,
                    style: GoogleFonts.manrope(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
