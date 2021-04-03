import 'package:favorite/size_config.dart';
import 'package:flutter/material.dart';

class SocalCard extends StatelessWidget {
  const SocalCard({
    required this.icon,
    required this.press,
  });

  final String icon;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
        padding: EdgeInsets.all(getProportionateScreenWidth(12)),
        width: getProportionateScreenWidth(200),
        child: Image.asset(icon),
      ),
    );
  }
}
