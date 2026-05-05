import 'dart:async';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter/material.dart';

class VoiceSyncService extends ChangeNotifier {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _lastWords = '';

  bool get isListening => _isListening;
  String get lastWords => _lastWords;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  /// Kept so callers can re-register a result handler after STT auto-restarts.
  Function(String)? _activeResultCallback;

  Future<bool> initialize() async {
    if (_isInitialized) return true;
    try {
      _isInitialized = await _speech.initialize(
        onStatus: (status) {
          if (status == 'done' || status == 'notListening') {
            _isListening = false;
            notifyListeners();
            // STT ended its session on its own — restart after it fully cleans up.
            if (_activeResultCallback != null) {
              Future.delayed(const Duration(milliseconds: 300), () {
                if (_activeResultCallback != null && !_isListening) {
                  startListening(_activeResultCallback!);
                }
              });
            }
          }
        },
        onError: (errorNotification) {
          _isListening = false;
          // On permanent errors (e.g. permission revoked) clear the callback
          // so the auto-restart loop does not spin forever.
          if (errorNotification.permanent) {
            _activeResultCallback = null;
            _isInitialized = false;
          }
          notifyListeners();
        },
      );
    } catch (e) {
      _isInitialized = false;
    }
    return _isInitialized;
  }

  Future<void> startListening(Function(String) onResult) async {
    if (!_isInitialized) {
      final ok = await initialize();
      if (!ok) return;
    }

    if (_isListening) return;

    _activeResultCallback = onResult;

    final started = await _speech.listen(
      onResult: (result) {
        _lastWords = result.recognizedWords;
        onResult(_lastWords);
        notifyListeners();
      },
      listenOptions: stt.SpeechListenOptions(
        listenMode: stt.ListenMode.dictation,
        partialResults: true,
        cancelOnError: false,
      ),
    );
    _isListening = started ?? false;
    notifyListeners();
  }

  void stopListening() {
    _activeResultCallback = null;
    if (!_isListening) return;
    _speech.stop();
    _isListening = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _activeResultCallback = null;
    _speech.stop();
    _isListening = false;
    super.dispose();
  }
}
