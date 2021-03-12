import 'package:flutter/material.dart';

class AlbumListModel extends ChangeNotifier {
  // カテゴリーカラーをセット
  Color setCategoryColor(int categoryId) {
    switch (categoryId) {
      case 0:
        return Colors.teal;
      case 1:
        return Colors.red;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.green;
      case 4:
        return Colors.pink;
    }
  }
}
