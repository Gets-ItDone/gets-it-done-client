import 'package:flutter/material.dart';

getColorTheme(colorScheme) {
  // BLUE AND YELLOW DYSLEXIA FRIENDLY
  if (colorScheme == '1') {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      accentColor: Colors.blueAccent[400],
      scaffoldBackgroundColor: Colors.yellow[100],
      backgroundColor: Colors.blue,
      buttonColor: Colors.blueAccent[400],
      bottomAppBarColor: Colors.blue,
      hintColor: Colors.blue[800],
      fontFamily: 'Roboto',
    );
  }

  // MONOCHROME THEME
  if (colorScheme == '2') {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      accentColor: Colors.grey[700],
      scaffoldBackgroundColor: Colors.grey,
      backgroundColor: Colors.grey,
      buttonColor: Colors.black,
      bottomAppBarColor: Colors.black,
      hintColor: Colors.black,
      fontFamily: 'Roboto',
    );
  }

  // // DARK MODE
  if (colorScheme == '3') {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.purple[900],
      accentColor: Colors.blueAccent[400],
      scaffoldBackgroundColor: Colors.blue[1000],
      backgroundColor: Colors.blue,
      buttonColor: Colors.blue[900],
      bottomAppBarColor: Colors.purple[900],
      hintColor: Colors.black,
      fontFamily: 'Roboto',
    );
  }

  // LIGHT MODE
  if (colorScheme == '4') {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.orange[300],
      accentColor: Colors.yellow[500],
      scaffoldBackgroundColor: Colors.yellow[50],
      backgroundColor: Colors.blue,
      buttonColor: Colors.blue[200],
      bottomAppBarColor: Colors.purple[900],
      hintColor: Colors.blue,
      fontFamily: 'Roboto',
    );
  }
  // HACKER MODE
  if (colorScheme == '5') {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Color(0xff003b00),
      accentColor: Color(0xff003b00),
      scaffoldBackgroundColor: Color(0xff0D0208),
      backgroundColor: Color(0xff0D0208),
      buttonColor: Color(0xff003b00),
      bottomAppBarColor: Color(0xff003b00),
      hintColor: Color(0xff003b00),
      fontFamily: 'Roboto',
    );
  }
}
