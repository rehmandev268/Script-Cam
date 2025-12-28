import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_config.dart';
import '../../../../core/services/ad_manager.dart';
import '../../../premium/presentation/providers/premium_provider.dart';
import '../../../settings/presentation/providers/ui_provider.dart';
import '../../../../widgets/ads/native_ad_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      "title": "Welcome to ScriptFlow",
      "desc": "Your all-in-one Teleprompter studio. Write scripts, record videos, and edit seamlessly.",
      "icon": Icons.movie_creation_outlined,
    },
    {
      "title": "Script Editor",
      "desc": "Write and manage your video scripts with ease. Organize your ideas instantly.",
      "icon": Icons.edit_note_outlined,
    },
    {
      "title": "Teleprompter",
      "desc": "Tap the camera icon on any script to start recording. Read your script while looking directly at the camera.",
      "icon": Icons.videocam_outlined,
    },
    {
      "title": "Gallery & Editing",
      "desc": "View your recordings in the Gallery. Trim unwanted parts and share directly to social media.",
      "icon": Icons.video_library_outlined,
    },
  ];

  void _completeOnboarding(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context, listen: false);
    final premiumProvider = Provider.of<PremiumProvider>(context, listen: false);
    AdHelper.showInterstitialAd(() {
      uiProvider.completeOnboarding();
    }, premiumProvider.isPremium);
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
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeInDown(
                        child: Container(
                          padding: EdgeInsets.all(30.r),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
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
                            color: isDark ? Colors.white70 : Colors.grey[700],
                            height: 1.5,
                          ),
                        ),
                      ),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => _completeOnboarding(context),
                  child: const Text(
                    "Skip",
                    style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_currentPage == _pages.length - 1) {
                      _completeOnboarding(context);
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
                            : Colors.grey.withOpacity(0.5),
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