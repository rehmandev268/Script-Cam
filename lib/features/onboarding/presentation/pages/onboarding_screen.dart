import 'package:flutter/material.dart';
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

  final List<Map<String, dynamic>> _pages = [
    {
      "title": "Welcome to ScriptCam",
      "desc":
          "Your all-in-one Teleprompter studio. Write scripts, record videos, and edit seamlessly.",
      "icon": Icons.movie_creation_outlined,
    },
    {
      "title": "Script Editor",
      "desc":
          "Write and manage your video scripts with ease. Organize your ideas instantly.",
      "icon": Icons.edit_note_outlined,
    },
    {
      "title": "Teleprompter",
      "desc":
          "Read your script while looking directly at the camera. Professional recording made easy.",
      "icon": Icons.videocam_outlined,
    },
    {
      "title": "Enable Permissions",
      "desc":
          "To record videos and sync your voice with the script, we need access to your camera and microphone.",
      "icon": Icons.security_outlined,
      "isPermission": true,
    },
  ];

  Future<void> _requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
      Permission.speech,
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
      ToastService.show("Camera and Microphone permissions are required.");
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
    InterstitialAdHelper.show(
      isPremium: premiumProvider.isPremium,
      onComplete: () {
        uiProvider.completeOnboarding();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
              itemCount: _pages.length,
              onPageChanged: (idx) => setState(() => _currentPage = idx),
              itemBuilder: (context, index) {
                final isPermission = _pages[index]['isPermission'] ?? false;

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
                            _pages[index]['icon'],
                            size: 100.sp,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      SizedBox(height: 40.h),
                      FadeInUp(
                        child: Text(
                          _pages[index]['title'],
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
                          _pages[index]['desc'],
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
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: _requestPermissions,
                              icon: const Icon(Icons.check_circle_outline),
                              label: const Text("Grant Access"),
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
                    if (_currentPage == _pages.length - 1) {
                      _requestPermissions();
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 400),
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
                    _currentPage == _pages.length - 1 ? "Start" : "Next",
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
                    _pages.length,
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
