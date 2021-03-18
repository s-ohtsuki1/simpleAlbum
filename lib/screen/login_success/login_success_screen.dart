import 'package:favorite/screen/login_success/components/body.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';

class LoginSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(body: Body());
  }
}
