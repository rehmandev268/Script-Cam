import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/core/utils/responsive_config.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_application_6/core/constants/app_constants.dart';
import '../../data/models/video_model.dart';
import '../pages/video_player_screen.dart';
import '../../../../core/services/analytics_service.dart';

class VideoListItem extends StatefulWidget {
  final VideoRecord video;
  final VoidCallback onDelete;
  final VoidCallback? onLongPress;

  const VideoListItem({
    super.key,
    required this.video,
    required this.onDelete,
    this.onLongPress,
  });

  @override
  State<VideoListItem> createState() => _VideoListItemState();
}

class _VideoListItemState extends State<VideoListItem> {
  bool _isSharing = false;
  bool _exists = true; // Optimistically assume exists

  @override
  void initState() {
    super.initState();
    _checkFileExistence();
  }

  Future<void> _checkFileExistence() async {
    final exists = await File(widget.video.path).exists();
    if (mounted && exists != _exists) {
      setState(() => _exists = exists);
    }
  }

  Future<void> _shareVideo() async {
    if (_isSharing) return;

    setState(() => _isSharing = true);

    try {
      final file = File(widget.video.path);
      if (!await file.exists()) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context).videoFileNotFound),
            ),
          );
        }
        return;
      }

      AnalyticsService().logVideoShared(
        videoId: widget.video.key?.toString() ?? 'unknown',
        shareMethod: 'native_share',
      );

      // share_plus version 12 handles background I/O better if awaited properly
      await Share.shareXFiles(
        [XFile(widget.video.path)],
        subject: AppLocalizations.of(context).shareVideoSubject,
        text: AppLocalizations.of(context).shareVideoText,
      );
    } catch (e) {
      debugPrint("Error sharing video: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context).errorSharingVideo(e.toString()),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSharing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final fileName = widget.video.path.split('/').last;
    final scriptName = fileName.replaceAll('.mp4', '');
    return Card(
      child: Center(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          leading: Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(
              _exists ? Icons.play_arrow_rounded : Icons.broken_image_outlined,
              color: AppColors.primary,
              size: 26.sp,
            ),
          ),
          title: Text(
            scriptName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.w700,
              fontSize: 15.sp,
            ),
          ),
          subtitle: Text(
            '${DateFormat.Hm().format(widget.video.date)}  •  ${DateFormat.yMMMd().format(widget.video.date)}',
            style: TextStyle(fontSize: 12.sp, color: AppColors.textGrey),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_exists)
                _isSharing
                    ? SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primary,
                        ),
                      )
                    : IconButton(
                        icon: Icon(
                          Icons.share_outlined,
                          size: 20.sp,
                          color: AppColors.primary,
                        ),
                        onPressed: _shareVideo,
                      ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  size: 20.sp,
                  color: AppColors.error,
                ),
                onPressed: widget.onDelete,
              ),
            ],
          ),
          onLongPress: widget.onLongPress,
          onTap: _exists
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          FullScreenVideoPlayer(path: widget.video.path),
                    ),
                  );
                  AnalyticsService().logVideoPlayed(
                    videoId: widget.video.key?.toString() ?? 'unknown',
                    durationSeconds: 0,
                  );
                }
              : null,
        ),
      ),
    );
  }
}
