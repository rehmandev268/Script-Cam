import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/core/utils/responsive_config.dart';
import 'package:flutter_application_6/core/constants/app_constants.dart';
import 'editor_shapes.dart';

class EditorTimeline extends StatelessWidget {
  final List<String> thumbnails;
  final bool generatingThumbnails;
  final double startTrim;
  final double endTrim;
  final Duration videoDuration;
  final Function(RangeValues) onTrimChanged;
  final Function(RangeValues) onTrimChangeEnd;

  const EditorTimeline({
    super.key,
    required this.thumbnails,
    required this.generatingThumbnails,
    required this.startTrim,
    required this.endTrim,
    required this.videoDuration,
    required this.onTrimChanged,
    required this.onTrimChangeEnd,
  });

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(d.inMinutes.remainder(60))}:${twoDigits(d.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    const double handleWidth = 12.0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Range",
              style: TextStyle(color: Colors.white70, fontSize: 12.sp),
            ),
            Text(
              "${_formatDuration(Duration(milliseconds: (startTrim * videoDuration.inMilliseconds).toInt()))} - ${_formatDuration(Duration(milliseconds: (endTrim * videoDuration.inMilliseconds).toInt()))}",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: handleWidth),
          child: SizedBox(
            height: 60.h,
            child: Stack(
              children: [
                _ThumbnailBar(
                  thumbnails: thumbnails,
                  generating: generatingThumbnails,
                ),
                Positioned.fill(
                  child: CustomPaint(
                    painter: TrimDimmerPainter(start: startTrim, end: endTrim),
                  ),
                ),
                Positioned.fill(
                  left: -handleWidth,
                  right: -handleWidth,
                  child: SliderTheme(
                    data: SliderThemeData(
                      rangeTrackShape: const ZeroPaddingTrackShape(),
                      rangeThumbShape: const TrimSliderThumbShape(width: 12.0),
                      activeTrackColor: Colors.transparent,
                      inactiveTrackColor: Colors.transparent,
                      overlayColor: Colors.transparent,
                      trackHeight: 60.h,
                    ),
                    child: RangeSlider(
                      values: RangeValues(startTrim, endTrim),
                      onChanged: onTrimChanged,
                      onChangeEnd: onTrimChangeEnd,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ThumbnailBar extends StatelessWidget {
  final List<String> thumbnails;
  final bool generating;

  const _ThumbnailBar({required this.thumbnails, required this.generating});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: thumbnails.isEmpty
              ? Center(
                  child: generating
                      ? const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primary,
                        )
                      : const Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                        ),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...thumbnails.map(
                      (path) => Expanded(
                        child: Image.file(
                          File(path),
                          fit: BoxFit.cover,
                          gaplessPlayback: true,
                        ),
                      ),
                    ),
                    if (thumbnails.length < 8)
                      ...List.generate(
                        8 - thumbnails.length,
                        (i) => const Expanded(child: SizedBox()),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
