import 'package:flutter/material.dart';
import 'package:books/core/services/theme_service.dart';

/// Widget for toggling between light and dark theme
class ThemeToggleButton extends StatefulWidget {
  const ThemeToggleButton({super.key});

  @override
  State<ThemeToggleButton> createState() => _ThemeToggleButtonState();
}

class _ThemeToggleButtonState extends State<ThemeToggleButton> {
  @override
  void initState() {
    super.initState();
    // Listen to theme changes
    ThemeService.themeNotifier.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    ThemeService.themeNotifier.removeListener(_onThemeChanged);
    super.dispose();
  }

  void _onThemeChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeService.isDarkMode();
    
    return IconButton(
      icon: Icon(
        isDark ? Icons.light_mode : Icons.dark_mode,
        color: Theme.of(context).iconTheme.color,
      ),
      tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
      onPressed: () async {
        await ThemeService.toggleTheme();
      },
    );
  }
}

