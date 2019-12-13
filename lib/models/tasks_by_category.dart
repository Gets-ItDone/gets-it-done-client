import 'package:flutter/material.dart';

class TasksByCategory extends StatefulWidget {
  @override
  _TasksByCategoryState createState() => _TasksByCategoryState();
}

class _TasksByCategoryState extends State<TasksByCategory> {
  final tasks = ["Task one", "Task two"];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];

        return ListTile(title: Text(task));
      },
    );
  }
}
