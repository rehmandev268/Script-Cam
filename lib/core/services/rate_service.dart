import 'package:hive_flutter/hive_flutter.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:flutter_application_6/core/constants/app_constants.dart';
import 'analytics_service.dart';

class RateService {
  static final InAppReview _inAppReview = InAppReview.instance;

  static const String _exportCountKey = 'export_count';
  static const String _userOptedOutKey = 'rate_opted_out';

  static Future<void> incrementExportAndCheck() async {
    if (!Hive.isBoxOpen(HiveKeys.settingsBox)) {
      await Hive.openBox(HiveKeys.settingsBox);
    }
    final box = Hive.box(HiveKeys.settingsBox);

    bool optedOut = box.get(_userOptedOutKey, defaultValue: false);
    if (optedOut) return;

    int count = box.get(_exportCountKey, defaultValue: 0);
    count++;
    await box.put(_exportCountKey, count);

    if (count == 3) {
      await requestReview();
    }
  }

  static Future<void> requestReview() async {
    if (await _inAppReview.isAvailable()) {
      AnalyticsService().logAppRated(rating: 5);
      await _inAppReview.requestReview();
    }
  }

  static Future<void> openStoreListing() async {
    await _inAppReview.openStoreListing();
  }
}
