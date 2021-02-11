import 'package:favorite/presentaition/add_book/add_book_page.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'book_list_model.dart';

class BookListPage extends StatelessWidget {
  final _key = GlobalKey<ScaffoldState>();
  var doneMessage = '';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBooks(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('本一覧'),
        ),
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
                              builder: (context) => AddBookPage(book: book),
                            ),
                          );
                          if (doneMessage != '' && doneMessage != null) {
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text(doneMessage),
                                action: SnackBarAction(
                                  label: 'OK',
                                  onPressed: () {
                                    // Navigator.pop(context);
                                  },
                                ),
                              ),
                            );
                          }
                          await model.fetchBooks();
                        },
                      ),
                      // 長押しで本を削除
                      onLongPress: () async {
                        bool result = false;
                        result = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            return BookDeleteDialog(book.title);
                          },
                        );
                        if (result != null && result) {
                          await model.deleteBook(book);
                          final snackBar = SnackBar(
                            content: Text('${book.title}を削除しました'),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
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
        floatingActionButton:
            Consumer<BookListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            child: Icon(Icons.add),
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
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(doneMessage),
                    action: SnackBarAction(
                      label: 'OK',
                      onPressed: () {
                        // Navigator.pop(context);
                      },
                    ),
                  ),
                );
              }
              await model.fetchBooks();
            },
          );
        }),
      ),
    );
  }
}

class BookDeleteDialog extends StatelessWidget {
  BookDeleteDialog(this.deleteTitle);
  final deleteTitle;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('${this.deleteTitle}を削除しますか？'),
      children: <Widget>[
        SimpleDialogOption(
          child: RaisedButton(
            child: Text('削除する'),
            color: Colors.red,
            shape: StadiumBorder(),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ),
        SimpleDialogOption(
          child: RaisedButton(
            child: Text('キャンセル'),
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
