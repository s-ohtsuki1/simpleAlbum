import 'package:favorite/constants.dart';
import 'package:favorite/viewmodel/album_detail/album_detail_model.dart';
import 'package:favorite/viewmodel/album_list/album_list_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'category_list.dart';
import 'picture_list.dart';
import 'top_menu_bar.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AlbumListModel listModel =
        Provider.of<AlbumListModel>(context, listen: true);
    AlbumDetailModel detailModel =
        Provider.of<AlbumDetailModel>(context, listen: true);

    return Material(
      color: kPrimaryColor,
      child: SafeArea(
        child: Container(
          child: Column(
            children: [
              TopMenuBar(model: listModel),
              SizedBox(height: kDefaultPadding / 2),
              CategoryList(),
              SizedBox(height: kDefaultPadding / 2),
              Expanded(
                child:
                    PictureList(listModel: listModel, detailModel: detailModel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
