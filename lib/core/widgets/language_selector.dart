import 'package:flutter/material.dart';
import 'package:books/core/services/language_service.dart';
import 'package:books/l10n/app_localizations.dart';

/// Widget for selecting app language
class LanguageSelector extends StatelessWidget {
  final bool showTitle;
  final EdgeInsets? padding;

  const LanguageSelector({
    super.key,
    this.showTitle = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final currentLocale = LanguageService.getCurrentLocale();
    final supportedLocales = LanguageService.getSupportedLocales();

    return Padding(
      padding: padding ?? const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showTitle)
            Text(
              localizations?.select_language ?? 'Select Language',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          if (showTitle) const SizedBox(height: 16),
          ...supportedLocales.map((locale) {
            final isSelected = locale.languageCode == currentLocale.languageCode;
            final displayName = LanguageService.getLanguageDisplayName(
              locale.languageCode,
              context,
            );

            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: InkWell(
                onTap: () async {
                  await LanguageService.setLanguage(locale);
                  // Rebuild the app to reflect language change
                  // This will be handled by the main app's locale listener
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.grey.withValues(alpha: 0.3),
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          displayName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : Colors.black,
                          ),
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          color: Theme.of(context).primaryColor,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

/// Dialog version of language selector
class LanguageSelectorDialog extends StatelessWidget {
  const LanguageSelectorDialog({super.key});

  static Future<void> show(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context)?.select_language ?? 'Select Language',
          ),
          content: const LanguageSelector(showTitle: false),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                AppLocalizations.of(context)?.cancel ?? 'Cancel',
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const LanguageSelector();
  }
}

