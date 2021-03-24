import 'package:favorite/model/picture.dart';
import 'package:favorite/viewmodel/album_detail/album_detail_model.dart';
import 'package:favorite/viewmodel/album_list/album_list_model.dart';
import 'package:favorite/screen/add_or_edit/add_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'album_poster.dart';

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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 1.5,
                        vertical: kDefaultPadding / 4,
                      ),
                      decoration: BoxDecoration(
                        color: listModel.setCategoryColor(picture.albumNo),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Text(
                        "アルバム" + picture.albumNo.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          size: 42,
                          color: favoriteModel.isFavorite != null &&
                                  favoriteModel.isFavorite
                              ? Colors.pink
                              : Colors.grey,
                        ),
                        onPressed: () {
                          favoriteModel.changeFavorite();
                        },
                      ),
                    ),
                    Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        color: Colors.yellow[100],
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: kSecondaryColor,
                          size: 36,
                        ),
                        // 編集画面へ
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddEditScreen(picture: picture),
                            ),
                          );
                          // if (doneMessage != '' && doneMessage != null) {
                          //   Scaffold.of(context).showSnackBar(SnackBar(
                          //     content: Text(doneMessage),
                          //     backgroundColor: Colors.lightGreen,
                          //   ));
                          // }
                          // await model.fetchBooks();
                        },
                      ),
                    ),
                  ],
                ),
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
        Row(
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
                "撮影日: " +
                    DateFormat('yyyy/MM/dd')
                        .format(picture.createdAt.toDate())
                        .toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
