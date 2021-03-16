import 'package:favorite/model/album_detail/album_detail_model.dart';
import 'package:favorite/model/album_list/album_list_model.dart';
import 'package:favorite/model/book.dart';
import 'package:favorite/screen/album_detail/components/body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlbumDetailScreen extends StatelessWidget {
  final Book album;
  final AlbumListModel albumModel;

  const AlbumDetailScreen({
    Key key,
    this.album,
    this.albumModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AlbumDetailModel(),
      child: Consumer<AlbumDetailModel>(builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.yellow[100],
          body: Body(
            album: album,
            albumModel: albumModel,
          ),
        );
      }),
    );
  }
}
