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
  Future saveFavorite() async {
    if (isFavorite)
      await Firestore.instance.collection('favorites').add(
        {
          'userId': userId,
          'picDocumentId': picDocumentId,
          'createdAt': Timestamp.now(),
        },
      );
  }
}
