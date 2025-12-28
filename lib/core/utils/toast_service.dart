import 'package:flutter/material.dart';
import 'dart:async';

class ToastService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static OverlayEntry? _overlayEntry;
  static Timer? _timer;

  static void show(String message, {bool isError = false}) {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _timer?.cancel();
    }

    final overlayState = navigatorKey.currentState?.overlay;
    if (overlayState == null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        final theme = Theme.of(context);
        final isDarkMode = theme.brightness == Brightness.dark;
        final errorColor = theme.colorScheme.error;

        Color backgroundColor;
        Color contentColor;
        BoxBorder? border;

        if (isError) {
          backgroundColor = isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
          contentColor = errorColor;
          border = Border.all(color: errorColor, width: 2.0);
        } else {
          backgroundColor = isDarkMode ? Colors.white : const Color(0xFF333333);
          contentColor = isDarkMode ? Colors.black : Colors.white;
          border = null;
        }

        return Positioned(
          top: 65.0,
          left: 16.0,
          right: 16.0,
          child: Material(
            color: Colors.transparent,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  border: border,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      isError
                          ? Icons.error_outline
                          : Icons.check_circle_outline,
                      color: contentColor,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        message,
                        style: TextStyle(
                          color: contentColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _overlayEntry?.remove();
                        _overlayEntry = null;
                      },
                      child: Icon(Icons.close, color: contentColor, size: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    overlayState.insert(_overlayEntry!);

    _timer = Timer(const Duration(seconds: 3), () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }
}
