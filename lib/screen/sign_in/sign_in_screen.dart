import 'package:favorite/screen/sign_in/components/body.dart';
import 'package:favorite/theme.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = '/sign_in';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: appBarTextStyle("ログイン"),
              shape: appBarShape(),
              automaticallyImplyLeading: false,
            ),
            resizeToAvoidBottomInset: false,
            body: Body()),
      ),
    );
  }
}
