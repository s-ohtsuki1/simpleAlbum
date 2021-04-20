import 'package:favorite/components/default_button.dart';
import 'package:favorite/components/form_error.dart';
import 'package:favorite/screen/login_success/login_success_screen.dart';
import 'package:favorite/util/validator_util.dart';
import 'package:favorite/viewmodel/sign_up/sign_up_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SignUpForm extends StatelessWidget {
  final validator = ValidatorUtil();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SignUpModel>(context, listen: true);
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            FormError(errorCode: model.errorCode),
            buildEmailFormField(model),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildPasswordFormField(model),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildConfirmPasswordFormField(model),
            SizedBox(height: getProportionateScreenHeight(50)),
            DefaultButton(
              text: model.isConfirm ? "登録する" : "確認画面へ",
              press: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  // 確認画面へ
                  if (!model.isConfirm) {
                    model.changeConfirmScreen();
                    return;
                  }

                  await model.signUp(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildEmailFormField(SignUpModel model) {
    final mailContlloer = TextEditingController(text: model.mail);
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: mailContlloer,
      onChanged: (value) {
        model.mail = value;
      },
      validator: (value) {
        return validator.validEmailForm(value);
      },
      readOnly: model.isConfirm ? true : false,
      decoration: InputDecoration(
        filled: true,
        fillColor: model.isConfirm ? Colors.lightBlue[100] : Colors.white,
        labelText: "email",
        labelStyle: TextStyle(color: kSecondaryColor, fontSize: 20),
        hintText: "メールアドレス",
        hintStyle: TextStyle(color: kSecondaryColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 30, 20),
          child: Icon(
            Icons.mail_outline,
            color: Colors.brown[800],
            size: 24,
          ),
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField(SignUpModel model) {
    final passwordContlloer = TextEditingController(text: model.password);

    return TextFormField(
      obscureText: true,
      controller: passwordContlloer,
      onChanged: (password) {
        model.password = password;
      },
      validator: (value) {
        return validator.validPasswordForm(value, model.confirmPassword);
      },
      readOnly: model.isConfirm ? true : false,
      decoration: InputDecoration(
        filled: true,
        fillColor: model.isConfirm ? Colors.lightBlue[100] : Colors.white,
        labelText: "password",
        labelStyle: TextStyle(color: kSecondaryColor, fontSize: 20),
        hintText: "パスワード",
        hintStyle: TextStyle(color: kSecondaryColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 30, 20),
          child: Icon(
            Icons.lock_open_outlined,
            color: Colors.brown[800],
            size: 24,
          ),
        ),
      ),
    );
  }

  TextFormField buildConfirmPasswordFormField(SignUpModel model) {
    final passwordConfirmContlloer =
        TextEditingController(text: model.confirmPassword);

    return TextFormField(
      obscureText: true,
      controller: passwordConfirmContlloer,
      onChanged: (password) {
        model.confirmPassword = password;
      },
      validator: (value) {
        return validator.validPasswordForm(value, model.password);
      },
      readOnly: model.isConfirm ? true : false,
      decoration: InputDecoration(
        filled: true,
        fillColor: model.isConfirm ? Colors.lightBlue[100] : Colors.white,
        labelText: "confirm password",
        labelStyle: TextStyle(color: kSecondaryColor, fontSize: 20),
        hintText: "パスワード(確認)",
        hintStyle: TextStyle(color: kSecondaryColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 30, 20),
          child: Icon(
            Icons.lock_open_outlined,
            color: Colors.brown[800],
            size: 24,
          ),
        ),
      ),
    );
  }
}
