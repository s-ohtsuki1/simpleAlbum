import 'package:favorite/constants.dart';
import 'package:favorite/screen/sign_up/sign_up_screen.dart';
import 'package:favorite/size_config.dart';
import 'package:flutter/material.dart';

class NoAccountText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("アカウントをお持ちではないですか？",
            style: TextStyle(fontSize: getProportionateScreenWidth(16))),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpScreen()),
          ),
          child: Text("会員登録",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(16),
                  color: kPrimaryColor)),
        ),
      ],
    );
  }
}
