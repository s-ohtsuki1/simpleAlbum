import 'package:favorite/viewmodel/album_list/album_list_model.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class TopMenuBar extends StatelessWidget {
  const TopMenuBar({required this.model});

  final AlbumListModel model;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
          Text(
            "Simple Album",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Icon(
            Icons.notification_important_outlined,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
