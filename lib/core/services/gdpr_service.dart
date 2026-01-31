import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GDPRService {
  static final GDPRService _instance = GDPRService._internal();
  factory GDPRService() => _instance;
  GDPRService._internal();

  Future<bool> initializeConsent() async {
    try {
      final debugSettings = ConsentDebugSettings(
        debugGeography: DebugGeography.debugGeographyEea,
        testIdentifiers: ["80C589E82E84A18078D863AD0C946288"],
      );

      final params = ConsentRequestParameters(
        consentDebugSettings: debugSettings,
      );

      final completer = Completer<bool>();

      ConsentInformation.instance.requestConsentInfoUpdate(
        params,
        () async {
          final status = await ConsentInformation.instance.getConsentStatus();
          debugPrint("Consent Status: $status");

          if (await ConsentInformation.instance.isConsentFormAvailable()) {
            await _loadAndShowConsentForm();
          }

          final canRequestAds = await ConsentInformation.instance
              .canRequestAds();

          debugPrint("Can Request Ads: $canRequestAds");

          completer.complete(canRequestAds);
        },
        (FormError error) {
          debugPrint('Consent Info Update Failed: ${error.message}');
          completer.complete(false);
        },
      );

      return completer.future;
    } catch (e) {
      debugPrint("GDPR Initialization Error: $e");
      return false;
    }
  }

  Future<void> _loadAndShowConsentForm() async {
    final completer = Completer<void>();

    ConsentForm.loadConsentForm(
      (consentForm) async {
        consentForm.show((formError) {
          if (formError != null) {
            debugPrint("Consent Form Error: ${formError.message}");
          }
          completer.complete();
        });
      },
      (error) {
        debugPrint("Load Form Error: ${error.message}");
        completer.complete();
      },
    );

    return completer.future;
  }

  Future<void> showPrivacyOptions() async {
    ConsentForm.showPrivacyOptionsForm((formError) {
      if (formError != null) {
        debugPrint("Privacy Options Error: ${formError.message}");
      }
    });
  }
}
