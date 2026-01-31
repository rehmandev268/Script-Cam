import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_config.dart';
import '../../../../widgets/common/glass_container.dart';
import '../providers/premium_provider.dart';
import '../widgets/feature_item.dart';
import '../../../../core/services/analytics_service.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  bool _isRestoring = false;

  Future<void> _handleRestore(PremiumProvider provider) async {
    setState(() => _isRestoring = true);
    await provider.restorePurchases();

    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _isRestoring = false);
  }

  @override
  void initState() {
    super.initState();
    AnalyticsService().logPremiumScreenViewed();
  }

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFF000000);
    const accentGold = Color(0xFFFFD700);
    const accentOrange = Color(0xFFFF8C00);

    return Consumer<PremiumProvider>(
      builder: (context, provider, child) {
        if (provider.isPremium) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          });
        }

        return Scaffold(
          backgroundColor: bgColor,
          body: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: -100.h,
                  right: -50.w,
                  child: Container(
                    width: 300.w,
                    height: 300.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withValues(alpha: 0.4),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -50.h,
                  left: -50.w,
                  child: Container(
                    width: 250.w,
                    height: 250.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: accentOrange.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 80.0, sigmaY: 80.0),
                  child: Container(color: Colors.transparent),
                ),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20.w, top: 10.h),
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Container(
                            padding: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.1),
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FadeInDown(
                              duration: const Duration(milliseconds: 800),
                              child: Container(
                                padding: EdgeInsets.all(24.r),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      accentGold.withValues(alpha: 0.2),
                                      Colors.transparent,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  border: Border.all(
                                    color: accentGold.withValues(alpha: 0.3),
                                    width: 1.w,
                                  ),
                                ),
                                child: Icon(
                                  Icons.diamond_outlined,
                                  size: 64.sp,
                                  color: accentGold,
                                ),
                              ),
                            ),
                            SizedBox(height: 30.h),
                            FadeInUp(
                              delay: const Duration(milliseconds: 200),
                              child: Text(
                                "Unlock Creator Pro",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.manrope(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  height: 1.1,
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            FadeInUp(
                              delay: const Duration(milliseconds: 300),
                              child: Text(
                                "Join thousands of creators making professional videos with ScriptCam.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white.withValues(alpha: 0.7),
                                  height: 1.5,
                                ),
                              ),
                            ),
                            SizedBox(height: 40.h),
                            FadeInUp(
                              delay: const Duration(milliseconds: 400),
                              child: GlassContainer(
                                color: Colors.white.withValues(alpha: 0.08),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.1),
                                ),
                                padding: EdgeInsets.all(24.r),
                                child: Column(
                                  children: [
                                    FeatureItem(
                                      text: "Remove All Ads",
                                      icon: Icons.block_flipped,
                                      color: accentGold,
                                    ),
                                    SizedBox(height: 20.h),
                                    FeatureItem(
                                      text: "Unlimited Scripts",
                                      icon: Icons.description_outlined,
                                      color: accentGold,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FadeInUp(
                      delay: const Duration(milliseconds: 600),
                      child: Container(
                        padding: EdgeInsets.all(24.r),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30.r),
                          ),
                        ),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: (provider.isPurchasing || _isRestoring)
                                  ? null
                                  : () => provider.buyPremium(),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 18.h),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [accentGold, accentOrange],
                                  ),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: provider.isPurchasing
                                    ? Center(
                                        child: SizedBox(
                                          width: 24.w,
                                          height: 24.h,
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                            strokeWidth: 2.5.w,
                                          ),
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Upgrade for Lifetime",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black,
                                              letterSpacing: 0.5.w,
                                            ),
                                          ),
                                          SizedBox(width: 8.w),
                                          Icon(
                                            Icons.arrow_forward_rounded,
                                            color: Colors.black.withOpacity(
                                              0.8,
                                            ),
                                            size: 20.sp,
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            GestureDetector(
                              onTap: (provider.isPurchasing || _isRestoring)
                                  ? null
                                  : () => _handleRestore(provider),
                              child: _isRestoring
                                  ? SizedBox(
                                      width: 14.w,
                                      height: 14.h,
                                      child: CircularProgressIndicator(
                                        color: Colors.white54,
                                        strokeWidth: 1.5.w,
                                      ),
                                    )
                                  : Text(
                                      "Already purchased? Restore",
                                      style: TextStyle(
                                        color: Colors.white.withValues(
                                          alpha: 0.6,
                                        ),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                            ),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
