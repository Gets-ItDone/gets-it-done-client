import 'package:flutter/material.dart';
import 'package:gets_it_done/models/user.dart';
import 'package:gets_it_done/screens/task_screens/tasks_complete.dart';
import 'package:gets_it_done/services/database.dart';
import 'package:gets_it_done/shared/loading.dart';
import 'package:provider/provider.dart';

class TaskViewer extends StatefulWidget {
  @override
  _TaskViewerState createState() => _TaskViewerState();
}

class _TaskViewerState extends State<TaskViewer> {
  DatabaseCalls _db;
  dynamic _user;
  dynamic tasks = [];
  bool isLoading = true;
  dynamic colorScheme = '';

  final bgColor = const Color(0xFFb4c2f3);
  final textColor = const Color(0xFFffffff);
  final altBgColor = const Color(0xFFe96dae);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _user = Provider.of<User>(context);
      setTasks(_user.uid);
      getUserPreferences(_user);
    });
  }

  getUserPreferences(user) async {
    _db = DatabaseCalls();
    dynamic preferences = await _db.getPreferences(user.uid);

    setState(() {
      colorScheme = preferences["colorScheme"];
    });
  }

  void setTasks(uid) async {
    _db = DatabaseCalls();
    dynamic taskArray = await _db.getAllTasksWithCategories(uid);
    setState(() {
      tasks = taskArray;
      isLoading = false;
    });
  }

  void getAllTasksWithCategories(uid) async {
    _db = DatabaseCalls();
    dynamic arrayOfObjects = await _db.getAllTasksWithCategories(uid);
    print(arrayOfObjects);
  }

  void completeTask(uid, category, task) async {
    // print(uid);
    // print(category);
    // print(task);
    _db = DatabaseCalls();
    _db.completeTask(uid, category, task);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : SafeArea(
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage("assets/images/bgimg$colorScheme.jpg"),
                        fit: BoxFit.cover)),
                child: Column(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.topRight,
                        child: Container(
                            margin: EdgeInsets.all(20),
                            child: RaisedButton(
                                padding: EdgeInsets.all(10),
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/home', (_) => false);
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
                                child: Text(tasks[0]["taskName"],
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
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TasksComplete()),
                                    );
                                  } else
                                    setState(() {
                                      this.tasks.removeAt(0);
                                    });

                                  completeTask(_user.uid, tasks[0]["category"],
                                      tasks[0]["taskName"]);

                                  // make database call to 'complete' task
                                  // shift task from task array and display new task[0]
                                  // if the list is empty, navigate to (congratulations page? then to) home
                                },
                                padding: EdgeInsets.all(20),
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(50.0),
                                ),
                                color: altBgColor.withOpacity(0.5),
                                child: Text("Done",
                                    style: TextStyle(fontSize: 100)))))
                  ],
                )));
  }
}
