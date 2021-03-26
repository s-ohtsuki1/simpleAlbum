import 'package:favorite/components/side_menu/side_menu.dart';
import 'package:favorite/constants.dart';
import 'package:favorite/viewmodel/album_detail/album_detail_model.dart';
import 'package:favorite/viewmodel/album_list/album_list_model.dart';
import 'package:favorite/viewmodel/sign_in/sign_in_model.dart';
import 'package:favorite/screen/add_or_edit/add_edit_screen.dart';
import 'package:favorite/screen/album_list/components/body.dart';
import 'package:favorite/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlbumListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AlbumListModel>(
          create: (_) => AlbumListModel()..getNewPicture(),
        ),
        ChangeNotifierProvider<AlbumDetailModel>(
          create: (_) => AlbumDetailModel(),
        ),
        ChangeNotifierProvider<SignInModel>(
          create: (_) => SignInModel(),
        ),
      ],
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Consumer<AlbumListModel>(
            builder: (context, model, child) {
              return Stack(
                children: [
                  Body(),
                  SideManu(),
                ],
              );
            },
          ),
          floatingActionButton: Consumer<AlbumListModel>(
            builder: (context, model, child) {
              return FloatingActionButton(
                child: Icon(Icons.add),
                backgroundColor: kPrimaryColor,
                // 新規追加画面へ
                onPressed: () async {
                  await Navigator.push(
                    // doneMessage = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => AddEditScreen(),
                    ),
                  );
                  // if (doneMessage != '' && doneMessage != null) {
                  //   Scaffold.of(context).showSnackBar(
                  //     SnackBar(
                  //       content: Text(doneMessage),
                  //       backgroundColor: Colors.lightBlueAccent,
                  //     ),
                  //   );
                  // }
                  // await model.fetchBooks();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
