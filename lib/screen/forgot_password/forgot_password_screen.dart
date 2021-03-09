import 'package:favorite/model/forgot_password/forgot_password_model.dart';
import 'package:favorite/screen/forgot_password/components/body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = "/forgot_password";
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotPasswordModel>(
      create: (_) => ForgotPasswordModel(),
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("パスワードを設定"),
          ),
          body: Consumer<ForgotPasswordModel>(builder: (context, model, child) {
            return Body();
          }),
        ),
      ),
    );
  }
}
