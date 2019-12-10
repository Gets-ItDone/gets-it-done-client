import 'package:flutter/material.dart';
import 'package:gets_it_done/models/user.dart';
import 'package:gets_it_done/services/database.dart';
import 'package:gets_it_done/shared/color_theme.dart';
import 'package:gets_it_done/shared/loading.dart';
import 'package:provider/provider.dart';

class TaskCard extends StatefulWidget {
  final String task;
  TaskCard({this.task});

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  DatabaseCalls _db;
  dynamic _user;
  dynamic colorScheme = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _user = Provider.of<User>(context);
      getUserPreferences(_user);
      _isLoading = false;
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
    return _isLoading
        ? Loading()
        : Theme(
            data: getColorTheme(colorScheme) ?? ThemeData.dark(),
            child: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Card(
                color: getColorTheme(colorScheme).accentColor,
                margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
                child: ListTile(
                  leading: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/9/9f/Poop_Emoji_Icon.png'),
                    ),
                  ),
                  title: Center(child: Text(widget.task)),
                ),
              ),
            ),
          );
  }
}
