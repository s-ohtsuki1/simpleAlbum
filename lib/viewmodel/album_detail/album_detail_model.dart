import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite/model/favorite.dart';
import 'package:favorite/viewmodel/user_state_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AlbumDetailModel extends ChangeNotifier {
  List<Favorite> favorit = [];
  String favoriteId = '';
  bool isFavorite = false;

  changeFavorite() {
    if (isFavorite)
      isFavorite = false;
    else
      isFavorite = true;

    notifyListeners();
  }

  // お気に入り情報取得
  Future fetchFavorite(String picDocumentId) async {
    this.favorit = [];

    User currentUser = UserState.user;
    final docs = await FirebaseFirestore.instance
        .collection('albums/' + currentUser.uid + '/favorite')
        .where("picDocumentId", isEqualTo: picDocumentId)
        .limit(1)
        .get();
    this.favorit = docs.docs.map((doc) => Favorite(doc)).toList();
    if (favorit.length == 1) {
      isFavorite = true;
      favoriteId = this.favorit.first.documentId;
    } else {
      isFavorite = false;
    }
    notifyListeners();
  }

  // お気に入り追加/解除（削除）
  Future saveFavorite(String picDocumentId, bool preIsFavorite) async {
    User currentUser = UserState.user;
    if (!preIsFavorite && isFavorite) {
      await FirebaseFirestore.instance
          .collection('albums/' + currentUser.uid + '/favorite')
          .add(
        {
          'picDocumentId': picDocumentId,
          'createdAt': Timestamp.now(),
        },
      );
    }
    if (preIsFavorite && !isFavorite) {
      await FirebaseFirestore.instance
          .collection('albums/' + currentUser.uid + '/favorite')
          .doc(favoriteId)
          .delete();
    }
    notifyListeners();
  }
}
