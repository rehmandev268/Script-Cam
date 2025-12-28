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

class GalleryNativeAdFactory(private val context: Context) : NativeAdFactory {
    override fun createNativeAd(nativeAd: NativeAd, customOptions: Map<String, Any>?): NativeAdView {
        val adView = LayoutInflater.from(context).inflate(R.layout.native_ad_gallery, null) as NativeAdView

        adView.headlineView = adView.findViewById(R.id.ad_headline)
        adView.bodyView = adView.findViewById(R.id.ad_body)
        adView.iconView = adView.findViewById(R.id.ad_app_icon)
        adView.callToActionView = adView.findViewById(R.id.ad_call_to_action)

        (adView.headlineView as TextView).text = nativeAd.headline
        (adView.bodyView as TextView).text = nativeAd.body
        (adView.callToActionView as Button).text = nativeAd.callToAction

        if (nativeAd.icon != null) {
            adView.iconView?.visibility = View.VISIBLE
            (adView.iconView as ImageView).setImageDrawable(nativeAd.icon?.drawable)
        } else {
            adView.iconView?.visibility = View.GONE
        }

        // --- NEW THEME LOGIC ---
        // 1. Check if Flutter sent "isDarkMode"
        var isDarkMode = false
        if (customOptions != null && customOptions.containsKey("isDarkMode")) {
            isDarkMode = customOptions["isDarkMode"] as Boolean
        } else {
            // 2. Fallback to System Settings
            val nightModeFlags = context.resources.configuration.uiMode and android.content.res.Configuration.UI_MODE_NIGHT_MASK
            isDarkMode = nightModeFlags == android.content.res.Configuration.UI_MODE_NIGHT_YES
        }

        if (isDarkMode) {
            // Dark Theme Colors
            (adView.headlineView as TextView).setTextColor(Color.WHITE)
            (adView.bodyView as TextView).setTextColor(Color.parseColor("#B0B0B0"))
        } else {
            // Light Theme Colors (Professional Black/Dark Grey)
            (adView.headlineView as TextView).setTextColor(Color.BLACK)
            (adView.bodyView as TextView).setTextColor(Color.parseColor("#424242"))
        }

        adView.setNativeAd(nativeAd)
        return adView
    }
}