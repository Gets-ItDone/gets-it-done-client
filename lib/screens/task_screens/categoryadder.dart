import 'package:flutter/material.dart';
import 'package:gets_it_done/models/user.dart';
import 'package:gets_it_done/screens/home/settings.dart';
import 'package:gets_it_done/services/auth.dart';
import 'package:gets_it_done/services/database.dart';
import 'package:provider/provider.dart';

class CategoryAdder extends StatefulWidget {
  @override
  _CategoryAdderState createState() => _CategoryAdderState();
}

class _CategoryAdderState extends State<CategoryAdder> {
  // Bottom nav bar navigation
  void _navigatePage(int index) {
    setState(() {
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Settings()),
        );
      }
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Settings()),
        );
      }
    });
  }

  // Inputs
  // String taskBody;
  String categoryName = "";

  // Color Scheme
  final bgColor = const Color(0xFFb4c2f3);
  final textColor = const Color(0xFFffffff);
  final altBgColor = const Color(0xFFe96dae);

  @override
  Widget build(BuildContext context) {
    DatabaseCalls _db = DatabaseCalls();
    dynamic _user = Provider.of<User>(context);
    final AuthService _auth = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Gets It Done'),
        backgroundColor: altBgColor,
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Log Off',
              style: TextStyle(color: textColor, fontSize: 18.0),
            ),
            onPressed: () async {
              await _auth.logOffUser();
              Navigator.pop(context);
            },
          )
        ],
      ),
      backgroundColor: bgColor,
      body: Form(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  controller: TextEditingController(text: categoryName),
                  onChanged: (text) {
                    setState(() {
                      categoryName = text;
                      print(categoryName);
                    });
                  },
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  validator: (value) => value.isEmpty
                      ? 'Please write the name of your category.'
                      : null,
                  decoration: InputDecoration(
                      labelText: 'Category',
                      hintText: 'Please enter category.',
                      fillColor: Colors.white,
                      filled: true),
                ),
              ),
            ),

            SizedBox(
              height: 30.0,
            ),
            RaisedButton(
                onPressed: () async {
                  _db.addCategory(_user.uid, categoryName);
                  Navigator.pop(context);
                },
                color: altBgColor,
                child: Text("Submit")),
            // Text(message)
          ],
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
