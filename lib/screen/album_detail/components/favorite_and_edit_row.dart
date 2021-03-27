import 'package:favorite/model/picture.dart';
import 'package:favorite/screen/add_or_edit/add_edit_screen.dart';
import 'package:favorite/viewmodel/album_detail/album_detail_model.dart';
import 'package:favorite/viewmodel/album_list/album_list_model.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class FavoriteAndEditRow extends StatelessWidget {
  const FavoriteAndEditRow({
    Key key,
    @required this.listModel,
    @required this.picture,
    @required this.favoriteModel,
  }) : super(key: key);

  final Picture picture;
  final AlbumListModel listModel;
  final AlbumDetailModel favoriteModel;

  @override
  Widget build(BuildContext context) {
    return Row(
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
              color:
                  favoriteModel.isFavorite != null && favoriteModel.isFavorite
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
                  builder: (context) => AddEditScreen(picture: picture),
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
    );
  }
}
