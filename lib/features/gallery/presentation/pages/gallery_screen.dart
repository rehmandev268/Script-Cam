import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_6/core/utils/responsive_config.dart';
import 'package:flutter_application_6/core/utils/toast_service.dart';
import 'package:flutter_application_6/widgets/common/adaptive_app_bar.dart';
import '../../data/models/video_model.dart';
import '../providers/gallery_provider.dart';
import '../widgets/gallery_video_list_item.dart';
import '../widgets/gallery_empty_state.dart';
import 'package:flutter_application_6/core/utils/app_dialogs.dart';
import 'package:flutter_application_6/core/services/analytics_service.dart';

class GalleryScreen extends StatefulWidget {
  final VoidCallback? onGoToStudio;
  final double bottomPadding;

  const GalleryScreen({super.key, this.onGoToStudio, this.bottomPadding = 100});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final Set<dynamic> _selectedKeys = {};
  bool _isSelecting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<GalleryProvider>();
      AnalyticsService().logGalleryOpened(totalVideos: provider.videos.length);
    });
  }

  void _toggleSelect(VideoRecord video) {
    HapticFeedback.selectionClick();
    setState(() {
      final key = video.key;
      if (_selectedKeys.contains(key)) {
        _selectedKeys.remove(key);
        if (_selectedKeys.isEmpty) _isSelecting = false;
      } else {
        _selectedKeys.add(key);
      }
    });
  }

  void _enterSelectMode(VideoRecord video) {
    HapticFeedback.mediumImpact();
    setState(() {
      _isSelecting = true;
      _selectedKeys.add(video.key);
    });
  }

  void _cancelSelect() {
    setState(() {
      _isSelecting = false;
      _selectedKeys.clear();
    });
  }

  Future<void> _confirmDelete(BuildContext context, VideoRecord video) async {
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
      HapticFeedback.mediumImpact();
      galleryProvider.deleteVideo(video);
      ToastService.show(l10n.videoDeleted, isError: true);
    }
  }

  Future<void> _bulkDelete(BuildContext context) async {
    if (_selectedKeys.isEmpty) return;
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final count = _selectedKeys.length;
    final confirm = await AppDialogs.showConfirmDelete(
      context: context,
      title: l10n.bulkDeleteRecordingsTitle(count),
      content: l10n.deleteScriptMessage,
      isDark: isDark,
    );
    if (!confirm || !mounted) return;
    HapticFeedback.mediumImpact();
    final provider = context.read<GalleryProvider>();
    final toDelete = provider.videos
        .where((v) => _selectedKeys.contains(v.key))
        .toList();
    for (final v in toDelete) {
      await provider.deleteVideo(v);
    }
    if (!mounted) return;
    setState(() {
      _isSelecting = false;
      _selectedKeys.clear();
    });
    ToastService.show(l10n.recordingsDeletedToast(count), isError: true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AdaptiveAppBar(
        title: _isSelecting
            ? l10n.itemsSelected(_selectedKeys.length)
            : l10n.tabRecordings,
        showBackButton: false,
        actions: _isSelecting
            ? [
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                  onPressed: () => _bulkDelete(context),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: _cancelSelect,
                ),
              ]
            : null,
      ),
      body: SafeArea(
        top: false,
        child: Consumer<GalleryProvider>(
          builder: (context, provider, _) {
            final videos = provider.videos;
            if (videos.isEmpty) {
              return EmptyGalleryState(
                onGoToStudio: () => widget.onGoToStudio?.call(),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.fromLTRB(
                20.w,
                12.h,
                20.w,
                widget.bottomPadding,
              ),
              physics: const BouncingScrollPhysics(),
              itemCount: videos.length,
              itemBuilder: (ctx, index) {
              final video = videos[index];
              final currentDate = DateUtils.dateOnly(video.date);
              final showHeader =
                  index == 0 ||
                  DateUtils.dateOnly(videos[index - 1].date) != currentDate;
              final isSelected = _selectedKeys.contains(video.key);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showHeader)
                    Padding(
                      padding: EdgeInsets.only(top: index == 0 ? 0 : 12.h, bottom: 8.h),
                      child: Text(
                        MaterialLocalizations.of(context).formatMediumDate(currentDate),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  _isSelecting
                      ? _SelectableVideoItem(
                          video: video,
                          isSelected: isSelected,
                          onTap: () => _toggleSelect(video),
                        )
                      : VideoListItem(
                          video: video,
                          onDelete: () => _confirmDelete(context, video),
                          onLongPress: () => _enterSelectMode(video),
                        ),
                ],
              );
              },
            );
          },
        ),
      ),
    );
  }
}

class _SelectableVideoItem extends StatelessWidget {
  final VideoRecord video;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectableVideoItem({
    required this.video,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final name = video.path.split('/').last.replaceAll('.mp4', '');
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.12)
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 24.w,
              height: 24.w,
              margin: EdgeInsets.only(right: 12.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
            Icon(Icons.videocam_rounded,
                color: Theme.of(context).colorScheme.primary, size: 22.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
