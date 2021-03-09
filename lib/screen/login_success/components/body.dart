import 'package:favorite/components/default_button.dart';
import 'package:favorite/presentaition/book_list/book_list_page.dart';
import 'package:favorite/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Center(
          child: Image.asset("assets/images/animal_login_success.png",
              height: SizeConfig.screenHeight * 0.4),
        ), // 40%
        SizedBox(height: SizeConfig.screenHeight * 0.08),
        Text(
          "おかえりなさい！",
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
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookListPage()),
              );
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}
