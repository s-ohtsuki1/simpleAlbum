import 'package:favorite/model/picture.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class AlbumPoster extends StatelessWidget {
  const AlbumPoster({
    Key key,
    this.picture,
  }) : super(key: key);

  final Picture picture;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.network(
            picture.imageUrl,
            height: SizeConfig.screenWidth,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
