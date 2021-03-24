import 'package:favorite/screen/sign_up/components/body.dart';
import 'package:favorite/size_config.dart';
import 'package:favorite/theme.dart';
import 'package:favorite/viewmodel/sign_up/sign_up_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = '/sign_up';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ChangeNotifierProvider<SignUpModel>(
      create: (_) => SignUpModel(),
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: appBarTextStyle("新規登録"),
            shape: appBarShape(),
          ),
          resizeToAvoidBottomInset: false,
          body: Consumer<SignUpModel>(builder: (context, model, child) {
            return Body();
          }),
        ),
      ),
    );
  }
}
