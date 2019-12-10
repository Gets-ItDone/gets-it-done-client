import 'package:flutter/material.dart';
import 'package:gets_it_done/services/auth.dart';
import 'package:gets_it_done/services/database.dart';
import 'package:gets_it_done/shared/color_theme.dart';
import 'package:gets_it_done/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:gets_it_done/models/user.dart';

class TaskAssistant extends StatefulWidget {
  @override
  _TaskAssistantState createState() => _TaskAssistantState();
}

class _TaskAssistantState extends State<TaskAssistant> {
  dynamic _user;
  final AuthService _auth = AuthService();
  DatabaseCalls _db;
  dynamic colorScheme = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _user = Provider.of<User>(context);

      setState(() {
        getUserPreferences(_user);
        isLoading = false;
      });
    });
  }

  getUserPreferences(user) async {
    _db = DatabaseCalls();
    dynamic preferences = await _db.getPreferences(user.uid);

    setState(() {
      colorScheme = preferences["colorScheme"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Theme(
            data: getColorTheme(colorScheme) ?? Theme.of(context),
            child: Scaffold(
              appBar: AppBar(
                title: Text('Task Assistant'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Log Off'),
                    onPressed: () async {
                      await _auth.logOffUser();
                    },
                  )
                ],
              ),
              body: Container(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[Text("hello")],
                ),
              ),
            ),
          );
  }
}
