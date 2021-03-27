import 'package:favorite/model/picture.dart';
import 'package:favorite/viewmodel/album_detail/album_detail_model.dart';
import 'package:favorite/screen/album_detail/components/body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlbumDetailScreen extends StatelessWidget {
  final Picture picture;

  const AlbumDetailScreen({
    Key key,
    this.picture,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<AlbumDetailModel>(builder: (context, model, child) {
      return Scaffold(
        backgroundColor: Colors.yellow[100],
        body: Body(
          picture: picture,
        ),
      );
    });
  }
}
