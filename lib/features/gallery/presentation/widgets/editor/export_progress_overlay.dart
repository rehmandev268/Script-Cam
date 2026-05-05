import 'package:flutter/material.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import 'package:flutter_application_6/core/utils/responsive_config.dart';
import 'package:flutter_application_6/core/constants/app_constants.dart';

class ExportProgressOverlay extends StatelessWidget {
  final ValueNotifier<double> progressNotifier;

  const ExportProgressOverlay({super.key, required this.progressNotifier});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16).r,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: AppColors.primary),
            SizedBox(height: 20.h),
            Text(
              l10n.processing,
              style: TextStyle(
                color: isDark ? Colors.white : AppColors.textBlack,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
            ValueListenableBuilder<double>(
              valueListenable: progressNotifier,
              builder: (context, val, _) => Text(
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
