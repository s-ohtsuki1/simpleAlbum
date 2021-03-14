import 'package:favorite/screen/album_detail/components/body.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class AlbumDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAlbumDetailAppbar(),
      body: Body(),
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
