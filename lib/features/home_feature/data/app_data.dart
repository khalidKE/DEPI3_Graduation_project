import 'package:books/features/home_feature/data/home_models.dart';

class AppData {
  static const List<Book> books = [
    Book(
      id: '1',
      title: 'The Kite Runner',
      author: 'Khaled Hosseini',
      price: 16.99,
      rating: 4.7,
      description:
          'A sweeping story of friendship, betrayal, and redemption set against Afghanistan\'s turbulent history.',
      imageUrl: 'assets/images/books/kite_runner.jpg',
      category: 'Novel',
    ),
    Book(
      id: '2',
      title: 'The Subtle Art of Not Giving a F*ck',
      author: 'Mark Manson',
      price: 14.99,
      rating: 4.5,
      description:
          'A blunt, refreshing guide to focusing energy on what truly matters and letting go of what doesn\'t.',
      imageUrl: 'assets/images/books/subtle_art.jpg',
      category: 'Self Love',
    ),
    Book(
      id: '3',
      title: 'The Da Vinci Code',
      author: 'Dan Brown',
      price: 12.50,
      rating: 4.4,
      description:
          'Symbologist Robert Langdon races through Paris and London to unravel a secret that could upend history.',
      imageUrl: 'assets/images/books/da_vinci_code.jpg',
      category: 'Novel',
    ),
    Book(
      id: '4',
      title: 'Atomic Habits',
      author: 'James Clear',
      price: 18.99,
      rating: 4.8,
      description:
          'A practical playbook for building small habits that compound into remarkable personal and professional change.',
      imageUrl: 'assets/images/book1.png',
      category: 'Productivity',
    ),
    Book(
      id: '5',
      title: 'Educated',
      author: 'Tara Westover',
      price: 17.49,
      rating: 4.7,
      description:
          'A memoir of a woman who leaves her isolated upbringing to pursue education and define her own future.',
      imageUrl: 'assets/images/book2.png',
      category: 'Memoir',
    ),
    Book(
      id: '6',
      title: 'Where the Crawdads Sing',
      author: 'Delia Owens',
      price: 15.25,
      rating: 4.6,
      description:
          'A coming-of-age mystery about a resilient girl growing up alone in the marshes of North Carolina.',
      imageUrl: 'assets/images/book3.png',
      category: 'Mystery',
    ),
    Book(
      id: '7',
      title: 'Dune',
      author: 'Frank Herbert',
      price: 19.99,
      rating: 4.6,
      description:
          'An epic saga of politics, prophecy, and desert survival on the sand-covered planet Arrakis.',
      imageUrl: 'assets/images/book1.png',
      category: 'Science Fiction',
    ),
    Book(
      id: '8',
      title: 'The Diary of a Young Girl',
      author: 'Anne Frank',
      price: 12.49,
      rating: 4.8,
      description:
          'The heartfelt journals of Anne Frank as she hides from the Nazis, offering courage and humanity.',
      imageUrl: 'assets/images/book2.png',
      category: 'Biography',
    ),
    Book(
      id: '9',
      title: 'Sapiens: A Brief History of Humankind',
      author: 'Yuval Noah Harari',
      price: 22.00,
      rating: 4.7,
      description:
          'A sweeping narrative that traces humanity’s development from hunter-gatherers to today’s global civilization.',
      imageUrl: 'assets/images/book3.png',
      category: 'History',
    ),
    Book(
      id: '10',
      title: 'The Elements of Literary Criticism',
      author: 'James Wood',
      price: 21.50,
      rating: 4.4,
      description:
          'Essays that analyze why literature works, blending clarity with close reading of classic works.',
      imageUrl: 'assets/images/book2.png',
      category: 'Literary Criticism',
    ),
    Book(
      id: '11',
      title: 'Meditations',
      author: 'Marcus Aurelius',
      price: 14.25,
      rating: 4.5,
      description:
          'A timeless journal of Stoic philosophy from the Roman emperor about virtue and inner calm.',
      imageUrl: 'assets/images/book1.png',
      category: 'Philosophy',
    ),
    Book(
      id: '12',
      title: 'The Alchemist',
      author: 'Paulo Coelho',
      price: 13.99,
      rating: 4.2,
      description:
          'A shepherd boy follows his dreams across the desert, learning to read omens and trust the universe.',
      imageUrl: 'assets/images/book2.png',
      category: 'Adventure',
    ),
    Book(
      id: '13',
      title: 'Brave New World',
      author: 'Aldous Huxley',
      price: 16.50,
      rating: 4.3,
      description:
          'A prophetic vision of a future society shaped by engineered happiness and total control.',
      imageUrl: 'assets/images/book3.png',
      category: 'Dystopian',
    ),
    Book(
      id: '14',
      title: 'The Power of Now',
      author: 'Eckhart Tolle',
      price: 13.45,
      rating: 4.4,
      description:
          'Guidance for letting go of worry and connecting with the present moment to find inner peace.',
      imageUrl: 'assets/images/book1.png',
      category: 'Spirituality',
    ),
    Book(
      id: '15',
      title: 'Thinking, Fast and Slow',
      author: 'Daniel Kahneman',
      price: 18.75,
      rating: 4.5,
      description:
          'A psychologist explains how intuitive and deliberate thinking shape our choices and mistakes.',
      imageUrl: 'assets/images/book2.png',
      category: 'Psychology',
    ),
  ];

  static const Map<String, String> _bookAssetPaths = {
    'the kite runner': 'assets/images/books/kite_runner.jpg',
    'the subtle art of not giving a f*ck': 'assets/images/books/subtle_art.jpg',
    'the da vinci code': 'assets/images/books/da_vinci_code.jpg',
    'atomic habits': 'assets/images/book1.png',
    'educated': 'assets/images/book2.png',
    'where the crawdads sing': 'assets/images/book3.png',
  };

  static const String _defaultAuthorImage = 'assets/images/Photo.png';

  static const Map<String, String> _authorAssetPaths = {
    'khaled hosseini': 'assets/images/home/a1.png',
    'mark manson': 'assets/images/home/a2.png',
    'dan brown': 'assets/images/home/a3.png',
    'james clear': 'assets/images/home/a4.png',
    'tara westover': 'assets/images/home/a5.png',
    'delia owens': 'assets/images/home/a6.png',
  };

  static String resolveBookImage(Book book) {
    final key = book.title.trim().toLowerCase();
    return _bookAssetPaths[key] ?? book.imageUrl;
  }

  static String resolveAuthorImage(String authorName) {
    final key = authorName.trim().toLowerCase();
    return _authorAssetPaths[key] ?? _defaultAuthorImage;
  }

  static const List<Vendor> vendors = [
    Vendor(
        id: '1',
        name: 'Amazon Books',
        rating: 4.8,
        imageUrl: 'assets/images/home/v1.png'),
    Vendor(
        id: '2',
        name: 'Barnes & Noble',
        rating: 4.7,
        imageUrl: 'assets/images/home/v2.png'),
    Vendor(
        id: '3',
        name: 'Bookshop.org',
        rating: 4.6,
        imageUrl: 'assets/images/home/v3.png'),
    Vendor(
        id: '4',
        name: 'Kobo',
        rating: 4.4,
        imageUrl: 'assets/images/home/v4.png'),
    Vendor(
        id: '5',
        name: 'Audible',
        rating: 4.5,
        imageUrl: 'assets/images/home/v5.png'),
    Vendor(
        id: '6',
        name: 'Google Play Books',
        rating: 4.6,
        imageUrl: 'assets/images/home/v6.png'),
    Vendor(
        id: '7',
        name: 'Apple Books',
        rating: 4.5,
        imageUrl: 'assets/images/home/v7.png'),
    Vendor(
        id: '8',
        name: 'Scribd',
        rating: 4.4,
        imageUrl: 'assets/images/home/v8.png'),
    Vendor(
        id: '9',
        name: 'Project Gutenberg',
        rating: 4.2,
        imageUrl: 'assets/images/home/v9.png'),
  ];

  static List<Author> authors = [
    Author(
      id: '1',
      name: 'Khaled Hosseini',
      role: 'Novelist',
      bio:
          'Afghan-American novelist and UNHCR goodwill envoy known for empathetic stories that bridge cultures.',
      rating: 4.7,
      imageUrl: resolveAuthorImage('Khaled Hosseini'),
      books: books.where((b) => b.author == 'Khaled Hosseini').toList(),
    ),
    Author(
      id: '2',
      name: 'Mark Manson',
      role: 'Author & Blogger',
      bio:
          'Best-selling self-help writer who blends psychology, philosophy, and humor to challenge modern anxieties.',
      rating: 4.5,
      imageUrl: resolveAuthorImage('Mark Manson'),
      books: books.where((b) => b.author == 'Mark Manson').toList(),
    ),
    Author(
      id: '3',
      name: 'Dan Brown',
      role: 'Thriller Writer',
      bio:
          'American author famous for fast-paced mysteries that weave art history, symbols, and conspiracies.',
      rating: 4.4,
      imageUrl: resolveAuthorImage('Dan Brown'),
      books: books.where((b) => b.author == 'Dan Brown').toList(),
    ),
    Author(
      id: '4',
      name: 'James Clear',
      role: 'Productivity Expert',
      bio:
          'Writer and speaker focused on evidence-backed strategies for building better habits and systems.',
      rating: 4.8,
      imageUrl: resolveAuthorImage('James Clear'),
      books: books.where((b) => b.author == 'James Clear').toList(),
    ),
    Author(
      id: '5',
      name: 'Tara Westover',
      role: 'Memoirist',
      bio:
          'Historian and author whose memoir chronicles a journey from rural isolation to academic achievement.',
      rating: 4.7,
      imageUrl: resolveAuthorImage('Tara Westover'),
      books: books.where((b) => b.author == 'Tara Westover').toList(),
    ),
    Author(
      id: '6',
      name: 'Delia Owens',
      role: 'Writer & Zoologist',
      bio:
          'Wildlife scientist turned novelist whose debut blended ecological detail with a compelling mystery.',
      rating: 4.6,
      imageUrl: resolveAuthorImage('Delia Owens'),
      books: books.where((b) => b.author == 'Delia Owens').toList(),
    ),
  ];
}
