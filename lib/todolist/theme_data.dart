import 'package:flutter/material.dart';

class Themes {

  static ThemeData light = ThemeData(
    fontFamily: 'Nunito',
    brightness: Brightness.light,
    primaryColor: Color(0xff81c784
    ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xff81c784
  )),
  );
  static ThemeData dark = ThemeData(
    fontFamily: 'Nunito',
    brightness: Brightness.dark,
    primaryColor: Color(0xff8349eb),
    backgroundColor: Color(0xff130528),
    cardColor: Color(0xff424242), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xff8349eb)),
  );
}
