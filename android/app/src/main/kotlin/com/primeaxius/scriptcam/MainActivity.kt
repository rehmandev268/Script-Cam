package com.primeaxius.scriptcam

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // 1. Register Gallery Factory
        GoogleMobileAdsPlugin.registerNativeAdFactory(
                flutterEngine, "adFactoryGallery", GalleryNativeAdFactory(context))

        // 2. Register Settings Factory
        GoogleMobileAdsPlugin.registerNativeAdFactory(
                flutterEngine, "adFactorySettings", SettingsNativeAdFactory(context))

        GoogleMobileAdsPlugin.registerNativeAdFactory(
                flutterEngine, "adFactoryHome", HomeNativeAdFactory(context))
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "adFactoryGallery")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "adFactorySettings")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "adFactoryHome")
    }
}