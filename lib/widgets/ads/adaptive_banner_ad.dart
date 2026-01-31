import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart' show Provider;

import '../../core/constants/app_constants.dart';
import '../../core/services/ads_service/ad_state.dart';
import '../../features/premium/presentation/providers/premium_provider.dart';

class AdaptiveBannerWidget extends StatefulWidget {
  const AdaptiveBannerWidget({super.key});

  @override
  State<AdaptiveBannerWidget> createState() => _AdaptiveBannerWidgetState();
}

class _AdaptiveBannerWidgetState extends State<AdaptiveBannerWidget> {
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkAndManageAd();
  }

  void _checkAndManageAd() {
    if (!AdState.canRequestAds) {
      _disposeAd();
      return;
    }

    final provider = Provider.of<PremiumProvider>(context, listen: false);

    if (provider.isPremium) {
      _disposeAd();
      return;
    }

    if (!_isLoaded && !_isLoading) {
      _loadAd();
    }
  }

  Future<void> _loadAd() async {
    if (!mounted) return;

    _isLoading = true;

    final int width = MediaQuery.of(context).size.width.truncate();

    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(width);

    if (!mounted || size == null) {
      _isLoading = false;
      return;
    }

    _anchoredAdaptiveAd = BannerAd(
      adUnitId: AdIds.banner,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          if (!mounted) return;
          setState(() {
            _isLoaded = true;
            _isLoading = false;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          if (!mounted) return;
          setState(() {
            _isLoaded = false;
            _isLoading = false;
            _anchoredAdaptiveAd = null;
          });
        },
      ),
    );

    await _anchoredAdaptiveAd!.load();
  }

  void _disposeAd() {
    _anchoredAdaptiveAd?.dispose();
    _anchoredAdaptiveAd = null;
    _isLoaded = false;
    _isLoading = false;
  }

  @override
  void dispose() {
    _disposeAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PremiumProvider>(context);

    if (!AdState.canRequestAds ||
        provider.isPremium ||
        !_isLoaded ||
        _anchoredAdaptiveAd == null) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      width: _anchoredAdaptiveAd!.size.width.toDouble(),
      height: _anchoredAdaptiveAd!.size.height.toDouble(),
      child: AdWidget(ad: _anchoredAdaptiveAd!),
    );
  }
}
