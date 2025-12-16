import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app_data.dart';
import 'books_api_service.dart';
import 'home_models.dart';

/// Shared, persistent book inventory that admins can control.
class BookInventory {
  BookInventory._();

  static const _boxName = 'book_inventory';
  static const _booksKey = 'books';

  static final ValueNotifier<List<Book>> booksNotifier =
      ValueNotifier<List<Book>>(List<Book>.from(AppData.books));

  static Box<dynamic>? _box;
  static bool _initialized = false;

  static List<Book> get books => List.unmodifiable(booksNotifier.value);

  static Future<void> initialize() async {
    if (_initialized) return;
    _box = await Hive.openBox<dynamic>(_boxName);
    final stored = _box?.get(_booksKey);
    final hasStored = stored is List && stored.isNotEmpty;

    if (hasStored) {
      final parsed = stored
          .whereType<Map>()
          .map((data) => Book.fromMap(Map<String, dynamic>.from(data)))
          .toList();
      if (parsed.isNotEmpty) {
        booksNotifier.value = parsed;
      }
    }

    if (!hasStored) {
      final liveBooks = await BooksApiService.fetchFeaturedBooks();
      if (liveBooks.isNotEmpty) {
        booksNotifier.value = liveBooks;
        await _persist();
      } else {
        booksNotifier.value = List<Book>.from(AppData.books);
        await _persist();
      }
    }
    _initialized = true;
  }

  static String nextBookId() {
    final numericIds =
        booksNotifier.value.map((book) => int.tryParse(book.id) ?? 0).toList();
    final currentMax =
        numericIds.isEmpty ? 0 : numericIds.reduce((a, b) => a > b ? a : b);
    return (currentMax + 1).toString();
  }

  static Future<void> addBook(Book book) async {
    booksNotifier.value = [...booksNotifier.value, book];
    await _persist();
  }

  static Future<void> updateBook(String id, Book updatedBook) async {
    final books = [...booksNotifier.value];
    final index = books.indexWhere((book) => book.id == id);
    if (index == -1) return;
    books[index] = updatedBook.copyWith(id: id);
    booksNotifier.value = books;
    await _persist();
  }

  static Future<void> deleteBook(String id) async {
    booksNotifier.value =
        booksNotifier.value.where((book) => book.id != id).toList();
    await _persist();
  }

  static Book? getBookById(String id) {
    try {
      return booksNotifier.value.firstWhere((book) => book.id == id);
    } catch (_) {
      return null;
    }
  }

  static Future<void> _persist() async {
    final box = _box;
    if (box == null) return;
    final data = booksNotifier.value.map((b) => b.toMap()).toList();
    await box.put(_booksKey, data);
  }
}
