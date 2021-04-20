import 'package:favorite/components/default_button.dart';
import 'package:favorite/components/form_error.dart';
import 'package:favorite/constants.dart';
import 'package:favorite/util/validator_util.dart';
import 'package:favorite/viewmodel/forgot_password/forgot_password_model.dart';
import 'package:favorite/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  final validator = ValidatorUtil();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ForgotPasswordModel model =
        Provider.of<ForgotPasswordModel>(context, listen: true);

    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: kDefaultPadding * 2),
              Text(
                "登録したメールアドレス宛に、\nパスワード再設定メールを送信します。",
                textAlign: TextAlign.center,
              ),
              Image.asset(
                "assets/images/forgot_pass_mail.png",
                height: SizeConfig.screenHeight * 0.3,
                width: SizeConfig.screenWidth * 0.4,
              ),
              SizedBox(height: 20),
              FormError(errorCode: model.errorCode),
              Form(
                key: _formKey,
                child: buildEmailFormField(model),
              ),
              SizedBox(height: getProportionateScreenHeight(50)),
              DefaultButton(
                text: "送信",
                press: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await model.sendPasswordResetEmail(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildEmailFormField(ForgotPasswordModel model) {
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
}
