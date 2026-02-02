import 'package:flutter/material.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_6/core/utils/responsive_config.dart';
import 'package:flutter_application_6/core/utils/toast_service.dart';
import 'package:flutter_application_6/widgets/ads/custom_native_ad_widget.dart';
import 'package:flutter_application_6/widgets/common/adaptive_app_bar.dart';
import '../../data/models/video_model.dart';
import '../providers/gallery_provider.dart';
import '../widgets/gallery_video_list_item.dart';
import '../widgets/gallery_empty_state.dart';
import 'package:flutter_application_6/core/utils/app_dialogs.dart';
import 'package:flutter_application_6/features/premium/presentation/providers/premium_provider.dart';
import 'package:flutter_application_6/core/services/ads_service/ad_state.dart';
import 'package:flutter_application_6/core/services/analytics_service.dart';

class GalleryScreen extends StatefulWidget {
  final VoidCallback? onGoToStudio;
  final double bottomPadding;

  const GalleryScreen({super.key, this.onGoToStudio, this.bottomPadding = 100});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<GalleryProvider>();
      AnalyticsService().logGalleryOpened(totalVideos: provider.videos.length);
    });
  }

  void _confirmDelete(BuildContext context, VideoRecord video) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final galleryProvider = context.read<GalleryProvider>();
    final confirm = await AppDialogs.showConfirmDelete(
      context: context,
      title: l10n.deleteVideoTitle,
      content: l10n.deleteScriptMessage,
      isDark: isDark,
    );

    if (confirm && mounted) {
      galleryProvider.deleteVideo(video);
      ToastService.show(l10n.videoDeleted, isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdaptiveAppBar(
        title: AppLocalizations.of(context).gallery,
        showBackButton: false,
      ),
      body: Consumer<GalleryProvider>(
        builder: (context, provider, _) {
          if (provider.videos.isEmpty) {
            return EmptyGalleryState(
              onGoToStudio: () => widget.onGoToStudio?.call(),
            );
          }

          // Calculate total items including ads
          // First ad after 2 videos, then every 5 videos
          final videoCount = provider.videos.length;
          int adCount = 0;

          if (videoCount > 2) {
            adCount = 1; // First ad after 2 videos
            final remainingVideos = videoCount - 2;
            adCount += (remainingVideos / 5)
                .floor(); // Additional ads every 5 videos
          }

          final totalItems = videoCount + adCount;

          return ListView.builder(
            padding: EdgeInsets.fromLTRB(
              20.w,
              12.h,
              20.w,
              widget.bottomPadding,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: totalItems,
            itemBuilder: (ctx, index) {
              // Calculate if this position should be an ad
              int videoIndex = index;
              bool isAd = false;

              if (index >= 2) {
                // After first 2 videos, check for ad positions
                final positionAfterFirst2 = index - 2;

                // First ad is at position 2 (after 2 videos)
                if (positionAfterFirst2 == 0) {
                  isAd = true;
                } else if (positionAfterFirst2 > 0 &&
                    (positionAfterFirst2) % 6 == 0) {
                  isAd = true;
                }

                if (isAd) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 0.h, top: 8.h),
                    child: _InlineGalleryAd(index: index),
                  );
                } else {
                  final adsBeforeThisPosition = ((positionAfterFirst2) / 6)
                      .floor();
                  videoIndex =
                      index -
                      adsBeforeThisPosition -
                      (positionAfterFirst2 >= 0 ? 1 : 0);
                }
              }

              // Return video item
              if (videoIndex < provider.videos.length) {
                return VideoListItem(
                  video: provider.videos[videoIndex],
                  onDelete: () =>
                      _confirmDelete(context, provider.videos[videoIndex]),
                );
              }

              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}

class _InlineGalleryAd extends StatelessWidget {
  final int index;

  const _InlineGalleryAd({required this.index});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final adWidget = CustomNativeAdWidget(
      key: ValueKey("InlineGalleryAd_${index}_$isDark"),
      factoryId: 'adFactoryGallery',
      height: 90.h,
      isGlass: false,
    );

    // Wrap in a builder to check if ad loaded
    return Consumer<PremiumProvider>(
      builder: (context, provider, _) {
        // Don't show ad card if premium or ads can't be requested
        if (provider.isPremium || !AdState.canRequestAds) {
          return const SizedBox.shrink();
        }

        // Show ad with card wrapper
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Card(
            margin: EdgeInsets.zero,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: adWidget,
            ),
          ),
        );
      },
    );
  }
}
