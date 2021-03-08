import 'package:favorite/components/default_button.dart';
import 'package:favorite/components/form_error.dart';
import 'package:favorite/constants.dart';
import 'package:favorite/model/sign_in/sign_in_model.dart';
import 'package:favorite/presentaition/book_list/book_list_page.dart';
import 'package:favorite/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SignInModel>(context, listen: false);
    bool isRmember = Provider.of<SignInModel>(context, listen: true).isRemember;
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildEmailFormField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildPasswordFormField(),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Text(
              "パスワードをお忘れですか?",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            FormError(errors: errors),
            SizedBox(height: getProportionateScreenHeight(5)),
            DefaultButton(
              text: "ログイン",
              press: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  if (errors.isEmpty) {
                    try {
                      await model.login();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BookListPage()),
                      );
                    } catch (e) {
                      // TODO err
                      // _showDialog(context, e.toString());
                    }
                  }
                } else {}
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: isRmember,
                  activeColor: kPrimaryColor,
                  onChanged: (isCheck) {
                    setState(() {
                      Provider.of<SignInModel>(context, listen: false)
                          .isRemember = isCheck;
                    });
                  },
                ),
                Text("次回から自動でログインします"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    final mailContlloer =
        Provider.of<SignInModel>(context, listen: false).mailEditController;
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: mailContlloer,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kEmailNullError)) {
          setState(() {
            errors.remove(kEmailNullError);
          });
        } else if (emailValidatorRegExp.hasMatch(value) &&
            errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.remove(kInvalidEmailError);
          });
        }
        Provider.of<SignInModel>(context, listen: false).mail = value;
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kEmailNullError)) {
          setState(() {
            errors.add(kEmailNullError);
          });
        } else if (value.isNotEmpty &&
            !emailValidatorRegExp.hasMatch(value) &&
            !errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.add(kInvalidEmailError);
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
            size: 24,
          ),
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    final passwordContlloer =
        Provider.of<SignInModel>(context, listen: false).passwordEditController;

    return TextFormField(
      obscureText: true,
      controller: passwordContlloer,
      onChanged: (password) {
        if (password.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
          });
        } else if (password.length >= 8 && errors.contains(kShortPassError)) {
          setState(() {
            errors.remove(kShortPassError);
          });
        }
        Provider.of<SignInModel>(context, listen: false).password = password;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kPassNullError)) {
          setState(() {
            errors.add(kPassNullError);
          });
        } else if (value.isNotEmpty &&
            value.length < 8 &&
            !errors.contains(kShortPassError)) {
          setState(() {
            errors.add(kShortPassError);
          });
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
