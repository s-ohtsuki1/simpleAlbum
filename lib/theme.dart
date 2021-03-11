import 'package:flutter/material.dart';

import 'constants.dart';

// app bar theme
ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.yellow[100],
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.yellow[100],
    elevation: 0,
    brightness: Brightness.light,
    textTheme: TextTheme(
      headline6: TextStyle(color: kTextColor, fontSize: 18),
    ),
    iconTheme: IconThemeData(color: kTextColor),
  );
}

Text appBarTextStyle(String title) {
  return Text(
    title,
    style:
        TextStyle(fontSize: 18, color: kTextColor, fontWeight: FontWeight.bold),
  );
}

RoundedRectangleBorder appBarShape() {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(10),
    ),
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: kTextColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 48, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}
