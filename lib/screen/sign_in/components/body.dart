import 'package:favorite/components/socal_card.dart';
import 'package:favorite/constants.dart';
import 'package:favorite/size_config.dart';
import 'package:flutter/material.dart';

import 'sign_form.dart';

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
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(20),
                      fontWeight: FontWeight.bold,
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
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocalCard(
                        icon: 'assets/icons/google-icon.svg',
                        press: () {},
                      ),
                      SocalCard(
                        icon: "assets/icons/facebook-2.svg",
                        press: () {},
                      ),
                      SocalCard(
                        icon: 'assets/icons/twitter.svg',
                        press: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("アカウントをお持ちではないですか？",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(16))),
                      Text("会員登録",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(16),
                              color: kPrimaryColor)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
