import 'package:favorite/components/default_button.dart';
import 'package:favorite/entity/picture.dart';
import 'package:favorite/presentaition/add_book/add_book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
    this.picture,
  }) : super(key: key);

  final Picture picture;

  @override
  Widget build(BuildContext context) {
    // final bottomSpace = MediaQuery.of(context).viewInsets.bottom;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final bool isUpdate = picture != null;

    return Consumer<AddBookModel>(builder: (context, model, child) {
      if (isUpdate) {
        model.imageUrl = picture.imageUrl;
      }
      return SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: SizeConfig.screenWidth * 0.9,
                height: SizeConfig.screenHeight * 0.4,
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: InkWell(
                  onTap: () async {
                    await model.showImagePicker();
                  },
                  child: model.imageFile != null
                      ? Image.file(model.imageFile)
                      : isUpdate
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                picture.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                                size: 64,
                              ),
                            ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding,
                ),
                child: Column(
                  children: [
                    buildTitleForm(model, picture),
                    SizedBox(height: kDefaultPadding),
                    buildShotDtForm(model, picture),
                    SizedBox(height: kDefaultPadding),
                    buildCommentForm(model, picture),
                    SizedBox(height: kDefaultPadding * 1.5),
                    DefaultButton(
                      text: isUpdate ? '編集する' : '追加する',
                      press: () async {
                        if (_formKey.currentState.validate()) {
                          await model.startLoading();

                          // Firestoreに追加
                          if (isUpdate) {
                            await model.updateBook(picture);
                          } else {
                            await model.addBook();
                          }
                          await model.endLoading();
                          // final doneMessage = isUpdate ? '編集しました' : '追加しました';
                          // Navigator.pop(context, doneMessage);
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  TextFormField buildTitleForm(AddBookModel model, Picture picture) {
    final titleEditController = TextEditingController();
    if (picture != null) {
      titleEditController.text = picture.title;
    }

    return TextFormField(
      validator: (val) {
        if (val.isEmpty) {
          return '写真のタイトルを入力してください';
        }
        return null;
      },
      controller: titleEditController,
      onChanged: (text) {
        model.bookTitle = text;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: "タイトル",
        labelStyle: TextStyle(
          color: kSecondaryColor,
          fontWeight: FontWeight.bold,
        ),
        hintText: "写真のタイトル",
        hintStyle: TextStyle(color: kSecondaryColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}

TextFormField buildShotDtForm(AddBookModel model, Picture picture) {
  final shotDtEditController = TextEditingController();
  if (picture != null) {
    shotDtEditController.text = picture.shotDate.toString();
  }

  return TextFormField(
    validator: (val) {
      if (val.isEmpty) {
        return '写真の撮影日を入力してください';
      }
      return null;
    },
    controller: shotDtEditController,
    onChanged: (text) {
      model.bookTitle = text;
    },
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      labelText: "撮影日",
      labelStyle: TextStyle(
        color: kSecondaryColor,
        fontWeight: FontWeight.bold,
      ),
      hintText: "xxxx/xx/xx",
      hintStyle: TextStyle(color: kSecondaryColor),
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
  );
}

TextFormField buildCommentForm(AddBookModel model, Picture picture) {
  final commentEditController = TextEditingController();
  if (picture != null) {
    commentEditController.text = picture.comment;
  }

  return TextFormField(
    keyboardType: TextInputType.multiline,
    maxLines: 3,
    inputFormatters: [
      LengthLimitingTextInputFormatter(30),
    ],
    validator: (val) {
      if (val.isEmpty) {
        return '写真のコメントを入力してください';
      }
      return null;
    },
    controller: commentEditController,
    onChanged: (text) {
      model.bookTitle = text;
    },
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      labelText: "コメント",
      labelStyle: TextStyle(
        color: kSecondaryColor,
        fontWeight: FontWeight.bold,
      ),
      // hintText: "xxxx/xx/xx",
      hintStyle: TextStyle(color: kSecondaryColor),
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
  );
}
