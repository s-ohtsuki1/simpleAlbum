import 'package:favorite/constants.dart';
import 'package:favorite/model/album_detail/album_detail_model.dart';
import 'package:favorite/model/album_list/album_list_model.dart';
import 'package:favorite/screen/album_detail/album_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'album_card.dart';
import 'category_list.dart';
import 'search_box.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AlbumListModel listModel =
        Provider.of<AlbumListModel>(context, listen: false);
    AlbumDetailModel detailModel =
        Provider.of<AlbumDetailModel>(context, listen: false);
    return Column(
      children: [
        // SearchBox(onChanged: (value) {}),
        SizedBox(
          height: kDefaultPadding,
        ),
        CategoryList(),
        SizedBox(
          height: kDefaultPadding / 2,
        ),
        Expanded(
          child: Stack(
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
                    listModel.pictures[index].preIsFavorite =
                        detailModel.isFavorite;
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
          ),
        ),
      ],
    );
  }
}
