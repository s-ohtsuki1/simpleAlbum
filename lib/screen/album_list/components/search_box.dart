import 'package:favorite/constants.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key key,
    this.onChanged,
  }) : super(key: key);
  final ValueChanged onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kDefaultPadding),
      padding: EdgeInsets.symmetric(
        // horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 30,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: TextField(
          onChanged: onChanged,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
              size: 36,
            ),
            hintText: '検索',
            hintStyle: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
