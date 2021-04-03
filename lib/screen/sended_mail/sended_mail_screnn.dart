import 'package:flutter/material.dart';

import '../../size_config.dart';
import 'components/body.dart';

class SendedMailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
