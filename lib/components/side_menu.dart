import 'package:favorite/constants.dart';
import 'package:favorite/model/sign_in/sign_in_model.dart';
import 'package:favorite/screen/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideManu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SignInModel signInModel = Provider.of<SignInModel>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.brown[400],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: kDefaultPadding,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 36,
                      ),
                      SizedBox(width: kDefaultPadding),
                      Text(
                        "登録情報",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                    SizedBox(width: kDefaultPadding),
                    InkWell(
                      onTap: () async {
                        signInModel.logOut();
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInScreen(),
                          ),
                        );
                      },
                      child: Container(
                        child: Text(
                          "ログアウト",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
