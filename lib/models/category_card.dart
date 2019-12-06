import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gets_it_done/models/task_card.dart';

class CategoryCard extends StatefulWidget {
  final String category;
  CategoryCard({this.category});

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool clicked = false;

  // Do call to DB here.
  // Store data in object like below
  dynamic data = {
    "General": ['Eat lunch', 'Complete 3 Katas on CodeWars'],
    "Household": ['Clean bathroom'],
    "Health": ["Go to doctor"],
    "Life or Death": []
  };

  @override
  Widget build(BuildContext context) {
    dynamic key = widget.category;

    listData() {
      if (data[key].length == 0)
        return ['No Tasks for this category. Great job!']
            .map<Widget>((item) => TaskCard(task: item))
            .toList();
      else {
        return data[key]
            .map<Widget>((item) => Dismissible(
                  key: Key(item),
                  onDismissed: (direction) {
                    final index = data[key].indexOf(item);
                    // Remove the item from the data source.
                    setState(() {
                      // Need to also remove from DB. Do opti-rendering
                      data[key].removeAt(index);
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
