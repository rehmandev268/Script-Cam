import 'package:flutter/material.dart';

class ToastService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void show(String message, {bool isError = false}) {}
}
