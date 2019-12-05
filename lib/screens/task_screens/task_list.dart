import 'package:flutter/material.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final categories = ['General', 'Household', 'Health'];
  final generalTasks = ['Eat', 'Sleep', 'Code'];
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    dynamic tasks = generalTasks.map((task) => Text(task)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Master List'),
        backgroundColor: Colors.pink[300],
      ),
      body: Container(
        color: Colors.blue[200],
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];

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
                      category,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Column(
                  children: clicked ? tasks : [],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
