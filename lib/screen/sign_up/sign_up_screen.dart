import 'package:favorite/screen/sign_up/components/body.dart';
import 'package:favorite/theme.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
          FocusScope.of(context).requestFocus(FocusNode());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: appBarTextStyle("新規会員登録"),
        ),
        // resizeToAvoidBottomInset: false,
        body: Body(),
      ),
    );
  }
}
