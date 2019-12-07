import 'package:flutter/material.dart';
import 'package:gets_it_done/screens/task_screens/tasks_complete.dart';
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

  List<String> tasks = [
    "I am a task",
    "I am another, much longer task",
    "Here is yet one more task",
    "Attempting to access this task through the TaskViewer"
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/bgimg1.jpg"),
                    fit: BoxFit.cover)),
            // color: bgColor,
            child: Column(
              children: <Widget>[
                Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        margin: EdgeInsets.all(20),
                        child: RaisedButton(
                            padding: EdgeInsets.all(10),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                            color: altBgColor.withOpacity(0.5),
                            child: Text("Cancel",
                                style: TextStyle(fontSize: 20))))),
                Expanded(
                  child: Material(
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0))),
                        padding: EdgeInsets.all(30),
                        child: Center(
                            child: Text(tasks[0],
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
                              if (this.tasks.length == 1) {
                                // Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TasksComplete()),
                                );
                              } else
                                setState(() {
                                  this.tasks.removeAt(0);
                                });
                              // make database call to 'complete' task
                              // shift task from task array and display new task[0]
                              // if the list is empty, navigate to (congratulations page? then to) home
                            },
                            padding: EdgeInsets.all(20),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(50.0),
                            ),
                            color: altBgColor.withOpacity(0.5),
                            child:
                                Text("Done", style: TextStyle(fontSize: 100)))))
              ],
            )));
  }
}
