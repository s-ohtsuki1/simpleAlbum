import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInModel extends ChangeNotifier {
  final mailEditController = TextEditingController();
  final passwordEditController = TextEditingController();

  String mail = '';
  String password = '';
  bool isRemember = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  static final googleSignin = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/indexing',
      // 'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  // バリデーション
  // void checkVal() {
  //   if (mail.isEmpty) {
  //     throw ('メールアドレスを入力してください。');
  //   }
  //   if (password.isEmpty) {
  //     throw ('パスワードを入力してください。');
  //   }
  // }

  // ログイン
  Future login() async {
    // ログイン
    await _auth.signInWithEmailAndPassword(
      email: mail,
      password: password,
    );
  }

  // Google login
  void googleLogin() async {
    GoogleSignInAccount signinAccount = await googleSignin.signIn();
    if (signinAccount == null) return;

    GoogleSignInAuthentication auth = await signinAccount.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: auth.idToken,
      accessToken: auth.accessToken,
    );
    FirebaseAuth.instance.signInWithCredential(credential);
  }

  // ログアウト
  void logOut() async {
    await _auth.signOut();
  }
}
