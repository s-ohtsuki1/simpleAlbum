import 'package:favorite/screen/sign_up/components/body.dart';
import 'package:favorite/theme.dart';
import 'package:favorite/viewmodel/sign_up/sign_up_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SignUpModel>(context, listen: true);

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
          FocusScope.of(context).requestFocus(FocusNode());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: appBarTextStyle(model.isConfirm ? "確認画面" : "新規会員登録"),
        ),
        // resizeToAvoidBottomInset: false,
        body: Body(),
      ),
    );
  }
}
