import 'package:books/core/utils/responsive.dart';
import 'package:books/features/home_feature/data/book_inventory.dart';
import 'package:books/features/home_feature/data/home_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _priceController.dispose();
    _ratingController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _openBookEditor({Book? book}) {
    if (book != null) {
      _titleController.text = book.title;
      _authorController.text = book.author;
      _priceController.text = book.price.toStringAsFixed(2);
      _ratingController.text = book.rating.toStringAsFixed(1);
      _descriptionController.text = book.description;
      _imageController.text = book.imageUrl;
      _categoryController.text = book.category;
    } else {
      _titleController.clear();
      _authorController.clear();
      _priceController.clear();
      _ratingController.clear();
      _descriptionController.clear();
      _imageController.clear();
      _categoryController.text = 'General';
    }

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            padding: Responsive.responsivePadding(ctx).copyWith(
              top: Responsive.responsiveSpacing(ctx, 16),
              bottom: Responsive.responsiveSpacing(ctx, 24),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book == null ? 'Add Book' : 'Edit Book',
                    style: TextStyle(
                      fontSize: Responsive.responsiveFontSize(ctx, 20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Responsive.responsiveSpacing(ctx, 16)),
                  _buildTextField(
                    controller: _titleController,
                    label: 'Title',
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Enter a title' : null,
                  ),
                  SizedBox(height: Responsive.responsiveSpacing(ctx, 12)),
                  _buildTextField(
                    controller: _authorController,
                    label: 'Author',
                    validator: (value) => value == null || value.isEmpty
                        ? 'Enter an author'
                        : null,
                  ),
                  SizedBox(height: Responsive.responsiveSpacing(ctx, 12)),
                  _buildTextField(
                    controller: _priceController,
                    label: 'Price',
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      final parsed = double.tryParse(value ?? '');
                      if (parsed == null || parsed < 0) {
                        return 'Enter a valid price';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: Responsive.responsiveSpacing(ctx, 12)),
                  _buildTextField(
                    controller: _ratingController,
                    label: 'Rating (0-5)',
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      final parsed = double.tryParse(value ?? '');
                      if (parsed == null || parsed < 0 || parsed > 5) {
                        return 'Enter a rating between 0 and 5';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: Responsive.responsiveSpacing(ctx, 12)),
                  _buildTextField(
                    controller: _descriptionController,
                    label: 'Description',
                    maxLines: 3,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Enter a short description'
                        : null,
                  ),
                  SizedBox(height: Responsive.responsiveSpacing(ctx, 12)),
                  _buildTextField(
                    controller: _categoryController,
                    label: 'Category',
                    validator: (value) => value == null || value.isEmpty
                        ? 'Enter a category'
                        : null,
                  ),
                  SizedBox(height: Responsive.responsiveSpacing(ctx, 12)),
                  _buildTextField(
                    controller: _imageController,
                    label: 'Image URL or asset path (optional)',
                  ),
                  SizedBox(height: Responsive.responsiveSpacing(ctx, 20)),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _saveBook(book);
                      },
                      child: Text(book == null ? 'Add Book' : 'Save Changes'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _saveBook(Book? book) async {
    if (!_formKey.currentState!.validate()) return;

    final parsedRating = double.tryParse(_ratingController.text.trim()) ?? 0;
    final ratingValue = parsedRating.clamp(0, 5).toDouble();
    final priceValue = double.tryParse(_priceController.text.trim()) ?? 0;
    final categoryValue = _categoryController.text.trim().isEmpty
        ? 'General'
        : _categoryController.text.trim();

    final newBook = Book(
      id: book?.id ?? BookInventory.nextBookId(),
      title: _titleController.text.trim(),
      author: _authorController.text.trim(),
      price: priceValue,
      rating: ratingValue,
      description: _descriptionController.text.trim(),
      imageUrl: _imageController.text.trim(),
      category: categoryValue,
    );

    if (book == null) {
      await BookInventory.addBook(newBook);
    } else {
      await BookInventory.updateBook(book.id, newBook);
    }

    Get.back<void>();
  }

  void _confirmDelete(Book book) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete book'),
        content: Text('Are you sure you want to delete "${book.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              await BookInventory.deleteBook(book.id);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Widget _buildBookTile(BuildContext context, Book book) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.symmetric(
        vertical: Responsive.responsiveSpacing(context, 6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 72,
              height: 96,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: _BookThumbnail(imageUrl: book.imageUrl),
            ),
            SizedBox(width: Responsive.responsiveSpacing(context, 12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book.author,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        '\$${book.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6C47FF),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      Text(
                        book.rating.toStringAsFixed(1),
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    book.description,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 13,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  tooltip: 'Edit',
                  onPressed: () => _openBookEditor(book: book),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Delete',
                  color: Colors.red,
                  onPressed: () => _confirmDelete(book),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          TextButton(
            onPressed: () => Get.offAllNamed('/LogInScreen'),
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openBookEditor(),
        icon: const Icon(Icons.add),
        label: const Text('Add book'),
      ),
      body: Padding(
        padding: Responsive.responsivePadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manage books',
              style: TextStyle(
                fontSize: Responsive.responsiveFontSize(context, 22),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Responsive.responsiveSpacing(context, 8)),
            Text(
              'Add, edit, or delete titles for your catalog.',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: Responsive.responsiveFontSize(context, 14),
              ),
            ),
            SizedBox(height: Responsive.responsiveSpacing(context, 12)),
            Expanded(
              child: ValueListenableBuilder<List<Book>>(
                valueListenable: BookInventory.booksNotifier,
                builder: (context, books, _) {
                  if (books.isEmpty) {
                    return Center(
                      child: Text(
                        'No books yet. Tap "Add book" to create one.',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      return _buildBookTile(context, books[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(labelText: label),
      validator: validator,
    );
  }
}

class _BookThumbnail extends StatelessWidget {
  const _BookThumbnail({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return Icon(
        Icons.menu_book,
        color: Colors.grey[400],
      );
    }

    if (imageUrl.startsWith('http')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              Icon(Icons.menu_book, color: Colors.grey[400]),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) =>
            Icon(Icons.menu_book, color: Colors.grey[400]),
      ),
    );
  }
}
