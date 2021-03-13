import 'package:favorite/components/default_button.dart';
import 'package:favorite/screen/album_list/album_list_screen.dart';
import 'package:favorite/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.2),
        Center(
          child: Image.asset("assets/images/login_success_key.png",
              height: SizeConfig.screenHeight * 0.3),
        ), // 40%
        SizedBox(height: SizeConfig.screenHeight * 0.08),
        Text(
          "ログインしました！",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(20),
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: "HOME",
            press: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AlbumListScreen()),
              );
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}
