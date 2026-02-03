import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityService extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  bool _isConnected = true;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  bool get isConnected => _isConnected;

  ConnectivityService() {
    _init();
  }

  Future<void> _init() async {
    // Check initial state
    final results = await _connectivity.checkConnectivity();
    _updateState(results);

    // Listen to changes
    _subscription = _connectivity.onConnectivityChanged.listen(_updateState);
  }

  void _updateState(List<ConnectivityResult> results) {
    // Treat as connected if any of the results are NOT none
    final connected = results.any(
      (result) => result != ConnectivityResult.none,
    );

    if (_isConnected != connected) {
      _isConnected = connected;
      notifyListeners();
    }
  }

  Future<void> checkConnection() async {
    final results = await _connectivity.checkConnectivity();
    _updateState(results);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
