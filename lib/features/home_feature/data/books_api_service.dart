import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'home_models.dart';

/// Fetches live book data from Google Books to keep the catalog real.
class BooksApiService {
  BooksApiService._();

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://www.googleapis.com/books/v1/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  static Future<List<Book>> fetchFeaturedBooks() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        'volumes',
        queryParameters: const {
          'q': 'subject:fiction',
          'orderBy': 'relevance',
          'maxResults': 20,
          'printType': 'books',
        },
      );

      final items = response.data?['items'];
      if (items is! List) return [];

      final books = items
          .map<Book?>((item) => _parseBook(item as Map<String, dynamic>))
          .whereType<Book>()
          .toList();

      return books;
    } catch (e, stack) {
      debugPrint('Failed to fetch books: $e\n$stack');
      return [];
    }
  }

  static Book? _parseBook(Map<String, dynamic> map) {
    final volumeInfo = map['volumeInfo'] as Map<String, dynamic>? ?? {};
    final saleInfo = map['saleInfo'] as Map<String, dynamic>? ?? {};
    final images = volumeInfo['imageLinks'] as Map<String, dynamic>? ?? {};

    final title = (volumeInfo['title'] as String?)?.trim();
    if (title == null || title.isEmpty) return null;

    final authors = volumeInfo['authors'] as List?;
    final author =
        (authors != null && authors.isNotEmpty) ? authors.first.toString() : 'Unknown author';

    final rawDescription = (volumeInfo['description'] as String? ?? '').trim();
    final description = rawDescription.isNotEmpty
        ? rawDescription.replaceAll(RegExp(r'\s+'), ' ')
        : 'No description available yet.';

    final rating = _parseRating(volumeInfo['averageRating']);
    final price = _parsePrice(saleInfo) ?? _estimatePrice(volumeInfo['pageCount']);

    final imageUrl =
      (images['thumbnail'] ?? images['smallThumbnail'] ?? images['medium'] ?? '').toString();
    final categoryList = volumeInfo['categories'];
    final category = (categoryList is List && categoryList.isNotEmpty)
        ? categoryList.first.toString()
        : 'General';

    return Book(
      id: (map['id'] ?? title).toString(),
      title: title,
      author: author,
      price: price,
      rating: rating,
      description: description,
      imageUrl: imageUrl,
      category: category.replaceAll(RegExp(r'\s+'), ' ').trim(),
    );
  }

  static double _parseRating(dynamic rating) {
    if (rating is num) {
      return double.parse(rating.toStringAsFixed(1));
    }
    return 4.0;
  }

  static double? _parsePrice(Map<String, dynamic> saleInfo) {
    final listPrice = saleInfo['listPrice'];
    if (listPrice is Map && listPrice['amount'] is num) {
      return (listPrice['amount'] as num).toDouble();
    }

    final retailPrice = saleInfo['retailPrice'];
    if (retailPrice is Map && retailPrice['amount'] is num) {
      return (retailPrice['amount'] as num).toDouble();
    }

    return null;
  }

  static double _estimatePrice(dynamic pageCount) {
    if (pageCount is num && pageCount > 0) {
      final estimated = (pageCount / 28).clamp(8, 42);
      return double.parse(estimated.toStringAsFixed(2));
    }
    return 14.50;
  }
}
