import 'package:flutter/material.dart';
import 'package:gets_it_done/models/category_card.dart';
import 'package:gets_it_done/screens/home/settings.dart';
import 'package:gets_it_done/screens/task_screens/taskadder.dart';
import 'package:gets_it_done/services/auth.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  //Call to DB and save data into array
  final categories = ['General', 'Household', 'Health', 'Life or Death'];
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    void _navigatePage(int index) {
      setState(() {
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskAdder()),
          );
        }
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Settings()),
          );
        }
        if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Settings()),
          );
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Master List'),
        backgroundColor: Colors.pink[300],
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Log Off',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            onPressed: () async {
              print('Sign out');
              await _auth.logOffUser();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 40.0, 0, 40.0),
        color: Colors.blue[200],
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];

            return CategoryCard(category: category);
          },
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.pink[300],
          primaryColor: Colors.white,
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: new TextStyle(color: Colors.white),
              ),
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              title: Text('Add Task'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.done),
              title: Text('Do Task'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
          onTap: _navigatePage,
        ),
      ),
    );
  }
}
