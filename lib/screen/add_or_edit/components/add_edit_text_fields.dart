import 'package:favorite/model/picture.dart';
import 'package:favorite/util/date_util.dart';
import 'package:favorite/viewmodel/add_or_edit/add_or_edit_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants.dart';

class AddEditTextFields {}

TextFormField buildTitleForm(AddOrEditModel model, Picture? picture) {
  final titleEditController = TextEditingController();
  if (picture != null) {
    model.title = picture.title;
    titleEditController.text = model.title;
  }

  return TextFormField(
    validator: (val) {
      if (val!.isEmpty) {
        return '写真のタイトルを入力してください';
      }
      return null;
    },
    controller: titleEditController,
    onChanged: (text) {
      model.title = text;
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

TextFormField buildShotDtForm(AddOrEditModel model, Picture? picture, context) {
  final shotDtEditController = TextEditingController();

  if (picture != null) {
    model.shotDate = dateFormat(picture.shotDate.toDate());
    shotDtEditController.text = model.shotDate;
  }

  return TextFormField(
    readOnly: true,
    validator: (val) {
      if (val!.isEmpty) {
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
  Picture? picture,
) {
  final commentEditController = TextEditingController();

  if (picture != null) {
    model.comment = picture.comment;
    commentEditController.text = model.comment;
  }

  return TextFormField(
    keyboardType: TextInputType.multiline,
    maxLines: 3,
    inputFormatters: [
      LengthLimitingTextInputFormatter(30),
    ],
    textInputAction: TextInputAction.done,
    validator: (val) {
      if (val!.isEmpty) {
        return '写真のコメントを入力してください';
      }
      return null;
    },
    controller: commentEditController,
    onChanged: (text) {
      model.comment = text;
    },
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      labelText: "コメント",
      labelStyle: TextStyle(
        color: kSecondaryColor,
        fontWeight: FontWeight.bold,
      ),
      hintStyle: TextStyle(color: kSecondaryColor),
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
  );
}
