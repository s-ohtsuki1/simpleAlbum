import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import 'album_poster.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          decoration: BoxDecoration(
            color: Colors.yellow[100],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          child: Column(
            children: [
              Center(
                child: AlbumPoster(image: "assets/images/sisimai.png"),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 1.5,
                  vertical: kDefaultPadding / 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  // color: model.setCategoryColor(product.categoryId),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Text(
                  "カテゴリ1",
                  // product.categoryId.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/calendar.svg",
                      height: 18,
                      width: 18,
                    ),
                    Text(
                      "2021/03/03",
                      // DateFormat('yyyy/MM/dd')
                      //     .format()
                      //     .toString(),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/camera.svg",
                    height: 18,
                    width: 18,
                  ),
                  Text(
                    "獅子舞の写真",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
