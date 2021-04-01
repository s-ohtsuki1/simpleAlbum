import 'package:favorite/size_config.dart';
import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    required this.text,
    required this.image,
  });
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Text(
          text,
          textAlign: TextAlign.center,
        ),
        Spacer(),
        Image.asset(
          image,
          height: getProportionateScreenHeight(265),
          width: getProportionateScreenWidth(235),
        ),
      ],
    );
  }
}
