import 'package:flutter/material.dart';
import 'package:gets_it_done/models/user.dart';
import 'package:gets_it_done/screens/home/home.dart';
import 'package:gets_it_done/screens/home/settings.dart';
import 'package:gets_it_done/screens/task_screens/categoryadder.dart';
import 'package:gets_it_done/services/auth.dart';
import 'package:gets_it_done/shared/color_theme.dart';
import 'package:gets_it_done/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:gets_it_done/services/database.dart';

class TaskAdder extends StatefulWidget {
  @override
  _TaskAdderState createState() => _TaskAdderState();
}

class _TaskAdderState extends State<TaskAdder> {
  dynamic _user;
  DatabaseCalls _db;
  // Speech to Text
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;
  // dynamic textInput;
  String resultText = '';

  String err = "";

  @override
  void initState() {
    super.initState();
    initSpeechRecognitizer();

    Future.delayed(Duration.zero, () {
      _user = Provider.of<User>(context);
      setCategories(_user);
      getUserPreferences(_user);
    });
  }

  void setCategories(user) async {
    _db = DatabaseCalls();

    dynamic categories = await _db.getCategories(user.uid);
    setState(() {
      _categories = categories;
      _isLoading = false;
    });
  }

  getUserPreferences(user) async {
    _db = DatabaseCalls();
    dynamic preferences = await _db.getPreferences(user.uid);

    print(["PREFS", preferences]);

    setState(() {
      colorScheme = preferences["colorScheme"];
      speechToText = preferences["speechToText"];
    });
  }

  void initSpeechRecognitizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
      (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
      () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
      (String speech) {
        resultText = speech;
      },
    );

    _speechRecognition.setRecognitionCompleteHandler(
      () => setState(() => _isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
        );

    setState(() => _isAvailable = false);
  }

  // Bottom nav bar navigation
  void _navigatePage(int index) {
    setState(() {
      if (index == 0) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
      }
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CategoryAdder()),
        );
      }
      if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Settings()),
        );
      }
    });
  }

  // Inputs
  // String taskBody;
  String priority = "today";
  String categoryDropdown = "general";
  String message = "";
  dynamic dueDate;

  // Color Scheme
  dynamic colorScheme = '';
  dynamic speechToText = true;

  // Categories
  List<dynamic> _categories;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return _isLoading
        ? Loading()
        : Theme(
            data: getColorTheme(colorScheme) ?? ThemeData.dark(),
            child: Scaffold(
              appBar: AppBar(
                title: Text('Gets It Done'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Log Off'),
                    onPressed: () async {
                      await _auth.logOffUser();
                    },
                  )
                ],
              ),
              body: Form(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50.0,
                    ),
                    TextFormField(
                      controller: new TextEditingController.fromValue(
                          new TextEditingValue(
                              text: resultText,
                              selection: new TextSelection.collapsed(
                                  offset: resultText.length))),
                      onChanged: (text) {
                        setState(() {
                          resultText = text;
                        });
                      },
                      style: TextStyle(
                        fontSize: 20,
                        color: getColorTheme(colorScheme).primaryColor,
                      ),
                      decoration: InputDecoration(
                          labelText: 'Task',
                          hintText: 'Add a task here!',
                          fillColor: Colors.white,
                          filled: true),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    speechToText
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FloatingActionButton(
                                heroTag: 'stop',
                                mini: true,
                                onPressed: () {
                                  if (_isListening) {
                                    _speechRecognition.stop().then(
                                          (result) => setState(
                                              () => _isListening = result),
                                        );
                                  }
                                },
                                backgroundColor:
                                    getColorTheme(colorScheme).accentColor,
                                child: Icon(Icons.stop),
                              ),
                              FloatingActionButton(
                                heroTag: 'record',
                                onPressed: () {
                                  if (_isAvailable && !_isListening) {
                                    _speechRecognition
                                        .listen(locale: "en_US")
                                        .then((result) => print(result));
                                  }
                                },
                                backgroundColor:
                                    getColorTheme(colorScheme).primaryColor,
                                child: Icon(Icons.mic),
                              ),
                            ],
                          )
                        : Text("Enable 'Speech To Text' to use the microphone"),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text("Priority"),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                            onPressed: () {
                              setState(() {
                                priority = "today";
                                // Add 24 hours to current time
                                dynamic timestamp = new DateTime.now()
                                    .add(new Duration(days: 1))
                                    .millisecondsSinceEpoch;
                                dueDate = timestamp;
                              });
                            },
                            color: priority == "today"
                                ? Colors.black
                                : getColorTheme(colorScheme).primaryColor,
                            child: Text("Today")),
                        RaisedButton(
                            onPressed: () {
                              setState(() {
                                priority = "tomorrow";
                                // Add 48 hours to current time
                                dynamic timestamp = new DateTime.now()
                                    .add(new Duration(days: 2))
                                    .millisecondsSinceEpoch;
                                dueDate = timestamp;
                              });
                            },
                            color: priority == "tomorrow"
                                ? Colors.black
                                : getColorTheme(colorScheme).primaryColor,
                            child: Text("Tomorrow")),
                        RaisedButton(
                            onPressed: () {
                              setState(() {
                                priority = "later";
                                // Add 7 days to task
                                dynamic timestamp = new DateTime.now()
                                    .add(new Duration(days: 7))
                                    .millisecondsSinceEpoch;
                                dueDate = timestamp;
                                // print(timestamp + 604800000);
                              });
                            },
                            color: priority == "later"
                                ? Colors.black
                                : getColorTheme(colorScheme).primaryColor,
                            child: Text("Later"))
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Text("Category"),
                    SizedBox(
                      height: 20.0,
                    ),
                    DropdownButton<String>(
                      value: categoryDropdown.length == 0
                          ? "Please select text"
                          : categoryDropdown,
                      isExpanded: false,
                      underline: Container(
                        height: 2,
                        color: Colors.black,
                      ),
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      onChanged: (String newValue) {
                        setState(() {
                          categoryDropdown = newValue;
                          // print(categoryDropdown);
                        });
                      },
                      items: _categories
                          .map<DropdownMenuItem<String>>((dynamic value) {
                        return DropdownMenuItem<String>(
                            child: Text(value), value: value);
                      }).toList(),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    RaisedButton(
                        onPressed: () async {
                          if (resultText != "") {
                            _db.addTask(
                                _user.uid, categoryDropdown, resultText);

                            setState(() {
                              err = "Task added";
                            });
                            Future.delayed(Duration(milliseconds: 800), () {
                              setState(() {
                                err = "";
                                resultText = "";
                              });
                            });
                            // setState(() {
                            //   err = "";
                            //   resultText = "";
                            // });
                          } else {
                            setState(() {
                              err = "Please enter a task";
                            });
                          }

                          //Navigator.pop(context);
                        },
                        child: Text("Submit")),
                    Text(
                      err,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: new Theme(
                data: Theme.of(context).copyWith(
                  // sets the background color of the `BottomNavigationBar`
                  canvasColor: getColorTheme(colorScheme).primaryColor,
                  // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                  primaryColor: Colors.red,
                  textTheme: Theme.of(context).textTheme.copyWith(
                        caption: new TextStyle(
                          color: Colors.white,
                        ),
                      ),
                ),
                child: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Home',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.add),
                      title: Text('Category'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      title: Text('Settings'),
                    ),
                  ],
                  onTap: _navigatePage,
                ),
              ),
            ),
          );
  }
}
