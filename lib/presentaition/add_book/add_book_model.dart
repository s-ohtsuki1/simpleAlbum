import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite/domain/book.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBookModel extends ChangeNotifier {
  String bookTitle = '';
  File imageFile;
  bool isUploading = false;

  startLoading() {
    isUploading = true;
  }

  endLoading() {
    isUploading = false;
  }

  // カメラロールを開く
  Future showImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    imageFile = File(pickedFile.path);
    notifyListeners();
  }

  // 本を追加
  Future addBook() async {
    final imageUrl = await _uploadBookImage();

    await Firestore.instance.collection('books').add(
      {
        'title': bookTitle,
        'imageUrl': imageUrl,
        'createdAt': Timestamp.now(),
      },
    );
  }

  // 本を編集
  Future updateBook(Book book) async {
    final document =
        Firestore.instance.collection('books').document(book.documentId);

    final imageUrl = await _uploadBookImage();

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
    final storage = FirebaseStorage.instance;

    StorageTaskSnapshot snapshot = await storage
        .ref()
        .child('books/' + bookTitle)
        .putFile(imageFile)
        .onComplete;

    final String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}
