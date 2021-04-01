import 'package:favorite/screen/forgot_password/components/body.dart';
import 'package:favorite/theme.dart';
import 'package:favorite/viewmodel/forgot_password/forgot_password_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = "/forgot_password";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("パスワードを再設定"),
            shape: appBarShape(),
          ),
          body: Body()),
    );
  }
}
