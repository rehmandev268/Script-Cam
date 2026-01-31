import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_constants.dart';
import '../../core/services/ads_service/ad_state.dart';
import '../../core/services/ads_service/app_open_ad_manager.dart';
import '../../core/utils/responsive_config.dart';
import '../../features/premium/presentation/providers/premium_provider.dart';
import '../common/glass_container.dart';

class CustomNativeAdWidget extends StatefulWidget {
  final String factoryId;
  final double height;
  final bool isGlass;

  const CustomNativeAdWidget({
    super.key,
    required this.factoryId,
    this.height = 72,
    this.isGlass = false,
  });

  @override
  State<CustomNativeAdWidget> createState() => _CustomNativeAdWidgetState();
}

class _CustomNativeAdWidgetState extends State<CustomNativeAdWidget> {
  NativeAd? _nativeAd;
  bool _isLoaded = false;
  bool _isAdLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkAndLoadAd();
  }

  void _checkAndLoadAd() {
    if (!AdState.canRequestAds) return;
    if (AppOpenAdManager.isShowingInterstitial) return;

    final provider = Provider.of<PremiumProvider>(context, listen: false);
    if (provider.isPremium || _isLoaded || _isAdLoading) return;

    _loadAd();
  }

  void _loadAd() {
    if (!mounted) return;

    _isAdLoading = true;

    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    _nativeAd = NativeAd(
      adUnitId: AdIds.native,
      factoryId: widget.factoryId,
      request: const AdRequest(),
      customOptions: {'isDarkMode': isDark},
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _isLoaded = true;
            _isAdLoading = false;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          if (!mounted) return;
          setState(() {
            _isLoaded = false;
            _isAdLoading = false;
            _nativeAd = null;
          });
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    _nativeAd = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PremiumProvider>(context);

    if (!AdState.canRequestAds ||
        provider.isPremium ||
        !_isLoaded ||
        _nativeAd == null) {
      return const SizedBox.shrink();
    }

    final Widget adContent = SizedBox(
      height: widget.height, // Removed the second .h call
      width: double.infinity,
      child: AdWidget(ad: _nativeAd!), // Removed Center to allow expansion
    );

    if (widget.isGlass) {
      return GlassContainer(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.only(bottom: 0.h),
        child: adContent, // Removed Center
      );
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 0.h),
      child: adContent, // Removed Center
    );
  }
}
