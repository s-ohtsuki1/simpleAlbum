import 'package:favorite/entity/album.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class AlbumPoster extends StatelessWidget {
  const AlbumPoster({
    Key key,
    this.album,
  }) : super(key: key);

  final Album album;

  @override
  Widget build(BuildContext context) {
    // AlbumListModel model = Provider.of<AlbumListModel>(context, listen: false);

    return Container(
      child: Column(
        children: [
          Image.network(
            album.imageUrl,
            height: SizeConfig.screenWidth,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
