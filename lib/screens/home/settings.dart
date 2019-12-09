import 'package:flutter/material.dart';
import 'package:gets_it_done/models/user.dart';
import 'package:gets_it_done/services/auth.dart';
import 'package:gets_it_done/services/database.dart';
import 'package:gets_it_done/shared/loading.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  dynamic user;
  DatabaseCalls _db;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      user = Provider.of<User>(context);
      setPreferences(user);
      _isLoading = false;
    });
  }

  void setPreferences(user) async {
    _db = DatabaseCalls();
    dynamic preferences = await _db.getPreferences(user.uid);

    setState(() {
      colorScheme = preferences["colorScheme"];
      speechToText = preferences["speechToText"];
      taskAssistant = preferences["taskAssistant"];
    });
  }

  final bgColor = const Color(0xFFb4c2f3);
  final textColor = const Color(0xFFffffff);
  final altBgColor = const Color(0xFFe96dae);

  // Inputs
  // int fontSizeValue = 2;
  dynamic colorScheme = '';
  bool speechToText;
  bool taskAssistant;
  // Loading page
  bool _isLoading = true;
  // Error handling
  String message = '';

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return _isLoading
        ? Loading()
        : Scaffold(
            backgroundColor: bgColor,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: altBgColor,
              actions: <Widget>[
                FlatButton(
                    onPressed: () async {
                      await _auth.logOffUser();
                    },
                    child: Icon(
                      Icons.close,
                      color: textColor,
                    )),
              ],
              title: Text('Settings'),
            ),
            body: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                  ),
                  // Text(
                  //   'Font Size',
                  //   style: TextStyle(
                  //     fontSize: 20.0,
                  //     color: textColor,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(5.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: List.generate(5, (index) => Text("${index + 1}")),
                  //   ),
                  // ),
                  // Slider(
                  //   value: fontSizeValue.toDouble(),
                  //   activeColor: altBgColor,
                  //   inactiveColor: textColor,
                  //   min: 0.0,
                  //   max: 5.0,
                  //   divisions: 5,
                  //   onChanged: (value) =>
                  //       setState(() => fontSizeValue = value.round()),
                  // ),
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  Text(
                    'Color Scheme',
                    style: TextStyle(color: textColor, fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          setState(() {
                            colorScheme = '1';
                          });
                        },
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(50.0),
                        ),
                        color: colorScheme == '1' ? Colors.black : altBgColor,
                        elevation: 0.0,
                        child: Text(
                          '1',
                          style: TextStyle(color: textColor),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          setState(() {
                            colorScheme = '2';
                          });
                        },
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(50.0),
                        ),
                        color: colorScheme == '2'
                            ? Colors.black
                            : Colors.teal[300],
                        elevation: 0.0,
                        child: Text(
                          '2',
                          style: TextStyle(color: Colors.blue[800]),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          setState(() {
                            colorScheme = '3';
                          });
                        },
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(50.0),
                        ),
                        color: colorScheme == '3'
                            ? Colors.black
                            : Colors.deepOrangeAccent[100],
                        elevation: 0.0,
                        child: Text(
                          '3',
                          style: TextStyle(color: Colors.yellow[300]),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          setState(() {
                            colorScheme = '4';
                          });
                        },
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(50.0),
                        ),
                        color: colorScheme == '4'
                            ? Colors.black
                            : Colors.deepPurple,
                        elevation: 0.0,
                        child: Text(
                          '4',
                          style: TextStyle(color: Colors.green[200]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Speech to text',
                    style: TextStyle(color: textColor, fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 150.0,
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              speechToText = true;
                            });
                          },
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(50.0),
                          ),
                          color:
                              speechToText == true ? Colors.black : altBgColor,
                          elevation: 0.0,
                          child: Text(
                            'On',
                            style: TextStyle(color: textColor),
                          ),
                        ),
                      ),
                      ButtonTheme(
                        minWidth: 150.0,
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              speechToText = false;
                            });
                          },
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(50.0),
                          ),
                          color:
                              speechToText == false ? Colors.black : altBgColor,
                          elevation: 0.0,
                          child: Text(
                            'Off',
                            style: TextStyle(color: textColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Task assistant',
                    style: TextStyle(color: textColor, fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 150.0,
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              taskAssistant = true;
                            });
                          },
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(50.0),
                          ),
                          color:
                              taskAssistant == true ? Colors.black : altBgColor,
                          elevation: 0.0,
                          child: Text(
                            'On',
                            style: TextStyle(color: textColor),
                          ),
                        ),
                      ),
                      ButtonTheme(
                        minWidth: 150.0,
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              taskAssistant = false;
                            });
                          },
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(50.0),
                          ),
                          color: taskAssistant == false
                              ? Colors.black
                              : altBgColor,
                          elevation: 0.0,
                          child: Text(
                            'Off',
                            style: TextStyle(color: textColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  ButtonTheme(
                    minWidth: 250.0,
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        final result = _db.updatePreferences(
                            user.uid, colorScheme, speechToText, taskAssistant);

                        if (result["status"] == 200) {
                          setState(() {
                            message = 'Preferences updated successful';
                          });

                          Future.delayed(Duration(milliseconds: 800), () {
                            Navigator.pop(context);
                          });
                        }
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(50.0),
                      ),
                      color: altBgColor,
                      elevation: 2.0,
                      child: Text(
                        'Finish',
                        style: TextStyle(color: textColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    message,
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                ],
              ),
            ),
          );
  }
}
