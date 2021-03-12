import 'package:favorite/constants.dart';
import 'package:favorite/model/product.dart';
import 'package:flutter/material.dart';

import 'album_card.dart';
import 'category_list.dart';
import 'search_box.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBox(),
        CategoryList(),
        SizedBox(
          height: kDefaultPadding / 2,
        ),
        Expanded(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 70),
                decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
              ),
              ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) => AlbumCard(
                  itemIndex: index,
                  product: products[index],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
