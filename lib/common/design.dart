import 'package:flutter/material.dart';

ThemeData defaultTheme = new ThemeData (
  primarySwatch: Colors.orange,
  floatingActionButtonTheme: FloatingActionButtonThemeData (backgroundColor: Colors.deepOrange),
  dividerTheme: DividerThemeData(
    color: Colors.black,
    indent: 10,
    endIndent: 10,
    space: 20,
    thickness: 2,
  ),

);

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}

