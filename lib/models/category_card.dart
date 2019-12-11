import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gets_it_done/models/task_card.dart';
import 'package:gets_it_done/models/user.dart';
import 'package:gets_it_done/services/database.dart';
import 'package:gets_it_done/shared/color_theme.dart';
import 'package:gets_it_done/shared/loading.dart';
import 'package:provider/provider.dart';

class CategoryCard extends StatefulWidget {
  final String category;
  CategoryCard({this.category});

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool clicked = false;
  DatabaseCalls _db;
  dynamic _user;
  dynamic data = [];
  dynamic colorScheme = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    print(widget.category);
    Future.delayed(Duration.zero, () {
      _user = Provider.of<User>(context);
      setTasksByCategory(_user.uid, widget.category);
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

  void setTasksByCategory(uid, category) async {
    _db = DatabaseCalls();
    dynamic tasks = await _db.getTasksByCategory(uid, category);

    setState(() {
      data = tasks;
    });
  }

  void completeTask(uid, category, task) async {
    print(uid);
    print(category);
    _db = DatabaseCalls();
    _db.completeTask(uid, category, task);
  }

  @override
  Widget build(BuildContext context) {
    listData() {
      if (data.length == 0)
        return ['No tasks for this category. Great job!']
            .map<Widget>((item) => TaskCard(task: item))
            .toList();
      else {
        return data
            .map<Widget>((item) => Dismissible(
                  key: Key(item),
                  onDismissed: (direction) {
                    final index = data.indexOf(item);
                    // Remove the item from the data source.
                    setState(() {
                      // Need to also remove from DB. Do opti-rendering
                      data.removeAt(index);
                    });
                    completeTask(_user.uid, widget.category, item);
                  },
                  child: TaskCard(task: item),
                ))
            .toList();
      }
    }

    return _isLoading
        ? Loading()
        : Theme(
            data: getColorTheme(colorScheme) ?? Theme.of(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width * 0.90,
                      padding: EdgeInsets.all(12.0),
                      child: RaisedButton(
                        onPressed: () {
                          setState(
                            () {
                              clicked = !clicked;
                            },
                          );
                        },
                        child: Text(
                          widget.category,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    )),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: Column(
                      children: clicked ? listData() : [],
                    ))
              ],
            ),
          );
  }
}
