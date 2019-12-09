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
      brightness: Brightness.dark,
      primaryColor: Colors.red[600],
      accentColor: Colors.redAccent[400],
      scaffoldBackgroundColor: Colors.yellow[600],
      backgroundColor: Colors.yellow[600],
      buttonColor: Colors.red[600],
      bottomAppBarColor: Colors.yellow[600],
      hintColor: Colors.red[600],
      fontFamily: 'Roboto',
    );
  }

  if (colorScheme == '3') {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.pink[400],
      accentColor: Colors.pinkAccent[400],
      scaffoldBackgroundColor: Colors.purple[300],
      backgroundColor: Colors.purple[300],
      buttonColor: Colors.pink[400],
      bottomAppBarColor: Colors.pink[400],
      hintColor: Colors.purple[300],
      fontFamily: 'Roboto',
    );
  }

  if (colorScheme == '4') {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.white,
      accentColor: Colors.blue,
      scaffoldBackgroundColor: Colors.blue[300],
      backgroundColor: Colors.blue[300],
      buttonColor: Colors.blue[900],
      bottomAppBarColor: Colors.white,
      hintColor: Colors.blue[300],
      fontFamily: 'Roboto',
    );
  }
}
