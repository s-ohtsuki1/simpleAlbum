import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite/constants.dart';
import 'package:favorite/model/picture.dart';
import 'package:favorite/util/date_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddOrEditModel extends ChangeNotifier {
  String bookTitle = '';
  int albumNo = 0;
  String shotDate = '';
  String comment = '';
  String imageUrl = '';
  File imageFile;
  bool isUploading = false;

  startLoading() {
    isUploading = true;
    notifyListeners();
  }

  endLoading() {
    isUploading = false;
    notifyListeners();
  }

  selectShotDate(context, String preSelectDt) async {
    var date = await showDatePicker(
      context: context,
      initialDate: preSelectDt.isNotEmpty
          ? DateFormat("yyyy/MM/dd").parseStrict(preSelectDt)
          : DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
      locale: const Locale('ja'),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(
            // ヘッダーの色
            primaryColor: kPrimaryColor,
            // 日付選択部の色
            dialogBackgroundColor: Colors.yellow[100],
            // 選択されたときのテキストの色
            accentTextTheme: TextTheme(
              headline6: TextStyle(
                color: kSecondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            // 選択されたときの円の色
            accentColor: Colors.brown,
            primarySwatch: Colors.orange,
            // OK/CANCELボタンのテキストの色
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.normal,
            ),
          ),
          child: child,
        );
      },
    );

    if (date != null) {
      shotDate = dateFormat(date);
      return shotDate;
    } else if (preSelectDt.isNotEmpty) {
      return preSelectDt;
    } else {
      return '';
    }
  }

  // カメラロールを開く
  Future showImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    notifyListeners();
  }

  // 写真を追加
  Future addBook() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    imageUrl = await _uploadBookImage();

    await Firestore.instance.collection('albums/' + user.uid + '/album').add(
      {
        'title': bookTitle,
        'categoryId': albumNo,
        'shotDate': shotDate,
        'coment': comment,
        'imageUrl': imageUrl,
        'createdAt': Timestamp.now(),
      },
    );
  }

  // 本を編集
  Future updateBook(Picture book) async {
    final document =
        Firestore.instance.collection('books').document(book.documentId);

    imageUrl = await _uploadBookImage();

    await document.updateData(
      {
        'title': bookTitle,
        'imageUrl': imageUrl,
        'updatedAt': Timestamp.now(),
      },
    );
  }

  // 本の画像をアップロード
  Future<String> _uploadBookImage() async {
    // 画像の変更があった場合
    if (imageFile != null) {
      final storage = FirebaseStorage.instance;

      StorageTaskSnapshot snapshot = await storage
          .ref()
          .child('books/' + bookTitle)
          .putFile(imageFile)
          .onComplete;

      imageUrl = await snapshot.ref.getDownloadURL();
    }

    return imageUrl;
  }
}
