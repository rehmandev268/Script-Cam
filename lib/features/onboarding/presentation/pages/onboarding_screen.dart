import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/analytics_service.dart';
import '../../../../core/utils/responsive_config.dart';
import '../../../../core/utils/toast_service.dart';
import '../../../settings/presentation/providers/ui_provider.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _controller;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    AnalyticsService().logOnboardingStarted();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _requestPermissions() async {
    final statuses = await [
      Permission.camera,
      Permission.microphone,
      Permission.speech,
      Permission.videos,
      Permission.storage,
    ].request();

    if (!mounted) return;

    if (statuses[Permission.camera]!.isGranted &&
        statuses[Permission.microphone]!.isGranted) {
      context.read<UIProvider>().completeOnboarding();
    } else {
      ToastService.show(AppLocalizations.of(context).permissionsRequired);
      if (statuses[Permission.camera]!.isPermanentlyDenied ||
          statuses[Permission.microphone]!.isPermanentlyDenied) {
        openAppSettings();
      }
    }
  }

  void _primaryAction() {
    if (_page == 2) {
      _requestPermissions();
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (value) => setState(() => _page = value),
                children: [
                  _StepShell(
                    title: l10n.onboardingInteractiveStep1Title,
                    subtitle: l10n.onboardingInteractiveStep1Subtitle,
                    child: _CameraMockCard(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 20.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _MutedEyebrow(text: l10n.onboardingInteractiveStep1Eyebrow),
                            SizedBox(height: 14.h),
                            Text(
                              l10n.onboardingInteractiveStep1Preview,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.88),
                                fontSize: 14.sp,
                                height: 1.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _StepShell(
                    title: l10n.onboardingInteractiveStep2Title,
                    subtitle: l10n.onboardingInteractiveStep2Subtitle,
                    child: _CameraMockCard(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(14.w, 16.h, 14.w, 12.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.fiber_manual_record,
                                  color: AppColors.primary,
                                  size: 16.sp,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  l10n.onboardingInteractiveRecLabel,
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.35,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 14.h),
                            Expanded(
                              child: ShaderMask(
                                shaderCallback: (rect) =>
                                    const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.white,
                                    Colors.white,
                                    Colors.transparent,
                                  ],
                                  stops: [0.0, 0.08, 0.92, 1.0],
                                ).createShader(rect),
                                blendMode: BlendMode.dstIn,
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8.h),
                                    child: Text(
                                      l10n.onboardingInteractiveStep2Sample,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.5.sp,
                                        height: 1.52,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.pause_circle_outline_rounded,
                                  color: Colors.white38,
                                  size: 22.sp,
                                ),
                                SizedBox(width: 20.w),
                                Icon(
                                  Icons.swap_vert_rounded,
                                  color: Colors.white38,
                                  size: 22.sp,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _StepShell(
                    title: l10n.onboardingInteractiveStep4Title,
                    subtitle: l10n.onboardingInteractiveStep4Subtitle,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkSurface : Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color:
                              isDark ? AppColors.borderDark : AppColors.borderLight,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _AccessRow(
                            icon: Icons.videocam_outlined,
                            label: l10n.onboardingAccessCamera,
                          ),
                          SizedBox(height: 12.h),
                          _AccessRow(
                            icon: Icons.mic_none_rounded,
                            label: l10n.onboardingAccessMic,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            l10n.onboardingInteractiveStep4CardHint,
                            style: TextStyle(
                              fontSize: 12.5.sp,
                              color: AppColors.textGrey,
                              height: 1.42,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: List.generate(
                      3,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        margin: EdgeInsets.only(right: 6.w),
                        width: _page == index ? 18.w : 7.w,
                        height: 7.h,
                        decoration: BoxDecoration(
                          color: _page == index
                              ? AppColors.primary
                              : AppColors.textGrey.withValues(alpha: 0.35),
                          borderRadius: BorderRadius.circular(99.r),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _primaryAction,
                    child:
                        Text(_page == 2 ? l10n.grantAccess : l10n.next),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepShell extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const _StepShell({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? AppColors.textWhite : AppColors.textBlack;

    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              height: 1.2,
              color: titleColor,
              letterSpacing: -0.2,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            subtitle,
            style: TextStyle(
              color: AppColors.textGrey,
              fontSize: 14.sp,
              height: 1.45,
            ),
          ),
          SizedBox(height: 18.h),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _CameraMockCard extends StatelessWidget {
  final Widget child;

  const _CameraMockCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0B),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.white12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child: child,
      ),
    );
  }
}

class _MutedEyebrow extends StatelessWidget {
  final String text;

  const _MutedEyebrow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.35,
        color: Colors.white38,
      ),
    );
  }
}

class _AccessRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _AccessRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor =
        isDark ? AppColors.textWhite70 : AppColors.textGrey;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 22.sp, color: iconColor),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              height: 1.35,
              color: isDark ? AppColors.textWhite : AppColors.textBlack,
            ),
          ),
        ),
      ],
    );
  }
}
