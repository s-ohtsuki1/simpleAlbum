import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class SignUpModel extends ChangeNotifier {
  String mail = '';
  String password = '';
  String confirmPassword = '';
  bool isConfirm = false;

  String errorCode = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  validEmailForm(String? value) {
    if (value!.isEmpty) {
      // メールアドレスは必須
      return kEmailNullError;
    } else if (value.isNotEmpty && !emailValidatorRegExp.hasMatch(value)) {
      // メールアドレスの形式が違う
      return kInvalidEmailError;
    }
  }

  validPasswordForm(String? value) {
    if (value!.isEmpty) {
      // パスワードは必須
      return kPassNullError;
    } else if (value.isNotEmpty && value.length < 8) {
      // パスワードは8文字以上
      // return kShortPassError;
    } else if (password != confirmPassword) {
      return kMatchPassError;
    }
    notifyListeners();
  }

  // 確認画面へ
  changeConfirmScreen() {
    isConfirm = isConfirm ? false : true;
    notifyListeners();
  }

  // サインアップ
  Future signUp() async {
    // ユーザー登録
    final user = (await _auth.createUserWithEmailAndPassword(
      email: mail,
      password: password,
    ))
        .user;

    final email = user!.email;
    FirebaseFirestore.instance.collection('users').add(
      {
        'email': email,
        'created_at': Timestamp.now(),
      },
    );
  }

  // サインアップエラー
  signUpErrorMessage(Object e) {
    e as FirebaseAuthException;
    errorCode = e.code;
    print(e.code);
    notifyListeners();
  }
}
