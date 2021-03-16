import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AlbumDetailModel extends ChangeNotifier {
  int userId = 0;
  String picDocumentId = '';
  bool isFavorite = false;

  changeFavorite() {
    if (isFavorite)
      isFavorite = false;
    else
      isFavorite = true;

    notifyListeners();
  }

  // お気に入り追加
  Future addBook() async {
    await Firestore.instance.collection('favorite').add(
      {
        'userId': userId,
        'picDocumentId': picDocumentId,
        'isFavorite': isFavorite,
        'createdAt': Timestamp.now(),
      },
    );
  }

  // お気に入り解除
}
