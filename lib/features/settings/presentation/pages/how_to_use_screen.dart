import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_application_6/core/constants/app_constants.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import '../../../../core/utils/responsive_config.dart';
import '../widgets/step_card.dart';
import '../../../../core/services/analytics_service.dart';

class HowToUseScreen extends StatefulWidget {
  const HowToUseScreen({super.key});

  @override
  State<HowToUseScreen> createState() => _HowToUseScreenState();
}

class _HowToUseScreenState extends State<HowToUseScreen> {
  @override
  void initState() {
    super.initState();
    AnalyticsService().logHelpDocumentViewed(documentName: 'How to Use');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.howToUseTitle, style: TextStyle(fontSize: 18.sp)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              child: StepCard(
                number: 1,
                title: l10n.step1Title,
                description: l10n.step1Desc,
                icon: Icons.description_rounded,
              ),
            ),
            SizedBox(height: 24.h),
            FadeInDown(
              delay: const Duration(milliseconds: 200),
              child: StepCard(
                number: 2,
                title: l10n.step2Title,
                description: l10n.step2Desc,
                icon: Icons.settings_overscan_rounded,
              ),
            ),
            SizedBox(height: 24.h),
            FadeInDown(
              delay: const Duration(milliseconds: 400),
              child: StepCard(
                number: 3,
                title: l10n.step3Title,
                description: l10n.step3Desc,
                icon: Icons.mic_none_rounded,
              ),
            ),
            SizedBox(height: 24.h),
            FadeInDown(
              delay: const Duration(milliseconds: 600),
              child: StepCard(
                number: 4,
                title: l10n.step4Title,
                description: l10n.step4Desc,
                icon: Icons.videocam_rounded,
              ),
            ),
            SizedBox(height: 40.h),
            Center(
              child: FadeInUp(
                delay: const Duration(milliseconds: 800),
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 48.w,
                      vertical: 16.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: Text(
                    l10n.gotIt,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
