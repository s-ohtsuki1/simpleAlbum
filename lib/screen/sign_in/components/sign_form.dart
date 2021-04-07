import 'package:favorite/components/default_button.dart';
import 'package:favorite/constants.dart';
import 'package:favorite/screen/forgot_password/forgot_password_screen.dart';
import 'package:favorite/screen/login_success/login_success_screen.dart';
import 'package:favorite/size_config.dart';
import 'package:favorite/viewmodel/sign_in/sign_in_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SignInModel>(context, listen: true);
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildEmailFormField(model),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildPasswordFormField(model),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => (ForgotPasswordScreen()),
                ),
              ),
              child: Text(
                "パスワードをお忘れですか?",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            // FormError(errors: model.errors),
            SizedBox(height: getProportionateScreenHeight(5)),
            DefaultButton(
              text: "ログイン",
              press: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  try {
                    await model.login();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginSuccessScreen()),
                    );
                  } catch (e) {
                    // TODO err
                    // _showDialog(context, e.toString());
                  }
                } else {}
              },
            ),
            InkWell(
              onTap: () {
                model.changeIsRemember();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: model.isRemember,
                    activeColor: kPrimaryColor,
                    onChanged: (isCheck) {
                      model.changeIsRemember();
                    },
                  ),
                  Text("次回から自動でログインします"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildEmailFormField(SignInModel model) {
    final mailContlloer = model.mailEditController;
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: mailContlloer,
      onChanged: (value) {
        model.mail = value;
      },
      validator: (mail) {
        if (mail!.isEmpty) {
          // メールアドレスは必須
          return kEmailNullError;
        } else if (mail.isNotEmpty && !emailValidatorRegExp.hasMatch(mail)) {
          // メールアドレスの形式が違う
          return kInvalidEmailError;
        }
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: "email",
        labelStyle: TextStyle(color: kSecondaryColor),
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

  TextFormField buildPasswordFormField(SignInModel model) {
    final passwordContlloer = model.passwordEditController;

    return TextFormField(
      obscureText: true,
      controller: passwordContlloer,
      onChanged: (password) {
        model.password = password;
      },
      validator: (value) {
        if (value!.isEmpty) {
          // パスワードは必須
          return kPassNullError;
        } else if (value.isNotEmpty && value.length < 8) {
          // パスワードは8文字以上 TODO:外す
          // return kShortPassError;
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: "password",
        labelStyle: TextStyle(color: kSecondaryColor),
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
}
