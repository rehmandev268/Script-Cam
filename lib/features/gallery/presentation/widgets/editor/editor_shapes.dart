import 'package:flutter/material.dart';
import 'package:flutter_application_6/core/constants/app_constants.dart';

class TrimDimmerPainter extends CustomPainter {
  final double start;
  final double end;

  TrimDimmerPainter({required this.start, required this.end});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withValues(alpha: 0.7);
    final borderPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final double startX = size.width * start;
    final double endX = size.width * end;

    canvas.drawRect(Rect.fromLTWH(0, 0, startX, size.height), paint);
    canvas.drawRect(
      Rect.fromLTWH(endX, 0, size.width - endX, size.height),
      paint,
    );

    canvas.drawLine(Offset(startX, 0), Offset(endX, 0), borderPaint);
    canvas.drawLine(
      Offset(startX, size.height),
      Offset(endX, size.height),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant TrimDimmerPainter oldDelegate) => true;
}

class ZeroPaddingTrackShape extends RoundedRectRangeSliderTrackShape {
  const ZeroPaddingTrackShape();

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    return Rect.fromLTWH(
      offset.dx,
      trackTop,
      parentBox.size.width,
      trackHeight,
    );
  }
}

class TrimSliderThumbShape extends RangeSliderThumbShape {
  final double width;
  const TrimSliderThumbShape({this.width = 12.0});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size(width, 60);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool? isOnTop,
    TextDirection? textDirection,
    required SliderThemeData sliderTheme,
    Thumb? thumb,
    bool? isPressed,
  }) {
    final Canvas canvas = context.canvas;
    final double height = sliderTheme.trackHeight ?? 60.0;

    final Rect rect = thumb == Thumb.start
        ? Rect.fromLTWH(
            center.dx - width,
            center.dy - height / 2,
            width,
            height,
          )
        : Rect.fromLTWH(center.dx, center.dy - height / 2, width, height);

    final paint = Paint()..color = AppColors.primary;

    RRect rRect;
    if (thumb == Thumb.start) {
      rRect = RRect.fromRectAndCorners(
        rect,
        topLeft: const Radius.circular(4),
        bottomLeft: const Radius.circular(4),
      );
    } else {
      rRect = RRect.fromRectAndCorners(
        rect,
        topRight: const Radius.circular(4),
        bottomRight: const Radius.circular(4),
      );
    }

    canvas.drawRRect(rRect, paint);

    final gripPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(rect.center.dx, rect.center.dy - 6),
      Offset(rect.center.dx, rect.center.dy + 6),
      gripPaint,
    );
  }
}
