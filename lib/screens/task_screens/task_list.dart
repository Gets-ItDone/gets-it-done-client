import 'package:flutter/material.dart';
import 'package:gets_it_done/models/category_card.dart';
import 'package:gets_it_done/models/user.dart';
import 'package:gets_it_done/screens/task_screens/categoryadder.dart';
import 'package:gets_it_done/screens/task_screens/taskadder.dart';
import 'package:gets_it_done/services/auth.dart';
import 'package:gets_it_done/services/database.dart';
import 'package:gets_it_done/shared/color_theme.dart';
import 'package:gets_it_done/shared/loading.dart';
import 'package:provider/provider.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final AuthService _auth = AuthService();
  DatabaseCalls _db;
  dynamic _user;
  dynamic categories = [];
  bool clicked = false;
  bool _isLoading = true;
  dynamic colorScheme = '';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _user = Provider.of<User>(context);
      setCategories(_user.uid);
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

  void setCategories(uid) async {
    _db = DatabaseCalls();
    dynamic categoryArray = await _db.getCategories(uid);
    setState(() {
      categories = categoryArray;
    });
  }

  // Bottom nav bar navigation
  void _navigatePage(int index) {
    setState(() {
      if (index == 0) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
      }
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TaskAdder()),
        );
      }

      if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CategoryAdder()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
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
                      dynamic result = await _auth.logOffUser();

                      if (result != null) {
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
              body: Container(
                padding: EdgeInsets.fromLTRB(0, 40.0, 0, 40.0),
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];

                    return CategoryCard(category: category);
                  },
                ),
              ),
              bottomNavigationBar: new Theme(
                data: Theme.of(context).copyWith(
                  // sets the background color of the `BottomNavigationBar`
                  canvasColor: getColorTheme(colorScheme).primaryColor,
                  // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                  primaryColor: Colors.red,
                  textTheme: Theme.of(context).textTheme.copyWith(
                        caption: new TextStyle(
                          color: Colors.white,
                        ),
                      ),
                ),
                child: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Home',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.add),
                      title: Text('Task'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.add),
                      title: Text('Category'),
                    ),
                  ],
                  onTap: _navigatePage,
                ),
              ),
            ),
          );
  }
}
