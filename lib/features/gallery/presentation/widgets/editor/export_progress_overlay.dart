import 'package:flutter/material.dart';
import 'package:flutter_application_6/core/utils/responsive_config.dart';
import 'package:flutter_application_6/core/constants/app_constants.dart';

class ExportProgressOverlay extends StatelessWidget {
  final ValueNotifier<double> progressNotifier;

  const ExportProgressOverlay({super.key, required this.progressNotifier});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16).r,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: AppColors.primary),
            SizedBox(height: 20.h),
            Text(
              "Processing...",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
            ValueListenableBuilder<double>(
              valueListenable: progressNotifier,
              builder: (_, val, __) => Text(
                "${(val * 100).toInt()}%",
                style: TextStyle(color: Colors.grey, fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
