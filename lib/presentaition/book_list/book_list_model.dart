import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite/domain/book.dart';
import 'package:flutter/material.dart';

class BookListModel extends ChangeNotifier {
  List<Book> books = [];

  // 本一覧取得
  Future fetchBooks() async {
    final docs = await Firestore.instance.collection('books').getDocuments();
    final books = docs.documents.map((doc) => Book(doc)).toList();
    this.books = books;
    notifyListeners();
  }

  // 本の削除
  Future deleteBook(Book book) async {
    await Firestore.instance
        .collection('books')
        .document(book.documentId)
        .delete();
  }
}
