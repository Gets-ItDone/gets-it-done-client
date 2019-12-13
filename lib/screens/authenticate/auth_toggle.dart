import 'package:flutter/material.dart';
import 'package:gets_it_done/screens/authenticate/login.dart';
import 'package:gets_it_done/screens/authenticate/sign_up.dart';

class AuthToggle extends StatefulWidget {
  @override
  _AuthToggleState createState() => _AuthToggleState();
}

class _AuthToggleState extends State<AuthToggle> {
  bool showSignUp = false;

  void toggleView() {
    setState(() => showSignUp = !showSignUp);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: showSignUp
          ? SignUp(toggleView: toggleView)
          : Login(toggleView: toggleView),
    );
  }
}
