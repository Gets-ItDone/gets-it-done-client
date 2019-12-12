import 'package:flutter/material.dart';
import 'package:gets_it_done/services/auth.dart';
import 'package:gets_it_done/services/database.dart';
import 'package:gets_it_done/shared/color_theme.dart';
import 'package:gets_it_done/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:gets_it_done/models/user.dart';

class TaskAssistant extends StatefulWidget {
  @override
  _TaskAssistantState createState() => _TaskAssistantState();
}

class _TaskAssistantState extends State<TaskAssistant> {
  PageController _pageController;
  dynamic _user;
  final AuthService _auth = AuthService();
  DatabaseCalls _db;
  dynamic colorScheme = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    Future.delayed(Duration.zero, () {
      _user = Provider.of<User>(context);

      setState(() {
        getUserPreferences(_user);
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  getUserPreferences(user) async {
    _db = DatabaseCalls();
    dynamic preferences = await _db.getPreferences(user.uid);

    setState(() {
      colorScheme = preferences["colorScheme"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Theme(
            data: getColorTheme(colorScheme) ?? Theme.of(context),
            child: Scaffold(
              appBar: AppBar(
                title: Text('Task Assistant'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Log Off'),
                    onPressed: () async {
                      await _auth.logOffUser();
                    },
                  )
                ],
              ),
              body: PageView(
                controller: _pageController,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(40),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "By breaking your tasks down into the smallest steps possible, you can focus on putting one foot in front of the other rather than thinking about the miles ahead of you!",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30),
                        RaisedButton(
                          onPressed: () {
                            if (_pageController.hasClients) {
                              _pageController.animateToPage(1,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut);
                            }
                          },
                          child: Text("Next"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(40),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "How long can you fully focus on something before getting distracted? If it’s half an hour, break your tasks up into half hour chunks. If it’s ten minutes, or five minutes, break your tasks up into chunks of that size.",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                              onPressed: () {
                                if (_pageController.hasClients) {
                                  _pageController.animateToPage(0,
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.easeInOut);
                                }
                              },
                              child: Text("Previous"),
                            ),
                            RaisedButton(
                              onPressed: () {
                                if (_pageController.hasClients) {
                                  _pageController.animateToPage(2,
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.easeInOut);
                                }
                              },
                              child: Text("Next"),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(40),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "For example, instead of ‘tidy room’, how about ‘hang up washing’, ‘rearrange bookshelf’, and’ change sheets’?",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                              onPressed: () {
                                if (_pageController.hasClients) {
                                  _pageController.animateToPage(1,
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.easeInOut);
                                }
                              },
                              child: Text("Previous"),
                            ),
                            RaisedButton(
                              onPressed: () {
                                if (_pageController.hasClients) {
                                  _pageController.animateToPage(3,
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.easeInOut);
                                }
                              },
                              child: Text("Next"),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(40),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Or, if you’re really struggling, small goals like ‘pick 10 things up off the floor’ or ‘fold three shirts’ will help you achieve something small with the time you have.",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                              onPressed: () {
                                if (_pageController.hasClients) {
                                  _pageController.animateToPage(2,
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.easeInOut);
                                }
                              },
                              child: Text("Previous"),
                            ),
                            RaisedButton(
                              onPressed: () {
                                if (_pageController.hasClients) {
                                  _pageController.animateToPage(4,
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.easeInOut);
                                }
                              },
                              child: Text("Next"),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(40),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Remember to reward yourself for your successes, however small!",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30),
                        RaisedButton(
                          onPressed: () {
                            if (_pageController.hasClients) {
                              _pageController.animateToPage(3,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut);
                            }
                          },
                          child: Text("Previous"),
                        ),
                        RaisedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Back to task"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
