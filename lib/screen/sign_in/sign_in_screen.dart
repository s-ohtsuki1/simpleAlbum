import 'package:favorite/constants.dart';
import 'package:favorite/screen/sign_in/components/body.dart';
import 'package:favorite/size_config.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = '/sign_in';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome Back!",
          style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Body(),
    );
  }
}
