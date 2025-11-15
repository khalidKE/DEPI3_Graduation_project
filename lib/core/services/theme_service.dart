import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Service for managing app theme preferences (light/dark mode)
class ThemeService {
  static const String _boxName = 'app_settings_box';
  static const String _themeKey = 'app_theme';
  static const String _lightTheme = 'light';
  static const String _darkTheme = 'dark';
  
  static late Box _box;
  static ThemeMode _currentThemeMode = ThemeMode.light;
  static final ValueNotifier<ThemeMode> _themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.light);
  
  /// Stream to listen for theme changes
  static ValueNotifier<ThemeMode> get themeNotifier => _themeNotifier;

  /// Initialize the theme service
  static Future<void> initialize() async {
    _box = await Hive.openBox(_boxName);
    await _loadSavedTheme();
  }

  /// Load saved theme preference
  static Future<void> _loadSavedTheme() async {
    final savedTheme = _box.get(_themeKey, defaultValue: _lightTheme) as String;
    _currentThemeMode = savedTheme == _darkTheme ? ThemeMode.dark : ThemeMode.light;
    _themeNotifier.value = _currentThemeMode;
  }

  /// Get current theme mode
  static ThemeMode getCurrentThemeMode() {
    return _currentThemeMode;
  }

  /// Check if dark mode is enabled
  static bool isDarkMode() {
    return _currentThemeMode == ThemeMode.dark;
  }

  /// Toggle between light and dark theme
  static Future<void> toggleTheme() async {
    _currentThemeMode = _currentThemeMode == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
    await _box.put(_themeKey, _currentThemeMode == ThemeMode.dark ? _darkTheme : _lightTheme);
    _themeNotifier.value = _currentThemeMode;
  }

  /// Set theme mode
  static Future<void> setThemeMode(ThemeMode themeMode) async {
    _currentThemeMode = themeMode;
    await _box.put(_themeKey, themeMode == ThemeMode.dark ? _darkTheme : _lightTheme);
    _themeNotifier.value = _currentThemeMode;
  }
}

