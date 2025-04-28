import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  bool _isTouchingScreen = false;
  bool _isStreamMode = false;

  bool get isTouchingScreen => _isTouchingScreen;
  bool get isStreamMode => _isStreamMode;

  void enableTouchingScreen() {
    _isTouchingScreen = true;
    notifyListeners();
  }

  void disableTouchingScreen() {
    _isTouchingScreen = false;
    notifyListeners();
  }

  void toggleStreamMode() {
    _isStreamMode = !_isStreamMode;
    notifyListeners();
  }
}
