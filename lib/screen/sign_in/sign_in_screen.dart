import 'package:favorite/model/sign_in/sign_in_model.dart';
import 'package:favorite/screen/sign_in/components/body.dart';
import 'package:favorite/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = '/sign_in';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInModel>(
      create: (_) => SignInModel(),
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              title: appBarTextStyle("ログイン"),
              shape: appBarShape(),
            ),
            resizeToAvoidBottomInset: false,
            body: Consumer<SignInModel>(builder: (context, model, child) {
              return Body();
            }),
          ),
        ),
      ),
    );
  }
}
