import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite/domain/book.dart';
import 'package:flutter/material.dart';

class AddBookModel extends ChangeNotifier {
  String bookTitle = '';

  // バリデーション
  void isRequired() {
    if (bookTitle.isEmpty) {
      throw ('タイトルを入力してください。');
    }
  }

  // 本を追加
  Future addBook() async {
    isRequired();
    await Firestore.instance.collection('books').add(
      {
        'title': bookTitle,
        'created_at': Timestamp.now(),
      },
    );
  }

  // 本を編集
  Future updateBook(Book book) async {
    isRequired();
    final document =
        Firestore.instance.collection('books').document(book.documentId);
    await document.updateData(
      {
        'title': bookTitle,
        'updated_at': Timestamp.now(),
      },
    );
  }
}
