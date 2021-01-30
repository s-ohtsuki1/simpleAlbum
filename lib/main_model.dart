import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  String frontText = "Whats's favorite?";

  void changeFrontText() {
    frontText = 'nothing';
    notifyListeners();
  }
}
