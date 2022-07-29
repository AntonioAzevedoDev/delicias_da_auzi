import 'package:flutter/material.dart';

import '../../config/custom_colors.dart';

class AppNameWidget extends StatelessWidget {
  final Color? purpleTitleColor;
  final double textSize;

  AppNameWidget({Key? key, this.purpleTitleColor,this.textSize = 30}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
        style: TextStyle(
          fontSize: textSize,
        ),
        children: [
          TextSpan(
              text: 'Delicias da ',
              style: TextStyle(
                color:purpleTitleColor ?? CustomColors.customSwatchColor,
              )),
          TextSpan(
              text: 'Auzi',
              style: TextStyle(color:purpleTitleColor ?? CustomColors.customSwatchColor,fontWeight: FontWeight.bold)),
        ])
    );
  }
}
