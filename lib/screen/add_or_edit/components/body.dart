import 'package:favorite/components/default_button.dart';
import 'package:favorite/model/picture.dart';
import 'package:favorite/screen/album_list/album_list_screen.dart';
import 'package:favorite/viewmodel/add_or_edit/add_or_edit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'add_edit_text_fields.dart';
import 'picture_field.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
    this.picture,
  }) : super(key: key);

  final Picture picture;

  @override
  Widget build(BuildContext context) {
    AddOrEditModel addOrEditModel =
        Provider.of<AddOrEditModel>(context, listen: false);

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final bool isUpdate = picture != null;

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
                  await addOrEditModel.showImagePicker();
                },
                child: PictureField(isUpdate: isUpdate, picture: picture),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
                vertical: kDefaultPadding,
              ),
              child: Column(
                children: [
                  buildTitleForm(addOrEditModel, picture),
                  SizedBox(height: kDefaultPadding),
                  buildShotDtForm(addOrEditModel, picture, context),
                  SizedBox(height: kDefaultPadding),
                  buildCommentForm(addOrEditModel, picture),
                  SizedBox(height: kDefaultPadding * 1.5),
                  DefaultButton(
                    text: isUpdate ? '編集する' : '追加する',
                    press: () async {
                      if (_formKey.currentState.validate()) {
                        await addOrEditModel.startLoading();

                        if (isUpdate) {
                          await addOrEditModel.updatePicture(picture);
                        } else {
                          await addOrEditModel.addPicture();
                        }
                        await addOrEditModel.endLoading();
                        // final doneMessage = isUpdate ? '編集しました' : '追加しました';
                        // Navigator.pop(context, doneMessage);
                        addOrEditModel.initField();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AlbumListScreen(),
                          ),
                        );
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
  }
}
