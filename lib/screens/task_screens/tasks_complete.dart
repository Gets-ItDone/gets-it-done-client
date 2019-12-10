import 'package:flutter/material.dart';
import 'package:gets_it_done/models/user.dart';
import 'package:gets_it_done/services/database.dart';
import 'package:gets_it_done/shared/loading.dart';
import 'package:provider/provider.dart';

class TasksComplete extends StatefulWidget {
  @override
  _TasksCompleteState createState() => _TasksCompleteState();
}

class _TasksCompleteState extends State<TasksComplete> {
  final bgColor = const Color(0xFFb4c2f3);
  final textColor = const Color(0xFFffffff);
  final altBgColor = const Color(0xFFe96dae);

  DatabaseCalls _db;
  dynamic _user;
  bool isLoading = true;
  dynamic colorScheme = '';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _user = Provider.of<User>(context);
      getUserPreferences(_user);
      isLoading = false;
    });
  }

  getUserPreferences(user) async {
    _db = DatabaseCalls();
    dynamic preferences = await _db.getPreferences(user.uid);

    setState(() {
      colorScheme = preferences["colorScheme"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/bgimg$colorScheme.jpg"),
                      fit: BoxFit.cover)),
              // color: bgColor,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Material(
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          padding: EdgeInsets.all(30),
                          margin: EdgeInsets.all(30),
                          child: Center(
                              child: Text("All tasks complete!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))),
                          width: MediaQuery.of(context).size.width * 0.8,
                        )),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          margin: EdgeInsets.all(30),
                          child: RaisedButton(
                              onPressed: () {
                                Future.delayed(
                                  Duration(milliseconds: 400),
                                  () {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, '/home', (_) => false);
                                  },
                                );
                              },
                              padding: EdgeInsets.all(20),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(50.0),
                              ),
                              color: altBgColor.withOpacity(0.5),
                              child:
                                  Text("OK", style: TextStyle(fontSize: 50)))))
                ],
              ),
            ),
          );
  }
}
