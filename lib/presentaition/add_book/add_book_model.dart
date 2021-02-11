import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite/domain/book.dart';
import 'package:flutter/material.dart';

class AddBookModel extends ChangeNotifier {
  String bookTitle = '';
  String imageUrl = '';

  // 本を追加
  Future addBook() async {
    await Firestore.instance.collection('books').add(
      {
        'title': bookTitle,
        'imageUrl': 'https://m.media-amazon.com/images/I/61SX2klNzXL.jpg',
        'createdAt': Timestamp.now(),
      },
    );
  }

  // 本を編集
  Future updateBook(Book book) async {
    final document =
        Firestore.instance.collection('books').document(book.documentId);
    await document.updateData(
      {
        'title': bookTitle,
        'updatedAt': Timestamp.now(),
      },
    );
  }
}
