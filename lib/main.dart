import 'package:flutter/material.dart';
import 'package:gets_it_done/models/user.dart';
import 'package:gets_it_done/screens/wrapper.dart';
import 'package:gets_it_done/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
          theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.green[600],
            accentColor: Colors.greenAccent[400],
            scaffoldBackgroundColor: Colors.black,
            backgroundColor: Colors.black,
            buttonColor: Colors.green[600],
            bottomAppBarColor: Colors.green[600],
            hintColor: Colors.green[600],
            fontFamily: 'Roboto',
          ),
          home: Wrapper()),
    );
  }
}
