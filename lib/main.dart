import 'package:favorite/screen/album_list/album_list_screen.dart';
import 'package:favorite/screen/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'providers.dart';
import 'theme.dart';
import 'viewmodel/album_list/album_list_model.dart';
import 'viewmodel/user_state_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers().useProviders,
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
  @override
  _LoginCheckState createState() => _LoginCheckState();
}

class _LoginCheckState extends State<LoginCheck> {
  void checkUser() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        UserState().setUser(user);
        Provider.of<AlbumListModel>(context, listen: false).getNewPicture();

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AlbumListScreen()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SplashScreen()),
        );
      }
    });
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
