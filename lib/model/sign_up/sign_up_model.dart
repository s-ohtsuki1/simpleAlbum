import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpModel extends ChangeNotifier {
  final mailEditController = TextEditingController();
  final passwordEditController = TextEditingController();

  String mail = '';
  String password = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // バリデーション
  // void checkVal() {
  //   if (mail.isEmpty) {
  //     throw ('メールアドレスを入力してください。');
  //   }
  //   if (password.isEmpty) {
  //     throw ('パスワードを入力してください。');
  //   }
  // }

  // サインアップ
  Future signUp() async {
    // checkVal();

    // ユーザー登録
    final user = (await _auth.createUserWithEmailAndPassword(
      email: mail,
      password: password,
    ))
        .user;

    final email = user.email;
    Firestore.instance.collection('users').add(
      {
        'email': email,
        'created_at': Timestamp.now(),
      },
    );
  }
}
