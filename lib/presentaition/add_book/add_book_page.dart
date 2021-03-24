import 'package:favorite/model/picture.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_book_model.dart';

class AddBookPage extends StatelessWidget {
  AddBookPage({Key key, this.picture}) : super(key: key);
  final Picture picture;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bool isUpdate = picture != null;
    final textEditController = TextEditingController();

    if (isUpdate) {
      textEditController.text = picture.title;
    }
    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text(isUpdate ? '本を編集' : '本を追加'),
            ),
            body: Consumer<AddBookModel>(builder: (context, model, child) {
              if (isUpdate) {
                model.imageUrl = picture.imageUrl;
              }
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: 100,
                        height: 160,
                        child: InkWell(
                          onTap: () async {
                            await model.showImagePicker();
                          },
                          child: model.imageFile != null
                              ? Image.file(model.imageFile)
                              : isUpdate
                                  ? Image.network(picture.imageUrl)
                                  : Container(
                                      color: Colors.grey,
                                    ),
                        ),
                      ),
                    ),
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
                            await model.startLoading();

                            // Firestoreに追加
                            if (isUpdate) {
                              await model.updateBook(picture);
                            } else {
                              await model.addBook();
                            }
                            await model.endLoading();
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
          // ローディングアニメーション
          Consumer<AddBookModel>(
            builder: (context, model, child) {
              // bool r = model.isUploading;
              return model.isUploading
                  ? Container(
                      color: Colors.grey.withOpacity(0.7),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.indigo),
                        ),
                      ),
                    )
                  : SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
