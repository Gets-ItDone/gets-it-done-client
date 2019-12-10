import 'package:flutter/material.dart';
import 'package:gets_it_done/models/user.dart';
import 'package:gets_it_done/screens/task_screens/task_list.dart';
import 'package:gets_it_done/screens/wrapper.dart';
import 'package:gets_it_done/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:gets_it_done/screens/home/home.dart';
import 'package:gets_it_done/screens/home/settings.dart';
import 'package:gets_it_done/screens/task_screens/taskadder.dart';

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
          // Added to change text color if required.
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.black,
                displayColor: Colors.blue,
              ),
        ),
        routes: {
          '/': (context) => Wrapper(),
          '/home': (context) => Home(),
          '/settings': (context) => Settings(),
          '/add': (context) => TaskAdder(),
          '/view': (context) => TaskList(),
        },
      ),
    );
  }
}
