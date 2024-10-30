import 'package:flutter/material.dart';

void main() {
  runApp(Perpus());
}

class Perpus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perpustakaan Online',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookListScreen(),
    );
  }
}

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final List<Book> books = [
    Book(
      title: 'Senja Bersama Ayah',
      author: 'Aldeco Ghanindra',
      publisher: 'Perpus Books',
      stock: 10,
      imageAsset: 'assets/Senja Bersama Ayah.jpg',
      description: 'Senja Bersama Ayah adalah sebuah novel yang mengisahkan tentang hubungan seorang anak dengan ayahnya yang penuh kasih dan inspirasi...',
    ),
    Book(
      title: 'Hujan',
      author: 'Dapunk',
      publisher: 'Perpus Books',
      stock: 5,
      imageAsset: 'assets/hujan.jpg',
      description: 'Hujan adalah novel yang mengeksplorasi hubungan kompleks antara manusia dan alam...',
    ),
  ];

  void _editBook(Book book) async {
    final updatedBook = await showDialog<Book>(
      context: context,
      builder: (BuildContext context) {
        return EditBookDialog(book: book);
      },
    );

    if (updatedBook != null) {
      setState(() {
        int index = books.indexOf(book);
        books[index] = updatedBook;
      });
    }
  }

  void _checkoutBook(Book book) {
    if (book.stock > 0) {
      setState(() {
        book.stock -= 1;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Book out of stock!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perpustakaan Online'),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return BookCard(
            book: books[index],
            onEdit: () => _editBook(books[index]),
            onCheckout: () => _checkoutBook(books[index]),
          );
        },
      ),
    );
  }
}

class Book {
  String title;
  String author;
  String publisher;
  int stock;
  String imageAsset;
  String description;

  Book({
    required this.title,
    required this.author,
    required this.publisher,
    required this.stock,
    required this.imageAsset,
    required this.description,
  });

  Book copyWith({String? title, String? imageAsset, int? stock, String? description}) {
    return Book(
      title: title ?? this.title,
      author: this.author,
      publisher: this.publisher,
      stock: stock ?? this.stock,
      imageAsset: imageAsset ?? this.imageAsset,
      description: description ?? this.description,
    );
  }
}

class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback onEdit;
  final VoidCallback onCheckout;

  BookCard({required this.book, required this.onEdit, required this.onCheckout});

  void _showBookInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(book.title),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  book.imageAsset,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10),
                Text('Author: ${book.author}'),
                Text('Publisher: ${book.publisher}'),
                Text('Stock: ${book.stock}'),
                SizedBox(height: 10),
                Text(book.description),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  book.imageAsset,
                  height: 100,
                  width: 70,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text('Author: ${book.author}'),
                      Text('Publisher: ${book.publisher}'),
                      Text('Stock: ${book.stock}'),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: () => _showBookInfo(context),
                  tooltip: 'Show Book Info',
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'Edit') {
                      onEdit();
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      value: 'Edit',
                      child: Text('Edit'),
                    ),
                  ],
                  icon: Icon(Icons.more_vert),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onCheckout,
                child: Text('Checkout Book'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditBookDialog extends StatefulWidget {
  final Book book;

  EditBookDialog({required this.book});

  @override
  _EditBookDialogState createState() => _EditBookDialogState();
}

class _EditBookDialogState extends State<EditBookDialog> {
  late TextEditingController _titleController;
  late TextEditingController _imageAssetController;
  late TextEditingController _stockController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book.title);
    _imageAssetController = TextEditingController(text: widget.book.imageAsset);
    _stockController = TextEditingController(text: widget.book.stock.toString());
    _descriptionController = TextEditingController(text: widget.book.description);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Book'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _imageAssetController,
            decoration: InputDecoration(labelText: 'Image Asset Path'),
          ),
          TextField(
            controller: _stockController,
            decoration: InputDecoration(labelText: 'Stock'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            int? stock = int.tryParse(_stockController.text);
            if (stock == null || stock < 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please enter a valid stock number.')),
              );
              return;
            }
            Navigator.of(context).pop(widget.book.copyWith(
              title: _titleController.text,
              imageAsset: _imageAssetController.text,
              stock: stock,
              description: _descriptionController.text,
            ));
          },
          child: Text('Save'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _imageAssetController.dispose();
    _stockController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
