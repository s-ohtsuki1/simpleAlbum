import 'package:favorite/model/book.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class AlbumPoster extends StatelessWidget {
  const AlbumPoster({
    Key key,
    this.album,
  }) : super(key: key);

  final Book album;

  @override
  Widget build(BuildContext context) {
    // AlbumListModel model = Provider.of<AlbumListModel>(context, listen: false);

    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
      // height: SizeConfig.screenWidth * 1,
      child: Column(
        // alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.network(
              album.imageUrl,
              height: SizeConfig.screenWidth * 0.75,
              width: SizeConfig.screenWidth * 0.75,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: SizeConfig.screenWidth / 8,
            width: SizeConfig.screenWidth * 0.75,
            margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding * 1.5,
              vertical: kDefaultPadding / 4,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  album.title,
                  // product.categoryId.toString(),
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
