import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_constants.dart';

class SettingsProvider extends ChangeNotifier {
  SharedPreferences? _prefs;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  // ───────────────── Cached Settings ─────────────────
  late bool _voiceGuidanceEnabled;
  late bool _darkModeEnabled;
  late String _selectedLanguage;

  bool get voiceGuidanceEnabled => _voiceGuidanceEnabled;
  bool get darkModeEnabled => _darkModeEnabled;
  String get selectedLanguage => _selectedLanguage;

  // ───────────────── Initialization ─────────────────

  Future<void> init() async {
    if (_isInitialized) return;

    try {
      _prefs = await SharedPreferences.getInstance();

      _voiceGuidanceEnabled = _prefs?.getBool(AppConstants.voiceGuidanceKey) ??
          AppConstants.defaultVoiceGuidance;

      _darkModeEnabled = _prefs?.getBool(AppConstants.darkModeKey) ??
          AppConstants.defaultDarkMode;

      _selectedLanguage = _prefs?.getString(AppConstants.languageKey) ??
          AppConstants.defaultLanguage;
    } catch (e) {
      debugPrint('❌ SettingsProvider init error: $e');

      // Fallback defaults
      _voiceGuidanceEnabled = AppConstants.defaultVoiceGuidance;
      _darkModeEnabled = AppConstants.defaultDarkMode;
      _selectedLanguage = AppConstants.defaultLanguage;
    }

    _isInitialized = true;
    notifyListeners();
  }

  // ───────────────── Update Methods ─────────────────

  Future<void> setVoiceGuidance(bool value) async {
    if (_voiceGuidanceEnabled == value) return;

    _voiceGuidanceEnabled = value;
    notifyListeners();
    await _prefs?.setBool(AppConstants.voiceGuidanceKey, value);
  }

  Future<void> setDarkMode(bool value) async {
    if (_darkModeEnabled == value) return;

    _darkModeEnabled = value;
    notifyListeners();
    await _prefs?.setBool(AppConstants.darkModeKey, value);
  }

  Future<void> setLanguage(String value) async {
    if (_selectedLanguage == value) return;

    _selectedLanguage = value;
    notifyListeners();
    await _prefs?.setString(AppConstants.languageKey, value);
  }

  // ───────────────── Utilities ─────────────────

  Future<void> resetToDefaults() async {
    _voiceGuidanceEnabled = AppConstants.defaultVoiceGuidance;
    _darkModeEnabled = AppConstants.defaultDarkMode;
    _selectedLanguage = AppConstants.defaultLanguage;

    notifyListeners();

    await _prefs?.setBool(AppConstants.voiceGuidanceKey, _voiceGuidanceEnabled);
    await _prefs?.setBool(AppConstants.darkModeKey, _darkModeEnabled);
    await _prefs?.setString(AppConstants.languageKey, _selectedLanguage);
  }
}
