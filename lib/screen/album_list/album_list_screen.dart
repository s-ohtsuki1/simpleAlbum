import 'package:favorite/components/side_menu.dart';
import 'package:favorite/constants.dart';
import 'package:favorite/model/album_detail/album_detail_model.dart';
import 'package:favorite/model/album_list/album_list_model.dart';
import 'package:favorite/model/sign_in/sign_in_model.dart';
import 'package:favorite/presentaition/add_book/add_book_page.dart';
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
          return true;
        },
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          // appBar: buildAlbumAppBar(),
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
                      builder: (context) => AddBookPage(),
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

  AppBar buildAlbumAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Text(
        "アルバム一覧",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: kPrimaryColor,
      textTheme:
          TextTheme(headline6: TextStyle(color: Colors.white, fontSize: 18)),
      iconTheme: IconThemeData(color: Colors.white),
      centerTitle: false,
      actions: [
        IconButton(
          icon: IconButton(
            icon: Icon(
              Icons.notification_important_outlined,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
