import 'package:flutter/material.dart';
import 'package:gets_it_done/services/auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
              height: 40.0,
            ),
            TextFormField(
              validator: (value) =>
                  value.isEmpty ? 'Please input your email.' : null,
              decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Please enter email.',
                  fillColor: Colors.white,
                  filled: true),
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
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              obscureText: true,
              validator: (value) =>
                  value.isEmpty ? 'Please re-enter your password.' : null,
              decoration: InputDecoration(
                  labelText: 'password',
                  hintText: 'Please re-enter password.',
                  fillColor: Colors.white,
                  filled: true),
            ),
            RaisedButton(
              onPressed: () async {
                await _auth.registerWithEmailAndPassword(
                    'Me@you.com', 'password');
              },
              color: Colors.blue,
              child: Text('Register',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
