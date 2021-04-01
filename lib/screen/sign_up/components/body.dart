import 'package:favorite/components/default_button.dart';
import 'package:favorite/components/form_error.dart';
import 'package:favorite/constants.dart';
import 'package:favorite/screen/album_list/album_list_screen.dart';
import 'package:favorite/size_config.dart';
import 'package:favorite/viewmodel/sign_up/sign_up_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                  SizedBox(height: getProportionateScreenHeight(50)),
                  Center(
                    child: Image.asset(
                      'assets/images/niwatori_sign_up.png',
                      height: getProportionateScreenHeight(120),
                      width: getProportionateScreenWidth(120),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  Text(
                    "メールアドレスとパスワードを入力してください。",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
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
    final model = Provider.of<SignUpModel>(context, listen: false);

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
              text: "登録",
              press: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  if (errors.isEmpty) {
                    try {
                      await model.signUp();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AlbumListScreen()),
                      );
                    } catch (e) {
                      // TODO err
                      // _showDialog(context, e.toString());
                    }
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    final mailContlloer =
        Provider.of<SignUpModel>(context, listen: false).mailEditController;

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
        Provider.of<SignUpModel>(context, listen: false).mail = value;
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kEmailNullError)) {
          setState(() {
            errors.add(kEmailNullError);
          });
        } else if (!emailValidatorRegExp.hasMatch(value) &&
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
            size: 32,
          ),
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    final passwordContlloer =
        Provider.of<SignUpModel>(context, listen: false).passwordEditController;

    return TextFormField(
      obscureText: true,
      controller: passwordContlloer,
      onChanged: (password) {
        Provider.of<SignUpModel>(context, listen: false).password = password;
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
            size: 32,
          ),
        ),
      ),
    );
  }
}
