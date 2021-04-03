import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordModel extends ChangeNotifier {
  final mailEditController = TextEditingController();
  String email = '';

  // 再設定メール送信　エラーコード
  final String invalidEmail = 'invalid-email';
  final String userNotFound = 'user-not-found';
  final String success = 'success';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // パスワードリセットメール送信
  Future sendPasswordResetEmail() async {
    _auth.setLanguageCode('ja');
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return success;
    } catch (e) {
      e as FirebaseAuthException;
      return e.code;
    }
  }
}
