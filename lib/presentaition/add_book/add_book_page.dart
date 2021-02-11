import 'package:favorite/domain/book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_book_model.dart';

class AddBookPage extends StatefulWidget {
  AddBookPage({this.book});
  final Book book;

  @override
  AddBookPageState createState() {
    return AddBookPageState(book: book);
  }
}

class AddBookPageState extends State<AddBookPage> {
  // formのグローバルキーを生成
  final _formKey = GlobalKey<FormState>();

  AddBookPageState({this.book});
  Book book;

  @override
  Widget build(BuildContext context) {
    final bool isUpdate = book != null;
    final textEditController = TextEditingController();

    if (isUpdate) {
      textEditController.text = book.title;
    }
    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(isUpdate ? '本を編集' : '本を追加'),
        ),
        body: Consumer<AddBookModel>(builder: (context, model, child) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return '本のタイトルを入力してください';
                    }
                    return null;
                  },
                  controller: textEditController,
                  onChanged: (text) {
                    model.bookTitle = text;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  // Submitボタン
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        // Firestoreに追加
                        if (isUpdate) {
                          await model.updateBook(book);
                        } else {
                          await model.addBook();
                        }

                        final doneMessage = isUpdate ? '編集しました' : '追加しました';
                        Navigator.pop(context, doneMessage);
                      }
                    },
                    child: Text(isUpdate ? '編集する' : '追加する'),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
