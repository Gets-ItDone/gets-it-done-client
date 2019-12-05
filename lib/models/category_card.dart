import 'package:flutter/material.dart';
import 'package:gets_it_done/models/tasks_by_category.dart';

class CategoryCard extends StatefulWidget {
  final String category;
  CategoryCard({this.category});
  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool clicked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ButtonTheme(
          minWidth: MediaQuery.of(context).size.width * 0.80,
          child: RaisedButton(
            color: Colors.pink[300],
            onPressed: () {
              setState(() {
                clicked = !clicked;
                print(clicked);
              });
            },
            child: Text(
              widget.category,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Column(
          children: <Widget>[TasksByCategory()],
          // children: clicked ? <List>[TasksByCategory] : [],
        )
      ],
    );
  }
}
