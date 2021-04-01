import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite/model/picture.dart';
import 'package:favorite/viewmodel/user_state_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AlbumListModel extends ChangeNotifier {
  List<Picture> pictures = [];
  int selectAlbumNo = 0;
  bool isLoading = false;
  bool isSideMenuOpen = false;

  init() {
    isSideMenuOpen = false;
  }

  startLoading() {
    isLoading = true;
    notifyListeners();
  }

  endLoading() {
    isLoading = false;
    notifyListeners();
  }

  changeAlbumNo(int albumNo) {
    selectAlbumNo = albumNo;
    notifyListeners();
  }

  sideMenuOpenClose() {
    isSideMenuOpen = isSideMenuOpen ? false : true;
    notifyListeners();
  }

  // 最新写真一覧取得
  void getNewPicture() async {
    User currentUser = UserState.user;

    // 最新10件分取得
    final snapshots = FirebaseFirestore.instance
        .collection('albums/' + currentUser.uid + '/album')
        .orderBy('shotDate', descending: true)
        .limit(10)
        .snapshots();
    snapshots.listen(
      (snapshot) {
        final pictures = snapshot.docs.map((doc) => Picture(doc)).toList();
        this.pictures = pictures;
        notifyListeners();
      },
    );
  }

  // アルバムNOで写真一覧取得
  void getAlbumNoPicture() async {
    User currentUser = UserState.user;

    final snapshots = FirebaseFirestore.instance
        .collection('albums/' + currentUser.uid + '/album')
        .where('albumNo', isEqualTo: selectAlbumNo)
        .orderBy('shotDate', descending: true)
        .snapshots();
    snapshots.listen(
      (snapshot) {
        final pictures = snapshot.docs.map((doc) => Picture(doc)).toList();
        this.pictures = pictures;
        notifyListeners();
      },
    );
  }

  // 写真の削除
  Future deleteBook(Picture picture) async {
    User currentUser = UserState.user;

    await FirebaseFirestore.instance
        .collection('albums/' + currentUser.uid + '/album')
        .doc(picture.documentId)
        .delete();
  }

  // カテゴリーカラーをセット
  Color? setCategoryColor(int categoryId) {
    switch (categoryId) {
      case 0:
        return Colors.red[600];
      case 1:
        return Colors.pink[600];
      case 2:
        return Colors.blue;
      case 3:
        return Colors.green;
      case 4:
        return Colors.purple[500];
      default:
        return Colors.red[700];
    }
  }
}
