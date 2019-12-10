import 'package:flutter/material.dart';
import 'package:gets_it_done/models/user.dart';
import 'package:gets_it_done/screens/home/home.dart';
import 'package:gets_it_done/screens/home/settings.dart';
import 'package:gets_it_done/screens/task_screens/taskadder.dart';
import 'package:gets_it_done/services/auth.dart';
import 'package:gets_it_done/services/database.dart';
import 'package:gets_it_done/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:gets_it_done/shared/color_theme.dart';

class CategoryAdder extends StatefulWidget {
  @override
  _CategoryAdderState createState() => _CategoryAdderState();
}

class _CategoryAdderState extends State<CategoryAdder> {
  // Speech to Text
  dynamic _user;
  DatabaseCalls _db;
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;
  String resultText = '';
  bool _isLoading = true;

  // Color Scheme
  dynamic colorScheme = '';

  // Bottom nav bar navigation
  void _navigatePage(int index) {
    setState(() {
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TaskAdder()),
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

  // Color Scheme
  final bgColor = const Color(0xFFb4c2f3);
  final textColor = const Color(0xFFffffff);
  final altBgColor = const Color(0xFFe96dae);

  //initSpeechRecognitizer function
  void initSpeechRecognitizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
      (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
      () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
      (String speech) => setState(() => resultText = speech),
    );

    _speechRecognition.setRecognitionCompleteHandler(
      () => setState(() => _isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
        );
  }

  getUserPreferences(user) async {
    _db = DatabaseCalls();
    dynamic preferences = await _db.getPreferences(user.uid);

    setState(() {
      _isLoading = false;
      colorScheme = preferences["colorScheme"];
    });
  }

  final myController = TextEditingController();

  //initState
  @override
  void initState() {
    super.initState();
    initSpeechRecognitizer();

    myController.addListener(_setTextState);

    Future.delayed(Duration.zero, () {
      _user = Provider.of<User>(context);
      getUserPreferences(_user);
    });
  }

  _setTextState() {
    // print("Second text field: ${myController.text}");
    setState(() {
      resultText = myController.text;
      print(resultText);
    });
  }

  @override
  Widget build(BuildContext context) {
    DatabaseCalls _db = DatabaseCalls();
    dynamic _user = Provider.of<User>(context);
    final AuthService _auth = AuthService();

    return _isLoading
        ? Loading()
        : Theme(
            data: getColorTheme(colorScheme) ?? ThemeData.dark(),
            child: Scaffold(
              appBar: AppBar(
                title: Text('Gets It Done'),
                backgroundColor: altBgColor,
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      'Log off',
                      style: TextStyle(color: textColor, fontSize: 18.0),
                    ),
                    onPressed: () async {
                      await _auth.logOffUser();
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              backgroundColor: bgColor,
              body: Form(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50.0,
                    ),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          // controller: TextEditingController(text: resultText),
                          controller: new TextEditingController.fromValue(
                              new TextEditingValue(
                                  text: resultText,
                                  selection: new TextSelection.collapsed(
                                      offset: resultText.length))),
                          onChanged: (text) {
                            setState(() {
                              resultText = text;
                              print(resultText);
                            });
                          },
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          validator: (value) => value.isEmpty
                              ? 'Please write the name of your category.'
                              : null,
                          decoration: InputDecoration(
                              labelText: 'Category',
                              hintText: 'Please enter category.',
                              fillColor: Colors.white,
                              filled: true),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FloatingActionButton(
                          heroTag: 'stop',
                          mini: true,
                          onPressed: () {
                            if (_isListening) {
                              _speechRecognition.stop().then(
                                    (result) =>
                                        setState(() => _isListening = result),
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
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    RaisedButton(
                        onPressed: () async {
                          _db.addCategory(_user.uid, resultText);
                          Navigator.pop(context);
                        },
                        color: altBgColor,
                        child: Text("Submit")),
                    // Text(message)
                  ],
                ),
              ),
              bottomNavigationBar: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.pink[300],
                  primaryColor: Colors.white,
                  textTheme: Theme.of(context).textTheme.copyWith(
                        caption: new TextStyle(color: Colors.white),
                      ),
                ),
                child: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      title: Text('Home'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.add),
                      title: Text('Task'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      title: Text('Settings'),
                    ),
                  ],
                  onTap: _navigatePage,
                ),
              ),
            ));
  }
}
