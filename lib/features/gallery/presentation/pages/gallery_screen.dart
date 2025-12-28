import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_config.dart';
import '../../../../core/utils/toast_service.dart';
import '../../../../widgets/common/adaptive_app_bar.dart';
import '../../../../widgets/ads/native_ad_widget.dart';
import '../../data/models/video_model.dart';
import '../providers/gallery_provider.dart';
import 'video_player_screen.dart';

class GalleryScreen extends StatefulWidget {
  final VoidCallback? onGoToStudio;

  const GalleryScreen({super.key, this.onGoToStudio});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  void _confirmDelete(BuildContext context, VideoRecord video) async {
    bool confirm =
        await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Delete Video?", style: TextStyle(fontSize: 18.sp)),
            content: Text(
              "This cannot be undone.",
              style: TextStyle(fontSize: 14.sp),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text("Cancel", style: TextStyle(fontSize: 14.sp)),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(
                  "Delete",
                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                ),
              ),
            ],
          ),
        ) ??
        false;

    if (confirm && mounted) {
      Provider.of<GalleryProvider>(context, listen: false).deleteVideo(video);
      ToastService.show("Video deleted", isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,

      appBar: const AdaptiveAppBar(
        title: "Gallery",
        showBackButton: false, // Main Tab
      ),

      body: Column(
        children: [
          Consumer<GalleryProvider>(
            builder: (context, provider, _) {
              if (provider.videos.length < 4) return const SizedBox.shrink();
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: CustomNativeAdWidget(
                  key: ValueKey("GalleryAd_$isDark"),
                  factoryId: 'adFactoryGallery',
                  height: 72.h,
                  isGlass: false,
                ),
              );
            },
          ),

          Expanded(
            child: Consumer<GalleryProvider>(
              builder: (context, provider, _) {
                if (provider.videos.isEmpty) {
                  return Center(
                    child: FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      child: Padding(
                        padding: EdgeInsets.all(40.0.r),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(30.r),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppColors.darkSurface
                                    : AppColors.lightSurface,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isDark
                                      ? AppColors.borderDark
                                      : AppColors.borderLight,
                                ),
                              ),
                              child: Icon(
                                Icons.video_library_outlined,
                                size: 40.sp,
                                color: AppColors.textGrey,
                              ),
                            ),
                            SizedBox(height: 25.h),
                            Text(
                              "Gallery Empty",
                              style: GoogleFonts.manrope(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? AppColors.textWhite
                                    : AppColors.textBlack,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "Your recordings will appear here.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.textGrey,
                                height: 1.5,
                                fontSize: 13.sp,
                              ),
                            ),
                            SizedBox(height: 30.h),
                            ElevatedButton.icon(
                              onPressed: widget.onGoToStudio,
                              icon: Icon(Icons.add_rounded, size: 18.sp),
                              label: Text(
                                "Create Recording",
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.w,
                                  vertical: 12.h,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 100.h),
                  physics: const BouncingScrollPhysics(),
                  itemCount: provider.videos.length,
                  itemBuilder: (ctx, i) {
                    final video = provider.videos[i];
                    bool exists = File(video.path).existsSync();

                    return FadeInUp(
                      delay: Duration(milliseconds: i * 50),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8.h),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.darkSurface
                              : AppColors.lightSurface,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: isDark
                                ? AppColors.borderDark
                                : AppColors.borderLight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                isDark ? 0.3 : 0.03,
                              ),
                              blurRadius: 10.r,
                              offset: Offset(0, 4.h),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          leading: Container(
                            width: 50.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: Icon(
                              exists
                                  ? Icons.play_arrow_rounded
                                  : Icons.broken_image_outlined,
                              color: AppColors.primary,
                              size: 26.sp,
                            ),
                          ),
                          title: Text(
                            "Recording ${i + 1}",
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                              color: isDark
                                  ? AppColors.textWhite
                                  : AppColors.textBlack,
                            ),
                          ),
                          subtitle: Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Text(
                              DateFormat.yMMMd().format(video.date),
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.textGrey,
                              ),
                            ),
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
                                  onPressed: () =>
                                      Share.shareXFiles([XFile(video.path)]),
                                ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete_outline,
                                  size: 20.sp,
                                  color: AppColors.accent,
                                ),
                                onPressed: () => _confirmDelete(context, video),
                              ),
                            ],
                          ),
                          onTap: exists
                              ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => FullScreenVideoPlayer(
                                        path: video.path,
                                      ),
                                    ),
                                  );
                                }
                              : null,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
