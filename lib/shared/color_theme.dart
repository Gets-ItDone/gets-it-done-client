import 'package:flutter/material.dart';

getColorTheme(colorScheme) {
  if (colorScheme == '1') {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.green[600],
      accentColor: Colors.greenAccent[400],
      scaffoldBackgroundColor: Colors.black,
      backgroundColor: Colors.black,
      buttonColor: Colors.green[600],
      bottomAppBarColor: Colors.green[600],
      hintColor: Colors.green[600],
      fontFamily: 'Roboto',
    );
  }

  if (colorScheme == '2') {
    return ThemeData(
      backgroundColor: Colors.red,
    );
  }

  if (colorScheme == '3') {
    return ThemeData(
      backgroundColor: Colors.red,
    );
  }

  if (colorScheme == '4') {
    return ThemeData(
      backgroundColor: Colors.red,
    );
  }
}
