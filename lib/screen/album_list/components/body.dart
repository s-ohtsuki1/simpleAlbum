import 'package:favorite/constants.dart';
import 'package:favorite/model/album_detail/album_detail_model.dart';
import 'package:favorite/model/album_list/album_list_model.dart';
import 'package:favorite/model/sign_in/sign_in_model.dart';
import 'package:favorite/screen/album_detail/album_detail_screen.dart';
import 'package:favorite/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'album_card.dart';
import 'category_list.dart';
import 'top_menu_bar.dart';

class Body extends StatelessWidget {
  final Duration duration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    AlbumListModel listModel =
        Provider.of<AlbumListModel>(context, listen: false);
    AlbumDetailModel detailModel =
        Provider.of<AlbumDetailModel>(context, listen: false);
    return AnimatedPositioned(
      duration: duration,
      top: listModel.isSideMenuOpen ? 0.2 * SizeConfig.screenHeight : 0,
      bottom: 0,
      left: listModel.isSideMenuOpen ? 0.6 * SizeConfig.screenWidth : 0,
      right: listModel.isSideMenuOpen ? -0.4 * SizeConfig.screenWidth : 0,
      child: Material(
        animationDuration: duration,
        borderRadius: listModel.isSideMenuOpen
            ? BorderRadius.all(Radius.circular(40))
            : BorderRadius.all(Radius.circular(0)),
        elevation: 8,
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
                            await detailModel.fetchFavorite(
                                listModel.pictures[index].documentId);
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
            ),
          ),
        ),
      ),
    );
  }
}
