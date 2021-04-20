import 'package:favorite/screen/sended_mail/sended_mail_screnn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordModel extends ChangeNotifier {
  String mail = '';
  String errorCode = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // パスワードリセットメール送信
  Future sendPasswordResetEmail(context) async {
    _auth.setLanguageCode('ja');
    try {
      await _auth.sendPasswordResetEmail(email: mail);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SendedMailScreen()),
      );
    } catch (e) {
      e as FirebaseAuthException;
      errorCode = e.code;
      print(e.code);
      notifyListeners();
    }
  }
}
