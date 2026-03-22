import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme.dart';

enum AppThemes { light, dark }

class ThemeProvider extends ChangeNotifier {
  static const _prefKey = 'app_theme';
  late SharedPreferences _prefs;

  AppThemes _currentTheme = AppThemes.light;

  AppThemes get currentTheme => _currentTheme;

  ThemeData get themeData {
    switch (_currentTheme) {
      case AppThemes.dark:
        return AppTheme.darkTheme;
      case AppThemes.light:
      default:
        return AppTheme.lightTheme;
    }
  }

  bool get isDarkMode => _currentTheme == AppThemes.dark;

  ThemeProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _loadTheme();
    } catch (e) {
      debugPrint('❌ Error initializing SharedPreferences: $e');
      _currentTheme = AppThemes.light;
      notifyListeners();
    }
  }

  void _loadTheme() {
    final themeIndex = _prefs.getInt(_prefKey);
    if (themeIndex != null && themeIndex < AppThemes.values.length) {
      _currentTheme = AppThemes.values[themeIndex];
    } else {
      _currentTheme = AppThemes.light;
    }
    notifyListeners();
  }

  Future<void> _saveTheme() async {
    try {
      await _prefs.setInt(_prefKey, _currentTheme.index);
    } catch (e) {
      debugPrint('❌ Error saving theme: $e');
    }
  }

  Future<void> setTheme(AppThemes theme) async {
    if (_currentTheme != theme) {
      _currentTheme = theme;
      await _saveTheme();
      notifyListeners();
    }
  }

  Future<void> toggleTheme() async {
    _currentTheme = isDarkMode ? AppThemes.light : AppThemes.dark;
    await _saveTheme();
    notifyListeners();
  }
}
