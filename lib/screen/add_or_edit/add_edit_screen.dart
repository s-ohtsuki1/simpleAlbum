import 'package:favorite/model/picture.dart';
import 'package:favorite/viewmodel/add_or_edit/add_or_edit_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class AddEditScreen extends StatelessWidget {
  AddEditScreen({Key key, this.picture}) : super(key: key);
  final Picture picture;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bool isUpdate = picture != null;
    final textEditController = TextEditingController();

    if (isUpdate) {
      textEditController.text = picture.title;
    }
    return ChangeNotifierProvider<AddOrEditModel>(
      create: (_) => AddOrEditModel(),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                isUpdate ? '写真を編集' : '写真を追加',
              ),
            ),
            body: Body(
              picture: picture,
            ),
          ),
          // ローディングアニメーション
          Consumer<AddOrEditModel>(
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
