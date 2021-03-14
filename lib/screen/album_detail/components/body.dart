import 'package:favorite/model/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import 'album_poster.dart';

class Body extends StatelessWidget {
  final Book album;

  const Body({Key key, this.album}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              Center(
                child: AlbumPoster(album: album),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                child: Text(
                  "遅めの初詣に行った時に食べたやつ。美味だった。",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: kDefaultPadding),
            ],
          ),
        ),
        Spacer(),
        Container(
          // margin: EdgeInsets.all(kDefaultPadding / 2),
          padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
            vertical: kDefaultPadding / 2,
          ),
          decoration: BoxDecoration(
            color: Colors.brown,
            // borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite,
                color: Colors.pinkAccent,
                size: 36,
              ),
              SizedBox(width: kDefaultPadding / 2),
              Text(
                "お気に入り",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
