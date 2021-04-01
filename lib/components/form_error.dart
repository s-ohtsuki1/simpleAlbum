import 'package:favorite/size_config.dart';
import 'package:flutter/material.dart';

class FormError extends StatelessWidget {
  const FormError({required this.errors});

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors.length, (index) => formErrorText(error: errors[index])),
    );
  }

  Row formErrorText({required String error}) {
    return Row(
      children: [
        Icon(
          Icons.error_outline,
          color: Colors.pink,
        ),
        SizedBox(
          width: getProportionateScreenWidth(10),
        ),
        Text(error),
      ],
    );
  }
}
