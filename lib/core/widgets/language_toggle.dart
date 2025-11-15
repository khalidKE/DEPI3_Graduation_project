import 'package:flutter/material.dart';
import 'package:books/core/services/language_service.dart';
import 'package:books/l10n/app_localizations.dart';

/// Animated language toggle switch widget
class LanguageToggle extends StatefulWidget {
  final bool showLabel;
  final EdgeInsets? padding;
  final Color? activeColor;
  final Color? inactiveColor;

  const LanguageToggle({
    super.key,
    this.showLabel = true,
    this.padding,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  State<LanguageToggle> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<LanguageToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;
  bool _isArabic = LanguageService.isArabic();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _colorAnimation = ColorTween(
      begin: widget.inactiveColor ?? Colors.grey[300],
      end: widget.activeColor ?? const Color(0xFF6C47FF),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Set initial animation state
    if (_isArabic) {
      _animationController.value = 1.0;
    }
    
    // Listen to language changes to keep state in sync
    LanguageService.localeNotifier.addListener(_updateLanguageState);
  }

  @override
  void dispose() {
    LanguageService.localeNotifier.removeListener(_updateLanguageState);
    _animationController.dispose();
    super.dispose();
  }
  
  void _updateLanguageState() {
    if (!mounted) return;
    
    try {
      final newIsArabic = LanguageService.isArabic();
      if (_isArabic != newIsArabic) {
        setState(() {
          _isArabic = newIsArabic;
        });
        // Animate to the correct position
        _animationController.animateTo(_isArabic ? 1.0 : 0.0);
      }
    } catch (e) {
      debugPrint('Error updating language state: $e');
    }
  }

  Future<void> _toggleLanguage() async {
    if (!mounted) return;
    
    try {
      final newLocale = _isArabic
          ? const Locale('en')
          : const Locale('ar');

      // Change language - this will trigger the notifier and update state
      await LanguageService.setLanguage(newLocale);
      
      // Animation will be handled by _updateLanguageState
    } catch (e) {
      debugPrint('Error toggling language: $e');
      // Still update UI state even if there's an error
      if (mounted) {
        setState(() {
          _isArabic = LanguageService.isArabic();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.showLabel)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                localizations?.language ?? 'Language',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          GestureDetector(
            onTap: _toggleLanguage,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Container(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _colorAnimation.value,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Sliding indicator
                      Positioned(
                        left: _animationController.value * 40.0,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Language labels
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildLanguageLabel('AR', _isArabic),
                          _buildLanguageLabel('EN', !_isArabic),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageLabel(String text, bool isActive) {
    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 200),
      style: TextStyle(
        color: isActive ? Colors.white : Colors.grey[600],
        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        fontSize: 12,
      ),
      child: Text(text),
    );
  }
}

/// Compact language toggle button for app bars
class LanguageToggleButton extends StatefulWidget {
  const LanguageToggleButton({super.key});

  @override
  State<LanguageToggleButton> createState() => _LanguageToggleButtonState();
}

class _LanguageToggleButtonState extends State<LanguageToggleButton> {
  @override
  void initState() {
    super.initState();
    // Listen to language changes
    LanguageService.localeNotifier.addListener(_onLanguageChanged);
  }

  @override
  void dispose() {
    LanguageService.localeNotifier.removeListener(_onLanguageChanged);
    super.dispose();
  }

  void _onLanguageChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = LanguageService.isArabic();
    
    return IconButton(
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            scale: animation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        child: Container(
          key: ValueKey(isArabic),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF6C47FF).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF6C47FF),
              width: 1.5,
            ),
          ),
          child: Text(
            isArabic ? 'AR' : 'EN',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Color(0xFF6C47FF),
            ),
          ),
        ),
      ),
      tooltip: AppLocalizations.of(context)?.select_language ?? 'Select Language',
      onPressed: () async {
        if (!mounted) return;
        
        final newLocale = isArabic
            ? const Locale('en')
            : const Locale('ar');
        
        try {
          await LanguageService.setLanguage(newLocale);
          // The widget will rebuild automatically via the listener
        } catch (e) {
          debugPrint('Error changing language: $e');
          // Still update UI even if there's an error
          if (mounted) {
            setState(() {});
          }
        }
      },
    );
  }
}

