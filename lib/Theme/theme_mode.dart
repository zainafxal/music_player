import 'package:flutter/material.dart';
import 'package:music_player/Theme/dark_mode.dart';
import 'package:music_player/Theme/light_mode.dart';

enum ThemeMode { light, dark }

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode; // Default theme is light
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode mode) {
    _themeMode = mode;
    _themeData = _themeMode == ThemeMode.light ? lightMode : darkMode;
    notifyListeners();
  }

  ThemeData get themeData => _themeData;
}
