import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite/entity/album.dart';
import 'package:flutter/material.dart';

class AlbumListModel extends ChangeNotifier {
  List<Album> books = [];
  bool isLoading = false;

  startLoading() {
    isLoading = true;
    notifyListeners();
  }

  endLoading() {
    isLoading = false;
    notifyListeners();
  }

  // 本一覧取得
  Future fetchBooks() async {
    final docs = await Firestore.instance.collection('books').getDocuments();
    final books = docs.documents.map((doc) => Album(doc)).toList();
    this.books = books;
    notifyListeners();
  }

  // 本の削除
  Future deleteBook(Album book) async {
    await Firestore.instance
        .collection('books')
        .document(book.documentId)
        .delete();
  }

  // カテゴリーカラーをセット
  Color setCategoryColor(int categoryId) {
    switch (categoryId) {
      case 0:
        return Colors.pink[600];
      case 1:
        return Colors.red[700];
      case 2:
        return Colors.blue;
      case 3:
        return Colors.green;
      case 4:
        return Colors.purple[500];
    }
  }
}
