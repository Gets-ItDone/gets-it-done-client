import 'package:flutter/material.dart';
import 'package:gets_it_done/models/user.dart';
import 'package:gets_it_done/screens/task_screens/categoryadder.dart';
import 'package:gets_it_done/screens/task_screens/task_list.dart';
import 'package:gets_it_done/screens/task_screens/taskviewer.dart';
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
          primaryColor: Colors.purple[900],
          accentColor: Colors.blueAccent[400],
          scaffoldBackgroundColor: Colors.blue[1000],
          backgroundColor: Colors.blue,
          buttonColor: Colors.blue[900],
          bottomAppBarColor: Colors.purple[900],
          hintColor: Colors.black,
          fontFamily: 'Montserrat',

          // Added to change text color if required.
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.black,
                displayColor: Colors.black,
              ),
        ),
        routes: {
          '/': (context) => Wrapper(),
          '/home': (context) => Home(),
          '/settings': (context) => Settings(),
          '/add': (context) => TaskAdder(),
          '/start': (context) => TaskViewer(),
          '/addcategory': (context) => CategoryAdder(),
          '/view': (context) => TaskList(),
          '/do': (context) => TaskViewer(),
        },
      ),
    );
  }
}
