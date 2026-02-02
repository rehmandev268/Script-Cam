import 'package:flutter/material.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import 'package:flutter_application_6/core/services/ads_service/interstitial_ad_helper.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_config.dart';
import '../../../../widgets/ads/adaptive_banner_ad.dart';
import '../../../premium/presentation/providers/premium_provider.dart';
import '../../../settings/presentation/providers/ui_provider.dart';

import 'package:permission_handler/permission_handler.dart';
import '../../../../core/utils/toast_service.dart';
import '../../../../core/services/analytics_service.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    final uiProvider = Provider.of<UIProvider>(context, listen: false);
    // If onboarding was already completed but we're here (permissions missing),
    // jump straight to the permissions page.
    _currentPage = (uiProvider.showOnboarding == false) ? 3 : 0;
    _controller = PageController(initialPage: _currentPage);
    if (uiProvider.showOnboarding) {
      AnalyticsService().logOnboardingStarted();
    }
  }

  List<Map<String, dynamic>> _getPages(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return [
      {
        "title": l10n.onboardingWelcomeTitle,
        "desc": l10n.onboardingWelcomeDesc,
        "icon": Icons.movie_creation_outlined,
      },
      {
        "title": l10n.onboardingScriptEditorTitle,
        "desc": l10n.onboardingScriptEditorDesc,
        "icon": Icons.edit_note_outlined,
      },
      {
        "title": l10n.onboardingTeleprompterTitle,
        "desc": l10n.onboardingTeleprompterDesc,
        "icon": Icons.videocam_outlined,
      },
      {
        "title": l10n.onboardingPermissionsTitle,
        "desc": l10n.onboardingPermissionsDesc,
        "icon": Icons.security_outlined,
        "isPermission": true,
      },
    ];
  }

  Future<void> _requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
      Permission.speech,
      Permission.videos,
      Permission.storage,
    ].request();

    AnalyticsService().logPermissionRequested(
      permissionType: 'onboarding_camera_mic',
    );

    if (statuses[Permission.camera]!.isGranted &&
        statuses[Permission.microphone]!.isGranted) {
      AnalyticsService().logPermissionGranted(
        permissionType: 'onboarding_camera_mic',
      );
      if (mounted) _completeOnboarding(context);
    } else {
      AnalyticsService().logPermissionDenied(
        permissionType: 'onboarding_camera_mic',
      );
      if (!mounted) return;
      final l10n = AppLocalizations.of(context);
      ToastService.show(l10n.permissionsRequired);
      if (statuses[Permission.camera]!.isPermanentlyDenied ||
          statuses[Permission.microphone]!.isPermanentlyDenied) {
        openAppSettings();
      }
    }
  }

  void _completeOnboarding(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context, listen: false);
    final premiumProvider = Provider.of<PremiumProvider>(
      context,
      listen: false,
    );
    // Complete onboarding immediately
    uiProvider.completeOnboarding();

    // Show ad independently
    InterstitialAdHelper.show(
      isPremium: premiumProvider.isPremium,
      onComplete: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 60.h,
              bottom: 80.h,
            ),
            child: PageView.builder(
              controller: _controller,
              itemCount: _getPages(context).length,
              onPageChanged: (idx) => setState(() => _currentPage = idx),
              itemBuilder: (context, index) {
                final isPermission =
                    _getPages(context)[index]['isPermission'] ?? false;

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeInDown(
                        child: Container(
                          padding: EdgeInsets.all(30.r),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _getPages(context)[index]['icon'],
                            size: 100.sp,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      SizedBox(height: 40.h),
                      FadeInUp(
                        child: Text(
                          _getPages(context)[index]['title'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      FadeInUp(
                        delay: const Duration(milliseconds: 200),
                        child: Text(
                          _getPages(context)[index]['desc'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.textGrey,
                            height: 1.5,
                          ),
                        ),
                      ),
                      if (isPermission) ...[
                        SizedBox(height: 40.h),
                        FadeInUp(
                          delay: const Duration(milliseconds: 400),
                          child: ElevatedButton.icon(
                            onPressed: _requestPermissions,
                            icon: const Icon(Icons.check_circle_outline),
                            label: Text(l10n.grantAccess),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 32.w,
                                vertical: 16.h,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10.h,
            left: 20.w,
            right: 20.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_currentPage == _getPages(context).length - 1) {
                      _requestPermissions();
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: Text(
                    _currentPage == _getPages(context).length - 1
                        ? l10n.start
                        : l10n.next,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _getPages(context).length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      height: 8.h,
                      width: _currentPage == index ? 24.w : 8.w,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? AppColors.primary
                            : Colors.grey.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                const AdaptiveBannerWidget(),
                SizedBox(height: MediaQuery.of(context).padding.bottom + 10.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
