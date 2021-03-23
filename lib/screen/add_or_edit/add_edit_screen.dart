import 'package:favorite/entity/picture.dart';
import 'package:favorite/presentaition/add_book/add_book_model.dart';
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
    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text(isUpdate ? '写真を編集' : '写真を追加'),
            ),
            body: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Body(
                picture: picture,
              ),
            ),
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
