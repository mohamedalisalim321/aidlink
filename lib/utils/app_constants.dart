class AppConstants {
  // App info
  static const String appName = 'AidLink';
  static const String appSubtitle = 'Offline Emergency Guide';
  static const String appVersion = '1.0.0';

  // Emergency call
  static const String defaultEmergencyNumber = '911';

  // Hive box names
  static const String settingsBox = 'settings_box';

  // Hive keys
  static const String voiceGuidanceKey = 'voice_guidance';
  static const String darkModeKey = 'dark_mode';
  static const String languageKey = 'language';

  // Default settings
  static const bool defaultVoiceGuidance = true;
  static const bool defaultDarkMode = false;
  static const String defaultLanguage = 'English';

  // TTS
  static const double ttsVolume = 1.0;
  static const double ttsRate = 0.45;
  static const double ttsPitch = 1.0;
  static const String ttsLanguage = 'en-US';

  // Splash duration
  static const Duration splashDuration = Duration(seconds: 3);
}
