import 'package:books/features/home_feature/data/home_models.dart';
import 'package:flutter/foundation.dart';

/// Simple in-memory favorites tracker for book cards.
class FavoritesNotifier extends ValueNotifier<Set<String>> {
  FavoritesNotifier._() : super(const {});

  static final FavoritesNotifier instance = FavoritesNotifier._();

  bool isFavorite(Book book) => value.contains(book.id);

  bool toggle(Book book) {
    final ids = Set<String>.from(value);
    final added = ids.add(book.id);
    if (!added) {
      ids.remove(book.id);
    }
    value = ids;
    return added;
  }
}
