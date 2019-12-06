import 'package:flutter/material.dart';
import 'package:gets_it_done/services/auth.dart';
import 'package:speech_recognition/speech_recognition.dart';

class TaskAdder extends StatefulWidget {
  @override
  _TaskAdderState createState() => _TaskAdderState();
}

class _TaskAdderState extends State<TaskAdder> {
  // Speech to Text
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;
  String resultText = '';

  @override
  void initState() {
    super.initState();
    initSpeechRecognitizer();
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
      (String speech) => setState(() => resultText = speech),
    );

    _speechRecognition.setRecognitionCompleteHandler(
      () => setState(() => _isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
        );
  }

  // Inputs
  String taskBody;
  String priority = "today";
  String categoryDropdown = "general";

  // Color Scheme
  final bgColor = const Color(0xFFb4c2f3);
  final textColor = const Color(0xFFffffff);
  final altBgColor = const Color(0xFFe96dae);

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    return Scaffold(
        appBar: AppBar(
          title: Text('Gets It Done'),
          backgroundColor: altBgColor,
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Log Off',
                style: TextStyle(color: textColor, fontSize: 18.0),
              ),
              onPressed: () async {
                await _auth.logOffUser();
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
            TextFormField(
              onChanged: (text) {
                setState(() {
                  taskBody = text;
                  print(taskBody);
                });
              },
              style: TextStyle(
                fontSize: 20,
              ),
              validator: (value) =>
                  value.isEmpty ? 'Please write your task.' : null,
              decoration: InputDecoration(
                  labelText: 'Task',
                  hintText: 'Please enter task.',
                  fillColor: Colors.white,
                  filled: true),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: 'stop',
                  mini: true,
                  backgroundColor: altBgColor,
                  onPressed: () {
                    if (_isListening) {
                      _speechRecognition.stop().then(
                            (result) => setState(() => _isListening = result),
                          );
                    }
                  },
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
                  child: Icon(Icons.mic),
                ),
              ],
            ),
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
                // RaisedButton(
                //   onPressed: () {},
                //   child: Text("click"),
                // ),

                RaisedButton(
                    onPressed: () {
                      setState(() {
                        priority = "today";
                        print(priority);
                      });
                    },
                    color: priority == "today" ? altBgColor : Colors.white,
                    child: Text("Today")),
                RaisedButton(
                    onPressed: () {
                      setState(() {
                        priority = "tomorrow";
                        print(priority);
                      });
                    },
                    color: priority == "tomorrow" ? altBgColor : Colors.white,
                    child: Text("Tomorrow")),
                RaisedButton(
                    onPressed: () {
                      setState(() {
                        priority = "later";
                        print(priority);
                      });
                    },
                    color: priority == "later" ? altBgColor : Colors.white,
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
                color: altBgColor,
              ),
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              onChanged: (String newValue) {
                setState(() {
                  categoryDropdown = newValue;
                  print(categoryDropdown);
                });
              },
              items: <String>["general", "work", "school", "life"]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    child: Text(value), value: value);
              }).toList(),
            ),
            SizedBox(
              height: 30.0,
            ),
            RaisedButton(
                onPressed: () {
                  // on pressed needs to send task to database and redirect to created task
                },
                color: altBgColor,
                child: Text("Submit"))
          ],
        )));
  }
}
