import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
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
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = Provider.of<PremiumProvider>(context);
    if (provider.isPremium) return;

    if (!_isLoaded && !_isLoading) {
      loadAd();
    }
  }

  void loadAd() {
    setState(() => _isLoading = true);
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    _nativeAd = NativeAd(
      adUnitId: AdIds.native,
      factoryId: widget.factoryId,
      request: const AdRequest(),
      customOptions: {'isDarkMode': isDark},
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          if (mounted) {
            setState(() {
              _isLoaded = true;
              _isLoading = false;
            });
          }
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        },
      ),
    );
    _nativeAd!.load();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PremiumProvider>(context);
    if (provider.isPremium) return const SizedBox.shrink();
    if (!_isLoaded || _nativeAd == null) return const SizedBox.shrink();

    Widget adContent = SizedBox(
      height: widget.height,
      width: double.infinity,
      child: AdWidget(ad: _nativeAd!),
    );

    if (widget.isGlass) {
      return GlassContainer(
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.only(bottom: 10),
        child: adContent,
      );
    }

    return Padding(
        padding: const EdgeInsets.only(bottom: 0), child: adContent);
  }
}

class AdaptiveBannerWidget extends StatefulWidget {
  const AdaptiveBannerWidget({super.key});

  @override
  State<AdaptiveBannerWidget> createState() => _AdaptiveBannerWidgetState();
}

class _AdaptiveBannerWidgetState extends State<AdaptiveBannerWidget> {
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = Provider.of<PremiumProvider>(context);
    if (provider.isPremium && _anchoredAdaptiveAd != null) {
      _anchoredAdaptiveAd!.dispose();
      _anchoredAdaptiveAd = null;
      _isLoaded = false;
    } else if (!provider.isPremium && !_isLoaded) {
      _loadAd();
    }
  }

  Future<void> _loadAd() async {
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
      MediaQuery.of(context).size.width.truncate(),
    );

    if (size == null) return;

    _anchoredAdaptiveAd = BannerAd(
      adUnitId: AdIds.banner,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          if (mounted) setState(() => _isLoaded = true);
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
    );
    return _anchoredAdaptiveAd!.load();
  }

  @override
  void dispose() {
    _anchoredAdaptiveAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PremiumProvider>(context);
    if (provider.isPremium || !_isLoaded || _anchoredAdaptiveAd == null)
      return const SizedBox.shrink();

    return Container(
      color: Colors.transparent,
      width: _anchoredAdaptiveAd!.size.width.toDouble(),
      height: _anchoredAdaptiveAd!.size.height.toDouble(),
      child: AdWidget(ad: _anchoredAdaptiveAd!),
    );
  }
}
