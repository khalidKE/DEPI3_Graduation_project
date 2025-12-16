import 'package:books/features/category_feature/data/category_info.dart';
import 'package:books/features/home_feature/data/home_models.dart';
import 'package:books/l10n/app_localizations.dart';

String localizedCategoryLabel(String value, AppLocalizations localizations) {
  switch (value.toLowerCase()) {
    case 'novel':
      return localizations.novel;
    case 'fiction':
      return localizations.fiction;
    case 'self love':
    case 'self_love':
      return localizations.self_love;
    case 'science':
      return localizations.science;
    case 'science fiction':
      return localizations.science_fiction;
    case 'literary criticism':
      return localizations.literary_criticism;
    case 'biography':
      return localizations.biography;
    case 'history':
      return localizations.history;
    case 'philosophy':
      return localizations.philosophy;
    case 'adventure':
      return localizations.adventure;
    case 'dystopian':
      return localizations.dystopian;
    case 'spirituality':
      return localizations.spirituality;
    case 'psychology':
      return localizations.psychology;
    case 'romantic':
      return localizations.romantic;
    case 'memoir':
      return localizations.memoir;
    case 'mystery':
      return localizations.mystery;
    case 'productivity':
      return localizations.productivity;
    case 'all':
      return localizations.all;
    default:
      return value;
  }
}

List<CategoryInfo> buildCategoryInfo(
  List<Book> books,
  AppLocalizations localizations,
) {
  final categories = <String>{};
  for (final book in books) {
    if (book.category.isNotEmpty) {
      categories.add(book.category);
    }
  }
  final ordered = ['All', ...categories];
  return ordered
      .map((value) => CategoryInfo(value: value, label: localizedCategoryLabel(value, localizations)))
      .toList();
}
