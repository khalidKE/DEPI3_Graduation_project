import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Service for managing app language preferences
class LanguageService {
  static const String _boxName = 'app_settings_box';
  static const String _languageKey = 'app_language';
  static const String _defaultLanguage = 'ar';
  
  static late Box _box;
  static Locale _currentLocale = const Locale(_defaultLanguage);

  /// Initialize the language service
  static Future<void> initialize() async {
    _box = await Hive.openBox(_boxName);
    await _loadSavedLanguage();
  }

  /// Load saved language preference
  static Future<void> _loadSavedLanguage() async {
    final savedLanguage = _box.get(_languageKey, defaultValue: _defaultLanguage) as String;
    _currentLocale = Locale(savedLanguage);
  }

  /// Get current locale
  static Locale getCurrentLocale() {
    return _currentLocale;
  }

  /// Set app language
  static Future<void> setLanguage(Locale locale) async {
    if (!_isSupportedLocale(locale)) {
      throw ArgumentError('Unsupported locale: ${locale.languageCode}');
    }
    
    _currentLocale = locale;
    await _box.put(_languageKey, locale.languageCode);
  }

  /// Set language by language code
  static Future<void> setLanguageByCode(String languageCode) async {
    await setLanguage(Locale(languageCode));
  }

  /// Check if locale is supported
  static bool _isSupportedLocale(Locale locale) {
    return ['ar', 'en'].contains(locale.languageCode);
  }

  /// Get supported locales
  static List<Locale> getSupportedLocales() {
    return const [
      Locale('ar'),
      Locale('en'),
    ];
  }

  /// Get language display name
  static String getLanguageDisplayName(String languageCode, BuildContext context) {
    switch (languageCode) {
      case 'ar':
        return 'العربية'; // Arabic
      case 'en':
        return 'English';
      default:
        return languageCode;
    }
  }

  /// Get language code from locale
  static String getLanguageCode(Locale locale) {
    return locale.languageCode;
  }

  /// Check if current language is Arabic
  static bool isArabic() {
    return _currentLocale.languageCode == 'ar';
  }

  /// Check if current language is English
  static bool isEnglish() {
    return _currentLocale.languageCode == 'en';
  }
}

