import 'package:flutter/material.dart';
import 'package:gets_it_done/models/user.dart';
import 'package:gets_it_done/screens/task_screens/categoryadder.dart';
import 'package:gets_it_done/screens/task_screens/task_list.dart';
import 'package:gets_it_done/screens/task_screens/taskadder.dart';
import 'package:gets_it_done/screens/task_screens/taskviewer.dart';
import 'package:gets_it_done/services/auth.dart';
import 'package:gets_it_done/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:gets_it_done/services/database.dart';
import 'package:gets_it_done/shared/color_theme.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  dynamic _user;
  final AuthService _auth = AuthService();
  DatabaseCalls _db;
  dynamic pref;

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

  dynamic colorScheme = '';
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Theme(
            data: getColorTheme(colorScheme) ?? Theme.of(context),
            child: Scaffold(
              appBar: AppBar(
                title: Text('Gets It Done'),
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                        ),
                        padding: EdgeInsets.all(30.0),
                        child: Text('Add Task'),
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/add', (_) => false);
                        },
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                        ),
                        padding: EdgeInsets.all(30.0),
                        child: Text('View Tasks'),
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/view', (_) => false);
                        },
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                        ),
                        padding: EdgeInsets.all(30.0),
                        child: Text('Start Tasks'),
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/do', (_) => false);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );

  }
}
