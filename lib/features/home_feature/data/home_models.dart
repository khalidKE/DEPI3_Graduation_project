class Book {
  final String id;
  final String title;
  final String author;
  final double price;
  final double rating;
  final String description;
  final String imageUrl;
  final bool isFavorite;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    required this.rating,
    required this.description,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Book copyWith({
    String? id,
    String? title,
    String? author,
    double? price,
    double? rating,
    String? description,
    String? imageUrl,
    bool? isFavorite,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class Author {
  final String id;
  final String name;
  final String role;
  final String bio;
  final double rating;
  final String imageUrl;
  final List<Book> books;

  const Author({
    required this.id,
    required this.name,
    required this.role,
    required this.bio,
    required this.rating,
    required this.imageUrl,
    required this.books,
  });
}

class Vendor {
  final String id;
  final String name;
  final double rating;
  final String imageUrl;

  const Vendor({
    required this.id,
    required this.name,
    required this.rating,
    required this.imageUrl,
  });
}
