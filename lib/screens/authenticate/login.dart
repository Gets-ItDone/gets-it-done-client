import 'package:flutter/material.dart';
import 'package:gets_it_done/services/auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String err = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.face),
            onPressed: () {},
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              validator: (value) =>
                  value.isEmpty ? 'Please input your email.' : null,
              decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Please enter email.',
                  fillColor: Colors.white,
                  filled: true),
              onChanged: (value) {
                setState(() => email = value);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              obscureText: true,
              validator: (value) =>
                  value.isEmpty ? 'Please input your password.' : null,
              decoration: InputDecoration(
                  labelText: 'password',
                  hintText: 'Please enter password.',
                  fillColor: Colors.white,
                  filled: true),
              onChanged: (value) {
                setState(() => password = value);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  dynamic loginResult =
                      await _auth.signInWithEmailAndPassword(email, password);
                  print(loginResult);
                  if (loginResult == null) {
                    setState(
                        () => err = 'Something went wrong. Please try again.');
                  }
                }
              },
              color: Colors.blue,
              child: Text('Login',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              err,
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            )
          ],
        ),
      ),
    );
  }
}
