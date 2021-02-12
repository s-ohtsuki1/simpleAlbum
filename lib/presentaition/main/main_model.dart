import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  String frontText = "Whats's favorite?";
  bool isLogin = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void changeFrontText() {
    frontText = 'nothing';
    notifyListeners();
  }

  // ログインチェック
  Future isLoginCheck() async {
    await _auth.currentUser().then(
          (user) => {user != null ? isLogin = true : isLogin = false},
        );
    notifyListeners();
  }
}
