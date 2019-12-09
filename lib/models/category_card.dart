import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gets_it_done/models/task_card.dart';
import 'package:gets_it_done/models/user.dart';
import 'package:gets_it_done/services/database.dart';
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

  @override
  void initState() {
    super.initState();
    print(widget.category);
    Future.delayed(Duration.zero, () {
      _user = Provider.of<User>(context);
      setTasksByCategory(_user.uid, widget.category);
    });
  }

  void setTasksByCategory(uid, category) async {
    _db = DatabaseCalls();
    dynamic tasks = await _db.getTasksByCategory(uid, category);
    print(tasks);
    setState(() {
      data = tasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic key = widget.category;

    listData() {
      if (data.length == 0)
        return ['No Tasks for this category. Great job!']
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
                  },
                  child: TaskCard(task: item),
                ))
            .toList();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ButtonTheme(
          minWidth: MediaQuery.of(context).size.width * 0.90,
          padding: EdgeInsets.all(12.0),
          child: RaisedButton(
            color: Colors.pink[300],
            onPressed: () {
              setState(() {
                clicked = !clicked;
              });
            },
            child: Text(
              widget.category,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Column(
          children: clicked ? listData() : [],
        )
      ],
    );
  }
}
