import 'package:flutter/material.dart';

class TasksComplete extends StatelessWidget {
  final bgColor = const Color(0xFFb4c2f3);
  final textColor = const Color(0xFFffffff);
  final altBgColor = const Color(0xFFe96dae);
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
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            padding: EdgeInsets.all(20),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(50.0),
                            ),
                            color: altBgColor.withOpacity(0.5),
                            child: Text("Woohoo",
                                style: TextStyle(fontSize: 50)))))
              ],
            )));
  }
}
