import 'package:flutter/material.dart';
import 'package:gets_it_done/models/user.dart';
import 'package:gets_it_done/screens/task_screens/task_list.dart';
import 'package:gets_it_done/screens/task_screens/taskadder.dart';
import 'package:gets_it_done/screens/task_screens/taskviewer.dart';
import 'package:gets_it_done/services/auth.dart';
import 'package:gets_it_done/services/database.dart';
import 'package:provider/provider.dart';

// class Home extends StatelessWidget {
//   final bgColor = const Color(0xFFb4c2f3);
//   final textColor = const Color(0xFFffffff);
//   final altBgColor = const Color(0xFFe96dae);

//   @override
//   Widget build(BuildContext context) {
//     final AuthService _auth = AuthService();
//     final DatabaseCalls _db = DatabaseCalls();
//     final user = Provider.of<User>(context);

//     print(user.uid);

//     fetchPrefs() async {
//       print(user.uid);
//       final prefs = await _db.getPreferences(user.uid);
//       return prefs;
//     }

//     final preferences = fetchPrefs();

//     print(preferences);

//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Gets It Done'),
//           backgroundColor: altBgColor,
//           actions: <Widget>[
//             FlatButton(
//               child: Text(
//                 'Log Off',
//                 style: TextStyle(color: textColor, fontSize: 18.0),
//               ),
//               onPressed: () async {
//                 print('Sign out');
//                 await _auth.logOffUser();
//               },
//             )
//           ],
//         ),
//         body: Container(
//             color: bgColor,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 Container(
//                   margin:
//                       EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                   child: RaisedButton(
//                     padding: EdgeInsets.all(40.0),
//                     color: altBgColor,
//                     child: Text(
//                       'Add Task',
//                       style: TextStyle(
//                         color: textColor,
//                       ),
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => TaskAdder()),
//                       );
//                     },
//                   ),
//                 ),
//                 Container(
//                   margin:
//                       EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                   child: RaisedButton(
//                     padding: EdgeInsets.all(40.0),
//                     color: altBgColor,
//                     child: Text(
//                       'View Tasks',
//                       style: TextStyle(
//                         color: textColor,
//                       ),
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => TaskList()),
//                       );
//                     },
//                   ),
//                 ),
//                 Container(
//                   margin:
//                       EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                   child: RaisedButton(
//                     padding: EdgeInsets.all(40.0),
//                     color: altBgColor,
//                     child: Text(
//                       'Start Tasks',
//                       style: TextStyle(
//                         color: textColor,
//                       ),
//                     ),
//                     onPressed: () {},
//                   ),
//                 )
//               ],
//             ),),);
//   }
// }

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final bgColor = const Color(0xFFb4c2f3);
  final textColor = const Color(0xFFffffff);
  final altBgColor = const Color(0xFFe96dae);
  final AuthService _auth = AuthService();
  final DatabaseCalls _db = DatabaseCalls();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
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
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: RaisedButton(
                padding: EdgeInsets.all(40.0),
                color: altBgColor,
                child: Text(
                  'Add Task',
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TaskAdder()),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: RaisedButton(
                padding: EdgeInsets.all(40.0),
                color: altBgColor,
                child: Text(
                  'View Tasks',
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TaskList()),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: RaisedButton(
                padding: EdgeInsets.all(40.0),
                color: altBgColor,
                child: Text(
                  'Start Tasks',
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TaskViewer()),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
