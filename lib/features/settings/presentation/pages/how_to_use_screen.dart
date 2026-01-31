import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_application_6/core/constants/app_constants.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('How to Use ScriptCam', style: TextStyle(fontSize: 18.sp)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              child: const StepCard(
                number: 1,
                title: 'Create Your Script',
                description:
                    'Go to the Scripts tab and tap the + button to add your content. You can import text or write it from scratch.',
                icon: Icons.description_rounded,
              ),
            ),
            SizedBox(height: 24.h),
            FadeInDown(
              delay: const Duration(milliseconds: 200),
              child: const StepCard(
                number: 2,
                title: 'Configure the Prompter',
                description:
                    'In the recorder, you can move, resize, and adjust the text size, speed, and opacity to your preference.',
                icon: Icons.settings_overscan_rounded,
              ),
            ),
            SizedBox(height: 24.h),
            FadeInDown(
              delay: const Duration(milliseconds: 400),
              child: const StepCard(
                number: 3,
                title: 'Voice Sync (Beta)',
                description:
                    'Enable Voice Sync in settings to let the teleprompter follow your voice automatically.',
                icon: Icons.mic_none_rounded,
              ),
            ),
            SizedBox(height: 24.h),
            FadeInDown(
              delay: const Duration(milliseconds: 600),
              child: const StepCard(
                number: 4,
                title: 'Record & Edit',
                description:
                    'Tap record to start. Once finished, use our built-in editor to trim and polish your video.',
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
                    'Got it!',
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
