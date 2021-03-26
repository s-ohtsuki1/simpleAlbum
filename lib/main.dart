import 'package:favorite/screen/album_list/album_list_screen.dart';
import 'package:favorite/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'theme.dart';
import 'viewmodel/user_state_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserStateModel user = UserStateModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserStateModel>.value(
      value: user,
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'),
          const Locale('ja'),
        ],
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme(),
        home: LoginCheck(),
      ),
    );
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
    final userState = Provider.of<UserStateModel>(context, listen: false);
    if (currentUser == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen()),
      );
    } else {
      userState.setUser(currentUser);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AlbumListScreen()),
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
