import 'package:favorite/model/picture.dart';
import 'package:favorite/viewmodel/album_detail/album_detail_model.dart';
import 'package:favorite/viewmodel/album_list/album_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'album_poster.dart';
import 'back_and_shotdt_row.dart';
import 'favorite_and_edit_row.dart';

class Body extends StatelessWidget {
  final Picture picture;

  const Body({
    Key key,
    this.picture,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AlbumListModel listModel =
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
                padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
                child: FavoriteAndEditRow(
                    listModel: listModel,
                    picture: picture,
                    favoriteModel: favoriteModel),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
                vertical: kDefaultPadding / 2,
              ),
              child: Text(
                picture.comment,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Spacer(),
        BackAndShotDtRow(favoriteModel: favoriteModel, picture: picture),
      ],
    );
  }
}
