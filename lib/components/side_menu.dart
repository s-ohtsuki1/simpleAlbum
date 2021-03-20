import 'package:favorite/model/album_list/album_list_model.dart';
import 'package:favorite/model/sign_in/sign_in_model.dart';
import 'package:favorite/screen/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../size_config.dart';

class SideManu extends StatelessWidget {
  final Duration duration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    AlbumListModel listModel =
        Provider.of<AlbumListModel>(context, listen: false);
    SignInModel signInModel = Provider.of<SignInModel>(context, listen: false);

    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: 0,
      right: listModel.isSideMenuOpen ? 0 : SizeConfig.screenWidth - 45,
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.brown[400],
              child: Align(
                alignment: Alignment.centerLeft,
                child: !listModel.isSideMenuOpen
                    ? SizedBox()
                    : MenuList(signInModel: signInModel),
              ),
            ),
          ),
          sideClip(listModel),
        ],
      ),
    );
  }

  Align sideClip(AlbumListModel listModel) {
    return Align(
      alignment: Alignment(0, -0.9),
      child: GestureDetector(
        onTap: () {
          listModel.sideMenuOpenClose();
        },
        child: Container(
          width: 35,
          height: 90,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(50),
            ),
            color: Colors.brown[400],
          ),
          child: Icon(Icons.menu, color: Colors.white),
        ),
      ),
    );
  }
}

class MenuList extends StatelessWidget {
  const MenuList({
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
