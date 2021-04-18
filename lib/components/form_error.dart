import 'package:favorite/size_config.dart';
import 'package:flutter/material.dart';

import '../firebase_auth_error.dart';

class FormError extends StatelessWidget {
  const FormError({this.errorCode});

  final String? errorCode;

  @override
  Widget build(BuildContext context) {
    return errorCode!.isNotEmpty
        ? Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.pink,
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(5),
                  ),
                  Text(FirebaseAuthError.convErrorMessage(errorCode)),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
            ],
          )
        : SizedBox();
  }
}
