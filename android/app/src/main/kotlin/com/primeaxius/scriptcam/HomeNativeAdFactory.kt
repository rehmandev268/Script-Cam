package com.primeaxius.scriptcam

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.TextView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory

class HomeNativeAdFactory(private val context: Context) : NativeAdFactory {
    override fun createNativeAd(nativeAd: NativeAd, customOptions: Map<String, Any>?): NativeAdView {
        val adView = LayoutInflater.from(context).inflate(R.layout.native_ad_home, null) as NativeAdView

        // Bind views
        adView.headlineView = adView.findViewById(R.id.ad_headline)
        adView.bodyView = adView.findViewById(R.id.ad_body)
        adView.iconView = adView.findViewById(R.id.ad_app_icon)
        adView.callToActionView = adView.findViewById(R.id.ad_call_to_action)
        adView.adChoicesView = adView.findViewById(R.id.ad_choices_view)


        // Populate headline
        (adView.headlineView as TextView).text = nativeAd.headline

        // Populate body (hidden but required)
        if (nativeAd.body != null) {
            (adView.bodyView as TextView).text = nativeAd.body
        }

        // Populate call to action button
        if (nativeAd.callToAction != null) {
            (adView.callToActionView as Button).text = nativeAd.callToAction
        }

        // Populate icon
        if (nativeAd.icon != null) {
            adView.iconView?.visibility = View.VISIBLE
            (adView.iconView as ImageView).setImageDrawable(nativeAd.icon?.drawable)
        } else {
            adView.iconView?.visibility = View.GONE
        }

        // Set the native ad
        adView.setNativeAd(nativeAd)
        return adView
    }
}
