import 'package:favorite/components/default_button.dart';
import 'package:favorite/model/picture.dart';
import 'package:favorite/util/date_util.dart';
import 'package:favorite/viewmodel/add_or_edit/add_or_edit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final bool isUpdate = picture != null;

    return Consumer<AddOrEditModel>(builder: (context, model, child) {
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
                    buildShotDtForm(model, picture, context),
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

  TextFormField buildTitleForm(AddOrEditModel model, Picture picture) {
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

TextFormField buildShotDtForm(AddOrEditModel model, Picture picture, context) {
  final shotDtEditController = TextEditingController();
  if (picture != null) {
    shotDtEditController.text = dateFormat(picture.shotDate.toDate());
  }

  return TextFormField(
    readOnly: true,
    validator: (val) {
      if (val.isEmpty) {
        return '写真の撮影日を入力してください';
      }
      return null;
    },
    controller: shotDtEditController,
    onChanged: (text) {
      model.shotDate = text;
    },
    onTap: () async {
      shotDtEditController.text =
          await model.selectShotDate(context, shotDtEditController.text);
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

TextFormField buildCommentForm(
  AddOrEditModel model,
  Picture picture,
) {
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
    textInputAction: TextInputAction.done,
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
