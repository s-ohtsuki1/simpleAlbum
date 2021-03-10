import 'package:favorite/components/default_button.dart';
import 'package:favorite/components/form_error.dart';
import 'package:favorite/components/no_account_text.dart';
import 'package:favorite/constants.dart';
import 'package:favorite/model/forgot_password/forgot_password_model.dart';
import 'package:favorite/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              Image.asset(
                "assets/images/forgot_pass_mail.png",
                height: SizeConfig.screenHeight * 0.3,
                width: SizeConfig.screenWidth * 0.4,
              ),
              // SizedBox(height: SizeConfig.screenHeight * 0.001),
              Text(
                "登録したメールアドレス宛に、\nパスワード再設定メールを送信します。",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.01),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    final mailContlloer =
        Provider.of<ForgotPasswordModel>(context, listen: false)
            .mailEditController;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
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
              Provider.of<ForgotPasswordModel>(context, listen: false).mail =
                  value;
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
          ),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "送信",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                if (errors.isEmpty) {
                  try {
                    // TODO パスワード再設定メール送信
                    // await model.login();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => BookListPage()),
                    // );
                  } catch (e) {
                    // TODO err
                    // _showDialog(context, e.toString());
                  }
                }
              } else {}
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          NoAccountText(),
        ],
      ),
    );
  }
}
