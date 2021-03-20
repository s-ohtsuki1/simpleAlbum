import 'package:favorite/model/sign_in/sign_in_model.dart';
import 'package:favorite/screen/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class SideMenuList extends StatelessWidget {
  const SideMenuList({
    Key key,
    @required this.signInModel,
  }) : super(key: key);

  final SignInModel signInModel;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
