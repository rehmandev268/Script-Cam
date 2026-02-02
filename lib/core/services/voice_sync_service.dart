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

  Future<bool> initialize() async {
    if (_isInitialized) return true;
    try {
      _isInitialized = await _speech.initialize(
        onStatus: (status) {
          if (status == 'done' || status == 'notListening') {
            _isListening = false;
            notifyListeners();
          }
        },
        onError: (errorNotification) {
          _isListening = false;
          notifyListeners();
        },
      );
    } catch (e) {
      _isInitialized = false;
    }
    return _isInitialized;
  }

  void startListening(Function(String) onResult) async {
    if (!_isInitialized) {
      await initialize();
    }

    if (_isListening) {
      // Already listening, this call is redundant or potentially a restart
      return;
    }

    if (_isInitialized) {
      _isListening = true;
      _speech.listen(
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
      notifyListeners();
    }
  }

  void stopListening() {
    if (!_isListening) return;
    _speech.stop();
    _isListening = false;
    notifyListeners();
  }
}
