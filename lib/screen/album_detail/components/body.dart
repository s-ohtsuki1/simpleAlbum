import 'package:favorite/entity/picture.dart';
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
  final Picture picture;

  const Body({
    Key key,
    this.picture,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AlbumListModel albumModel =
        Provider.of<AlbumListModel>(context, listen: false);
    AlbumDetailModel favoriteModel =
        Provider.of<AlbumDetailModel>(context, listen: false);

    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Column(
            children: [
              Center(
                child: AlbumPoster(picture: picture),
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
                        color: albumModel.setCategoryColor(picture.albumNo),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Text(
                        "アルバム" + picture.albumNo.toString(),
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
                          .format(picture.createdAt.toDate())
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
                          picture.title,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      picture.coment,
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
                      await favoriteModel.saveFavorite(
                        picture.documentId,
                        picture.preIsFavorite,
                      );
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
                      color: favoriteModel.isFavorite != null &&
                              favoriteModel.isFavorite
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
