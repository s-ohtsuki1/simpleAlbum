import 'package:favorite/viewmodel/album_detail/album_detail_model.dart';
import 'package:favorite/viewmodel/album_list/album_list_model.dart';
import 'package:favorite/screen/album_detail/album_detail_screen.dart';
import 'package:flutter/material.dart';

import 'album_card.dart';

class PictureList extends StatelessWidget {
  const PictureList({
    Key key,
    @required this.listModel,
    @required this.detailModel,
  }) : super(key: key);

  final AlbumListModel listModel;
  final AlbumDetailModel detailModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 70),
          decoration: BoxDecoration(
            color: Colors.yellow[100],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
        ),
        ListView.builder(
          itemCount: listModel.pictures.length,
          itemBuilder: (context, index) => AlbumCard(
            itemIndex: index,
            picture: listModel.pictures[index],
            press: () async {
              await detailModel
                  .fetchFavorite(listModel.pictures[index].documentId);
              listModel.pictures[index].preIsFavorite = detailModel.isFavorite;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AlbumDetailScreen(
                    picture: listModel.pictures[index],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
