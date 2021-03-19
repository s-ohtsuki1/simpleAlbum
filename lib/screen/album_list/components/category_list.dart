import 'package:favorite/constants.dart';
import 'package:favorite/model/album_list/album_list_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatelessWidget {
  final List categories = [
    '最新10件',
    'アルバム1',
    'アルバム2',
    'アルバム3',
    'アルバム4',
  ];
  @override
  Widget build(BuildContext context) {
    AlbumListModel model = Provider.of<AlbumListModel>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 50),
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            model.changeAlbumNo(index);
            if (index == 0)
              model.getNewPicture();
            else
              model.getAlbumNoPicture();
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              left: kDefaultPadding,
              right: index == categories.length - 1 ? kDefaultPadding : 0,
            ),
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            decoration: BoxDecoration(
              color: index == model.selectAlbumNo
                  ? Colors.yellow[100]
                  : model.setCategoryColor(index),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
                  offset: Offset(10, 10),
                ),
              ],
            ),
            child: Text(
              categories[index],
              style: TextStyle(
                color:
                    index == model.selectAlbumNo ? kPrimaryColor : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
