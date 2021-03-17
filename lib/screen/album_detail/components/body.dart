import 'package:favorite/entity/album.dart';
import 'package:favorite/model/album_detail/album_detail_model.dart';
import 'package:favorite/model/album_list/album_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'album_poster.dart';

class Body extends StatelessWidget {
  final Album album;
  final AlbumListModel albumModel;

  const Body({
    Key key,
    this.album,
    this.albumModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AlbumDetailModel favoriteModel =
        Provider.of<AlbumDetailModel>(context, listen: true);

    return Column(
      children: [
        Container(
          width: double.infinity,
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
                        color: albumModel.setCategoryColor(album.categoryId),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Text(
                        "アルバム" + album.categoryId.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      "assets/icons/calendar.svg",
                      height: 18,
                      width: 18,
                    ),
                    Text(
                      DateFormat('yyyy/MM/dd')
                          .format(album.createdAt.toDate())
                          .toString(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding / 2,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/camera.svg",
                          height: 18,
                          width: 18,
                        ),
                        Text(
                          album.title,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "遅めの初詣に行った時に食べたやつ。美味だった。",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: kDefaultPadding),
            ],
          ),
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: SizeConfig.screenWidth / 2,
                  height: kDefaultPadding * 3,
                  color: Colors.orange,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.lightBlue,
                      size: 42,
                    ),
                    onPressed: () async {
                      if (favoriteModel.isFavorite)
                        favoriteModel.picDocumentId = album.documentId;
                      // favoriteModel.userId =
                      await favoriteModel.saveFavorite();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: SizeConfig.screenWidth / 2,
                  height: kDefaultPadding * 3,
                  color: Colors.brown[600],
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      size: 36,
                      color: favoriteModel.isFavorite
                          ? Colors.pinkAccent
                          : Colors.grey,
                    ),
                    onPressed: () {
                      favoriteModel.changeFavorite();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
