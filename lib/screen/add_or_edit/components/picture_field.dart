import 'dart:io';

import 'package:favorite/model/picture.dart';
import 'package:favorite/viewmodel/add_or_edit/add_or_edit_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PictureField extends StatelessWidget {
  const PictureField({
    required this.isUpdate,
    this.picture,
  });

  final bool isUpdate;
  final Picture? picture;

  @override
  Widget build(BuildContext context) {
    AddOrEditModel addEditModel =
        Provider.of<AddOrEditModel>(context, listen: true);

    return Container(
      child: addEditModel.imageFile.path.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.file(
                addEditModel.imageFile,
                fit: BoxFit.cover,
              ),
            )
          : isUpdate
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    picture!.imageUrl,
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
    );
  }
}
