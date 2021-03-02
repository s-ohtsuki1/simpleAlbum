import 'package:favorite/components/default_button.dart';
import 'package:favorite/components/form_error.dart';
import 'package:favorite/constants.dart';
import 'package:favorite/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      reverse: true,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomSpace),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
              ),
              child: Column(
                children: [
                  Center(
                    // ここを追加
                    child: Image.asset(
                      'assets/images/hiyoko_login.png',
                      height: getProportionateScreenHeight(120),
                      width: getProportionateScreenWidth(120),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  Text(
                    "メールアドレスとパスワードを入力してください。",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  SignForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildEmailFormField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildPasswordFormField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            FormError(errors: errors),
            DefaultButton(
              text: "ログイン",
              press: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value.isEmpty) {
          setState(() {
            if (errors.isNotEmpty) {
              errors.removeLast();
            }
            errors.add("メールアドレスを入力してください。");
          });
        }
        return null;
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
            size: 32,
          ),
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
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
            size: 32,
          ),
        ),
      ),
    );
  }
}
