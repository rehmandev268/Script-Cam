import 'package:flutter/material.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import '../../../../widgets/common/adaptive_app_bar.dart';
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
      appBar: AdaptiveAppBar(title: l10n.howToUseTitle),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.r),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepCard(
              number: 1,
              title: l10n.step1Title,
              description: l10n.step1Desc,
              icon: Icons.description_rounded,
            ),
            SizedBox(height: 24.h),
            StepCard(
              number: 2,
              title: l10n.step2Title,
              description: l10n.step2Desc,
              icon: Icons.settings_overscan_rounded,
            ),
            SizedBox(height: 24.h),
            StepCard(
              number: 3,
              title: l10n.step3Title,
              description: l10n.step3Desc,
              icon: Icons.mic_none_rounded,
            ),
            SizedBox(height: 24.h),
            StepCard(
              number: 4,
              title: l10n.step4Title,
              description: l10n.step4Desc,
              icon: Icons.videocam_rounded,
            ),
            SizedBox(height: 24.h),
            StepCard(
              number: 5,
              title: l10n.step5Title,
              description: l10n.step5Desc,
              icon: Icons.keyboard_alt_rounded,
            ),
            SizedBox(height: 40.h),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  l10n.gotIt,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.h),
          ],
          ),
        ),
      ),
    );
  }
}
