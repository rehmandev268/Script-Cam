import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
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

  void _applyPreset(int? seconds) {
    if (videoDuration.inMilliseconds == 0) return;
    if (seconds == null) {
      onTrimChanged(const RangeValues(0.0, 1.0));
      onTrimChangeEnd(const RangeValues(0.0, 1.0));
      return;
    }
    final end = (seconds * 1000 / videoDuration.inMilliseconds).clamp(0.0, 1.0);
    final range = RangeValues(0.0, end);
    onTrimChanged(range);
    onTrimChangeEnd(range);
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(d.inMinutes.remainder(60))}:${twoDigits(d.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    const double handleWidth = 12.0;
    final presets = <({String label, int? seconds})>[
      (label: l10n.fullDuration, seconds: null),
      (label: '15s', seconds: 15),
      (label: '30s', seconds: 30),
      (label: '60s', seconds: 60),
      (label: '90s', seconds: 90),
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.range,
              style: TextStyle(color: Colors.white70, fontSize: 12.sp),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: presets.map((p) {
                final isDisabled =
                    p.seconds != null && p.seconds! >= videoDuration.inSeconds;
                return GestureDetector(
                  onTap: isDisabled ? null : () => _applyPreset(p.seconds),
                  child: Container(
                    margin: EdgeInsets.only(left: 6.w),
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: isDisabled
                          ? Colors.white10
                          : AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(
                        color: isDisabled
                            ? Colors.white12
                            : AppColors.primary.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Text(
                      p.label,
                      style: TextStyle(
                        color: isDisabled ? Colors.white24 : AppColors.primary,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${_formatDuration(Duration(milliseconds: (startTrim * videoDuration.inMilliseconds).toInt()))} – ${_formatDuration(Duration(milliseconds: (endTrim * videoDuration.inMilliseconds).toInt()))}",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
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
