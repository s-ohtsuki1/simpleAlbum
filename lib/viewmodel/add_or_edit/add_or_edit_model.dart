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

import '../user_state_model.dart';

class AddOrEditModel extends ChangeNotifier {
  String title = '';
  int albumNo = 2;
  String shotDate = '';
  String comment = '';
  String imageUrl = '';
  File imageFile = File('');
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
      builder: (BuildContext context, Widget? child) {
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
          child: child!,
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
  Future addPicture() async {
    User currentUser = UserState.user;

    imageUrl = await _uploadPictureImage();

    await FirebaseFirestore.instance
        .collection('albums/' + currentUser.uid + '/album')
        .add(
      {
        'title': title,
        'albumNo': albumNo,
        'shotDate': DateFormat("yyyy/MM/dd").parseStrict(shotDate),
        'comment': comment,
        'imageUrl': imageUrl,
        'createdAt': Timestamp.now(),
      },
    );
  }

  // 写真を編集
  Future updatePicture(Picture picture) async {
    User currentUser = UserState.user;

    final document = FirebaseFirestore.instance
        .collection('albums/' + currentUser.uid + '/album')
        .doc(picture.documentId);

    imageUrl = await _uploadPictureImage();

    await document.update(
      {
        'title': title,
        'albumNo': albumNo,
        'shotDate': DateFormat("yyyy/MM/dd").parseStrict(shotDate),
        'comment': comment,
        'imageUrl': imageUrl,
        'updatedAt': Timestamp.now(),
      },
    );
  }

  // 写真をアップロード
  Future<String> _uploadPictureImage() async {
    // 写真の変更があった場合
    if (imageFile.path.isNotEmpty) {
      final storage = FirebaseStorage.instance;

      TaskSnapshot snapshot = await storage
          .ref()
          .child('picture/' + title)
          .putFile(imageFile)
          .whenComplete(() => null);

      imageUrl = await snapshot.ref.getDownloadURL();
    }

    return imageUrl;
  }

  void initField() {
    title = '';
    albumNo = 2;
    shotDate = '';
    comment = '';
    imageUrl = '';
    imageFile = File('');
  }
}
