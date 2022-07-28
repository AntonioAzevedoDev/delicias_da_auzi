import 'package:flutter/material.dart';

Map<int, Color> _swatchOpacity = {
  50: const Color.fromRGBO(171, 71, 188, .1),
  100: const Color.fromRGBO(171, 71, 188, .2),
  200: const Color.fromRGBO(171, 71, 188, .3),
  300: const Color.fromRGBO(171, 71, 188, .4),
  400: const Color.fromRGBO(171, 71, 188, .5),
  500: const Color.fromRGBO(171, 71, 188, .6),
  600: const Color.fromRGBO(171, 71, 188, .7),
  700: const Color.fromRGBO(171, 71, 188, .8),
  800: const Color.fromRGBO(171, 71, 188, .9),
  900: const Color.fromRGBO(171, 71, 188, 1),
};
abstract class CustomColors{
  static Color customConstratColor = Colors.red.shade700;
  
  static MaterialColor customSwatchColor = MaterialColor(0xFFAB47BC, _swatchOpacity);
}