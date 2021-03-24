import 'package:favorite/constants.dart';
import 'package:favorite/presentaition/add_book/add_book_page.dart';
import 'package:favorite/theme.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'book_list_model.dart';

class BookListPage extends StatelessWidget {
  String doneMessage = '';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBooks(),
      child: Scaffold(
        appBar: AppBar(
          title: Icon(Icons.sensor_door_outlined, size: 36),
          shape: appBarShape(),
          automaticallyImplyLeading: false,
        ),
        resizeToAvoidBottomInset: false,
        body: Consumer<BookListModel>(
          builder: (context, model, child) {
            final books = model.books;
            final listTiles = books
                .map((book) => ListTile(
                      leading: Image.network(book.imageUrl),
                      title: Text(book.title),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        // 編集画面へ
                        onPressed: () async {
                          doneMessage = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                // builder: (context) => AddBookPage(book: book),
                                ),
                          );
                          if (doneMessage != '' && doneMessage != null) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(doneMessage),
                              backgroundColor: Colors.lightGreen,
                            ));
                          }
                          await model.fetchBooks();
                        },
                      ),
                      // 長押しで本を削除
                      onLongPress: () async {
                        doneMessage = await showDialog<String>(
                          context: context,
                          builder: (BuildContext context) {
                            return BookDeleteDialog(book.title);
                          },
                        );
                        if (doneMessage != '' && doneMessage != null) {
                          await model.deleteBook(book);
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(doneMessage),
                            backgroundColor: Colors.deepOrangeAccent,
                          ));
                          await model.fetchBooks();
                        }
                      },
                    ))
                .toList();
            return ListView(
              children: listTiles,
            );
          },
        ),
        floatingActionButton: Consumer<BookListModel>(
          builder: (context, model, child) {
            return FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: kPrimaryColor,
              // 新規追加画面へ
              onPressed: () async {
                doneMessage = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => AddBookPage(),
                  ),
                );
                if (doneMessage != '' && doneMessage != null) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(doneMessage),
                    backgroundColor: Colors.lightBlueAccent,
                  ));
                }
                await model.fetchBooks();
              },
            );
          },
        ),
      ),
    );
  }
}

// test@email.com
class BookDeleteDialog extends StatelessWidget {
  BookDeleteDialog(this.deleteTitle);
  final deleteTitle;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('${this.deleteTitle}を削除しますか？'),
      children: <Widget>[
        SimpleDialogOption(
          child: FloatingActionButton(
            child: Text('削除する'),
            backgroundColor: Colors.pinkAccent,
            // color: Colors.red,
            shape: StadiumBorder(),
            onPressed: () {
              Navigator.pop(context, '${this.deleteTitle}を削除しました');
            },
          ),
        ),
        SimpleDialogOption(
          child: FloatingActionButton(
            child: Text(
              'キャンセル',
              style: TextStyle(color: Colors.black87),
            ),
            backgroundColor: Colors.white38,
            shape: StadiumBorder(),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
