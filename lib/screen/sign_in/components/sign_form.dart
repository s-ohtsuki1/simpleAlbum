import 'package:favorite/components/default_button.dart';
import 'package:favorite/components/form_error.dart';
import 'package:favorite/constants.dart';
import 'package:favorite/screen/forgot_password/forgot_password_screen.dart';
import 'package:favorite/screen/login_success/login_success_screen.dart';
import 'package:favorite/size_config.dart';
import 'package:favorite/util/validator_util.dart';
import 'package:favorite/viewmodel/sign_in/sign_in_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignForm extends StatelessWidget {
  final validator = ValidatorUtil();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SignInModel>(context, listen: true);
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            FormError(errorCode: model.errorCode),
            buildEmailFormField(model),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildPasswordFormField(model),
            SizedBox(
              height: getProportionateScreenHeight(20),
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
            SizedBox(height: getProportionateScreenHeight(5)),
            DefaultButton(
              text: "ログイン",
              press: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  await model.login(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildEmailFormField(SignInModel model) {
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
    final passwordContlloer = TextEditingController(text: model.password);

    return TextFormField(
      obscureText: true,
      controller: passwordContlloer,
      onChanged: (password) {
        model.password = password;
      },
      validator: (value) {
        return validator.validPasswordForm(value, null);
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
