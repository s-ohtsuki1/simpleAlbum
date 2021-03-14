import 'package:favorite/model/book.dart';
import 'package:favorite/screen/album_detail/components/body.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class AlbumDetailScreen extends StatelessWidget {
  final Book album;

  const AlbumDetailScreen({Key key, this.album}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: buildAlbumDetailAppbar(),
      body: Body(
        album: album,
      ),
    );
  }

  AppBar buildAlbumDetailAppbar() {
    return AppBar(
      backgroundColor: Colors.yellow[100],
      iconTheme: IconThemeData(
        color: Colors.brown, //change your color here
      ),
      elevation: 0,
      centerTitle: false,
      title: Text(
        "戻る",
        style: TextStyle(color: Colors.brown),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.save_alt),
          onPressed: () {},
        ),
      ],
    );
  }
}
