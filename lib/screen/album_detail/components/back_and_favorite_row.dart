import 'package:favorite/entity/picture.dart';
import 'package:favorite/model/album_detail/album_detail_model.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class BackAndFavoriteRow extends StatelessWidget {
  const BackAndFavoriteRow({
    Key key,
    @required this.favoriteModel,
    @required this.picture,
  }) : super(key: key);

  final AlbumDetailModel favoriteModel;
  final Picture picture;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: SizeConfig.screenWidth / 2,
              height: kDefaultPadding * 3,
              color: kPrimaryColor,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
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
              color: kSecondaryColor,
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
    );
  }
}
