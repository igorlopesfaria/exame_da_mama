import 'package:flutter/material.dart';
import 'package:flora/core/theme/flora_theme_base.dart';

enum FloraThemeMode { light, dark }

class FloraThemeProvider extends ChangeNotifier {
  FloraThemeProvider._();

  static final FloraThemeProvider instance = FloraThemeProvider._();

  FloraThemeMode _mode = FloraThemeMode.light;

  FloraThemeMode get mode => _mode;

  ThemeData get theme =>
      _mode == FloraThemeMode.light ? FloraThemeBase.light : FloraThemeBase.dark;

  void setTheme(FloraThemeMode mode) {
    if (_mode == mode) return;
    _mode = mode;
    notifyListeners();
  }

  void setDesignSystemTheme() {
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    setTheme(brightness == Brightness.dark ? FloraThemeMode.dark : FloraThemeMode.light);
  }
}
