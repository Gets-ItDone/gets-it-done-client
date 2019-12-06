import 'package:flutter/material.dart';
import 'package:gets_it_done/shared/loading.dart';

class TaskViewer extends StatefulWidget {
  @override
  _TaskViewerState createState() => _TaskViewerState();
}

class _TaskViewerState extends State<TaskViewer> {
  // bool loading = false;

  final bgColor = const Color(0xFFb4c2f3);
  final textColor = const Color(0xFFffffff);
  final altBgColor = const Color(0xFFe96dae);

  List<String> tasks = ["I am a task", "I am another, much longer task"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            color: bgColor,
            child: Column(
              children: <Widget>[
                Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        margin: EdgeInsets.all(30),
                        child: RaisedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: altBgColor,
                            child: Text("Cancel",
                                style: TextStyle(fontSize: 20))))),
                Expanded(
                  child: Material(
                      child: Container(
                    margin: EdgeInsets.all(30),
                    child: Text(tasks[1],
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                            backgroundColor: Colors.white)),
                    width: MediaQuery.of(context).size.width * 0.65,
                  )),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        margin: EdgeInsets.all(50),
                        child: RaisedButton(
                            onPressed: () {
                              // make database call to complete task
                              // move onto next task in task array
                              // if the list is empty, navigate to home
                            },
                            color: altBgColor,
                            child:
                                Text("Done", style: TextStyle(fontSize: 100)))))
              ],
            )));
  }
}
