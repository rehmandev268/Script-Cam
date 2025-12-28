package com.example.flutter_application_6 // Ensure this matches your package

import android.content.Context
import android.graphics.Color
import android.view.LayoutInflater
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.TextView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory

class SettingsNativeAdFactory(private val context: Context) : NativeAdFactory {
    override fun createNativeAd(nativeAd: NativeAd, customOptions: Map<String, Any>?): NativeAdView {
        val adView = LayoutInflater.from(context).inflate(R.layout.native_ad_settings, null) as NativeAdView

        adView.headlineView = adView.findViewById(R.id.ad_headline)
        adView.bodyView = adView.findViewById(R.id.ad_body)
        adView.iconView = adView.findViewById(R.id.ad_app_icon)
        adView.callToActionView = adView.findViewById(R.id.ad_call_to_action)

        (adView.headlineView as TextView).text = nativeAd.headline
        (adView.callToActionView as Button).text = "OPEN"

        if (nativeAd.icon != null) {
            adView.iconView?.visibility = View.VISIBLE
            (adView.iconView as ImageView).setImageDrawable(nativeAd.icon?.drawable)
        }

        // --- NEW THEME LOGIC ---
        var isDarkMode = false
        if (customOptions != null && customOptions.containsKey("isDarkMode")) {
            isDarkMode = customOptions["isDarkMode"] as Boolean
        } else {
            val nightModeFlags = context.resources.configuration.uiMode and android.content.res.Configuration.UI_MODE_NIGHT_MASK
            isDarkMode = nightModeFlags == android.content.res.Configuration.UI_MODE_NIGHT_YES
        }

        if (isDarkMode) {
            (adView.headlineView as TextView).setTextColor(Color.WHITE)
        } else {
            (adView.headlineView as TextView).setTextColor(Color.BLACK)
        }

        adView.setNativeAd(nativeAd)
        return adView
    }
}