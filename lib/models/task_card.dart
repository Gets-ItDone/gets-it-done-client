import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String task;
  TaskCard({this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        child: ListTile(
          leading: CircleAvatar(
            child: ClipOval(
              child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/9/9f/Poop_Emoji_Icon.png'),
            ),
          ),
          title: Center(child: Text(task)),
        ),
      ),
    );
  }
}
