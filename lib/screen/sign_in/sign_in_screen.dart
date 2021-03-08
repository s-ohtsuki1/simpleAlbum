import 'package:favorite/constants.dart';
import 'package:favorite/model/sign_in/sign_in_model.dart';
import 'package:favorite/screen/sign_in/components/body.dart';
import 'package:favorite/size_config.dart';
import 'package:favorite/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = '/sign_in';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ChangeNotifierProvider<SignInModel>(
      create: (_) => SignInModel(),
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Icon(Icons.sensor_door_outlined, size: 36),
            shape: appBarShape(),
          ),
          resizeToAvoidBottomInset: false,
          body: Consumer<SignInModel>(builder: (context, model, child) {
            return Body();
          }),
        ),
      ),
    );
  }
}
