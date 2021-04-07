import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'dart:convert' show json;
import "package:http/http.dart" as http;

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

  changeIsRemember() {
    isRemember = isRemember ? false : true;
    notifyListeners();
  }

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
    GoogleSignInAccount? signinAccount = await googleSignin.signIn();
    if (signinAccount == null) return;

    GoogleSignInAccount? _currentUser;
    googleSignin.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      _currentUser = account;
      if (_currentUser != null) {
        _handleGetContact(_currentUser!);
      }
    });
    GoogleSignInAuthentication auth = await signinAccount.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: auth.idToken,
      accessToken: auth.accessToken,
    );
    FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    final String? namedContact = _pickFirstNamedContact(data);
    print(namedContact);
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'];
    final Map<String, dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );
    if (contact != null) {
      final Map<String, dynamic>? name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }

  // ログアウト
  void logOut() async {
    await _auth.signOut();
  }
}
