import 'package:delicias_da_auzi/src/config/custom_colors.dart';
import 'package:flutter/material.dart';
import '../commom_widgets/app_name_widget.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        decoration:  BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors:[
                CustomColors.customSwatchColor,
                CustomColors.customSwatchColor.shade700,
              ]
          )
        ),
        child:  Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppNameWidget(
              purpleTitleColor: Colors.white,
              textSize: 40,
            ),
            const SizedBox(height: 10,),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
