import 'package:flutter/material.dart';
import 'package:gets_it_done/services/auth.dart';


class Home extends StatelessWidget {
  final bgColor = const Color(0xFFb4c2f3);
  final textColor = const Color(0xFFffffff);
  final altBgColor = const Color(0xFFe96dae);

  @override
  Widget build(BuildContext context) {
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
                print('Sign out');
                await _auth.logOffUser();
              },
            )
          ],

        ),
        body: Container(
            color: bgColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: RaisedButton(
                    padding: EdgeInsets.all(40.0),
                    color: altBgColor,
                    child: Text(
                      'Add Task',
                      style: TextStyle(
                        color: textColor,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: RaisedButton(
                    padding: EdgeInsets.all(40.0),
                    color: altBgColor,
                    child: Text(
                      'View Tasks',
                      style: TextStyle(
                        color: textColor,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: RaisedButton(
                    padding: EdgeInsets.all(40.0),
                    color: altBgColor,
                    child: Text(
                      'Start Tasks',
                      style: TextStyle(
                        color: textColor,
                      ),
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            )));
  }
}
