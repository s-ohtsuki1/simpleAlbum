import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite/domain/book.dart';
import 'package:flutter/material.dart';

class AddBookModel extends ChangeNotifier {
  String bookTitle = '';

  Future addBook() async {
    if (bookTitle.isEmpty) {
      throw ('タイトルを入力してください。');
    }
    Firestore.instance.collection('books').add(
      {
        'title': bookTitle,
        'created_at': Timestamp.now(),
      },
    );
  }
}
