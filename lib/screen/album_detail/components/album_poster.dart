import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class AlbumPoster extends StatelessWidget {
  const AlbumPoster({
    Key key,
    this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
      height: SizeConfig.screenWidth * 0.8,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: SizeConfig.screenWidth * 0.7,
            width: SizeConfig.screenWidth * 0.7,
            decoration: BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              image,
              height: SizeConfig.screenWidth * 0.75,
              width: SizeConfig.screenWidth * 0.75,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
