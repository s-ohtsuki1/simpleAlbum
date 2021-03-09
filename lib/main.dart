import 'package:favorite/presentaition/book_list/book_list_page.dart';
import 'package:favorite/routs.dart';
import 'package:favorite/screen/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'theme.dart';

void main() {
  runApp(MyApp());
}

class UserState extends ChangeNotifier {
  FirebaseUser user;
  void setUser(FirebaseUser currentUser) {
    user = currentUser;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  final UserState user = UserState();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserState>.value(
        value: user,
        child: MaterialApp(
          //デバックラベル非表示
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: theme(),
          initialRoute: SignInScreen.routeName,
          routes: routes,
        ));
  }
}

class LoginCheck extends StatefulWidget {
  LoginCheck({Key key}) : super(key: key);

  @override
  _LoginCheckState createState() => _LoginCheckState();
}

class _LoginCheckState extends State<LoginCheck> {
  //ログイン状態のチェック(非同期で行う)
  void checkUser() async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    final userState = Provider.of<UserState>(context, listen: false);
    if (currentUser == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    } else {
      userState.setUser(currentUser);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BookListPage()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Loading..."),
        ),
      ),
    );
  }
}
