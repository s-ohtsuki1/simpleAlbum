import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite/screen/login_success/login_success_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpModel extends ChangeNotifier {
  String mail = '';
  String password = '';
  String confirmPassword = '';
  bool isConfirm = false;

  String errorCode = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 確認画面へ
  changeConfirmScreen() {
    isConfirm = isConfirm ? false : true;
    notifyListeners();
  }

  // サインアップ
  Future signUp(context) async {
    try {
      // ユーザー登録
      final user = (await _auth.createUserWithEmailAndPassword(
        email: mail,
        password: password,
      ))
          .user;

      final email = user!.email;
      await FirebaseFirestore.instance.collection('users').add(
        {
          'email': email,
          'created_at': Timestamp.now(),
        },
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginSuccessScreen()),
      );
    } catch (e) {
      e as FirebaseAuthException;
      errorCode = e.code;
      isConfirm = false;
      print(e.code);
      notifyListeners();
    }
  }
}
