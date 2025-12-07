import 'package:books/features/home_feature/data/home_models.dart';

class AppData {
  static const List<Book> books = [
    Book(
      id: '1',
      title: 'The Kite Runner',
      author: 'Khaled Hosseini',
      price: 39.99,
      rating: 4.0,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque dignissim sit amet nisl vel eleifend.',
      imageUrl: 'assets/b1.png',
    ),
    Book(
      id: '2',
      title: 'The Subtle Art',
      author: 'Mark Manson',
      price: 19.99,
      rating: 4.5,
      description: 'A counterintuitive approach to living a good life.',
      imageUrl: 'assets/b2.png',
    ),
    Book(
      id: '3',
      title: 'The Da Vinci Code',
      author: 'Dan Brown',
      price: 14.95,
      rating: 4.2,
      description: 'A gripping mystery thriller novel.',
      imageUrl: 'assets/b3.png',
    ),
    Book(
      id: '4',
      title: 'Game Fisher',
      author: 'Tess Gunty',
      price: 27.12,
      rating: 4.3,
      description: 'An exciting adventure novel.',
      imageUrl: '',
    ),
    Book(
      id: '5',
      title: 'The Good Sister',
      author: 'Tess Gunty',
      price: 27.12,
      rating: 4.1,
      description: 'A compelling family drama.',
      imageUrl: '',
    ),
    Book(
      id: '6',
      title: 'The Waiting',
      author: 'Tess Gunty',
      price: 27.12,
      rating: 4.4,
      description: 'A suspenseful thriller.',
      imageUrl: '',
    ),
  ];

  static const List<Vendor> vendors = [
    Vendor(id: '1', name: 'Wattpad', rating: 4.0, imageUrl: 'assets/v1.png'),
    Vendor(id: '2', name: 'Kuronii', rating: 4.5, imageUrl: 'assets/v2.png'),
    Vendor(id: '3', name: 'Crane & Co', rating: 4.2, imageUrl: 'assets/v4.png'),
    Vendor(id: '4', name: 'GoodBuy', rating: 4.3, imageUrl: 'assets/v3.png'),
    Vendor(id: '5', name: 'Warehouse', rating: 4.1, imageUrl: 'assets/v5.png'),
    Vendor(id: '6', name: 'Peppa Pig', rating: 4.4, imageUrl: 'assets/v6.png'),
    Vendor(id: '7', name: 'Jstor', rating: 4.0, imageUrl: 'assets/v7.png'),
    Vendor(id: '8', name: 'Peloton', rating: 4.2, imageUrl: 'assets/v8.png'),
    Vendor(id: '9', name: 'Haymarket', rating: 4.3, imageUrl: 'assets/v9.png'),
  ];

  static List<Author> authors = [
    const Author(
      id: '1',
      name: 'John Freeman',
      role: 'Writer',
      bio:
          'American writer who was the editor of several prestigious publications.',
      rating: 4.2,
      imageUrl: 'assets/a1.png',
      books: [],
    ),
    const Author(
      id: '2',
      name: 'Adam Dalva',
      role: 'Writer',
      bio: 'He is a writer and the fiction editor of a renowned magazine.',
      rating: 4.0,
      imageUrl: 'assets/a2.png',
      books: [],
    ),
    const Author(
      id: '3',
      name: 'Abraham Verghese',
      role: 'Professor',
      bio:
          'He is the professor and Sofia Anesaki Chair at Stanford University.',
      rating: 4.5,
      imageUrl: 'assets/a3.png',
      books: [],
    ),
    Author(
      id: '4',
      name: 'Tess Gunty',
      role: 'Novelist',
      bio:
          'Gunty was born and raised in South Bend, Indiana. She graduated from Yale University and received an MFA in Fiction and English from New York University.',
      rating: 4.0,
      imageUrl: 'assets/a4.png',
      books: books.where((b) => b.author == 'Tess Gunty').toList(),
    ),
    const Author(
      id: '5',
      name: 'Ann Napolitano',
      role: 'Novelist',
      bio: 'She is the author of the novel A Good Hard Look.',
      rating: 4.3,
      imageUrl: 'assets/a5.png',
      books: [],
    ),
    const Author(
      id: '6',
      name: 'Hernan Diaz',
      role: 'Writer',
      bio: 'Award-winning novelist and essayist.',
      rating: 4.4,
      imageUrl: 'assets/a6.png',
      books: [],
    ),
  ];
}
