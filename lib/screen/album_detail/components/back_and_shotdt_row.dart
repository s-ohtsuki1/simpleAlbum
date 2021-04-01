import 'package:favorite/model/picture.dart';
import 'package:favorite/util/date_util.dart';
import 'package:favorite/viewmodel/album_detail/album_detail_model.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class BackAndShotDtRow extends StatelessWidget {
  const BackAndShotDtRow({
    required this.favoriteModel,
    required this.picture,
  });

  final AlbumDetailModel favoriteModel;
  final Picture picture;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 5,
          ),
          child: GestureDetector(
            onTap: () async {
              await favoriteModel.saveFavorite(
                picture.documentId,
                picture.preIsFavorite,
              );
              Navigator.pop(context);
            },
            child: Container(
              child: Icon(
                Icons.arrow_back_rounded,
                color: Colors.lightBlue,
                size: 50,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Text(
            "撮影日: " + dateFormat(picture.shotDate.toDate()),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
