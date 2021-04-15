import 'package:favorite/components/default_button.dart';
import 'package:favorite/screen/login_success/login_success_screen.dart';
import 'package:favorite/viewmodel/sign_up/sign_up_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SignUpForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SignUpModel>(context, listen: true);
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildEmailFormField(model),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildPasswordFormField(model),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildConfirmPasswordFormField(model),
            SizedBox(height: getProportionateScreenHeight(40)),
            DefaultButton(
              text: "会員登録",
              press: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  try {
                    await model.signUp();
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
        return model.validEmailForm(value);
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
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
        return model.validPasswordForm(value);
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
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
        return model.validPasswordForm(value);
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
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
