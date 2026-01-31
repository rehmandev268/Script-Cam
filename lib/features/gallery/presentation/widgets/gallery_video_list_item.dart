import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/core/utils/responsive_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_application_6/core/constants/app_constants.dart';
import '../../data/models/video_model.dart';
import '../pages/video_player_screen.dart';
import '../../../../core/services/analytics_service.dart';

class VideoListItem extends StatelessWidget {
  final VideoRecord video;
  final VoidCallback onDelete;

  const VideoListItem({super.key, required this.video, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final bool exists = File(video.path).existsSync();

    return Card(
      // margin: EdgeInsets.symmetric(vertical: 8.h),
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
              exists ? Icons.play_arrow_rounded : Icons.broken_image_outlined,
              color: AppColors.primary,
              size: 26.sp,
            ),
          ),
          title: Text(
            video.path.split('/').last,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.w700,
              fontSize: 15.sp,
            ),
          ),
          subtitle: Text(
            DateFormat.yMMMd().format(video.date),
            style: TextStyle(fontSize: 12.sp, color: AppColors.textGrey),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (exists)
                IconButton(
                  icon: Icon(
                    Icons.share_outlined,
                    size: 20.sp,
                    color: AppColors.primary,
                  ),
                  onPressed: () {
                    AnalyticsService().logVideoShared(
                      videoId: video.key?.toString() ?? 'unknown',
                      shareMethod: 'native_share',
                    );
                    Share.shareXFiles([XFile(video.path)]);
                  },
                ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  size: 20.sp,
                  color: AppColors.error,
                ),
                onPressed: onDelete,
              ),
            ],
          ),
          onTap: exists
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FullScreenVideoPlayer(path: video.path),
                    ),
                  );
                  AnalyticsService().logVideoPlayed(
                    videoId: video.key?.toString() ?? 'unknown',
                    durationSeconds: 0,
                  );
                }
              : null,
        ),
      ),
    );
  }
}
