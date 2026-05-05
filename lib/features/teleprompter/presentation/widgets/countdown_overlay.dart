import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../../../../core/utils/responsive_config.dart';

class CountdownOverlay extends StatefulWidget {
  final int duration;
  final VoidCallback onFinished;
  const CountdownOverlay({
    super.key,
    required this.onFinished,
    required this.duration,
  });

  @override
  State<CountdownOverlay> createState() => _CountdownOverlayState();
}

class _CountdownOverlayState extends State<CountdownOverlay> {
  late int _count;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _count = widget.duration;
    _startTimer();
  }

  void _startTimer() async {
    HapticFeedback.heavyImpact();
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_count <= 1) {
        setState(() => _count = 0);
        timer.cancel();
        HapticFeedback.heavyImpact();
        widget.onFinished();
        return;
      }
      setState(() => _count--);
      HapticFeedback.mediumImpact();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_count == 0) return const SizedBox.shrink();

    return Container(
      color: Colors.black54,
      child: Center(
        child: Text(
          '$_count',
          style: TextStyle(
            color: Colors.white,
            fontSize: 120.sp,
            fontWeight: FontWeight.w900,
            shadows: [
              Shadow(
                blurRadius: 20,
                color: Colors.black,
                offset: Offset(0, 4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
