import 'package:flutter/material.dart';
import 'package:gets_it_done/services/auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // Text fields
  String email = '';
  String password = '';
  String passwordConfirm = '';
  String err = '';

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
            TextFormField(
              obscureText: true,
              validator: (value) =>
                  value.isEmpty ? 'Please re-enter your password.' : null,
              decoration: InputDecoration(
                  labelText: 'password',
                  hintText: 'Please re-enter password.',
                  fillColor: Colors.white,
                  filled: true),
              onChanged: (value) {
                setState(() => passwordConfirm = value);
              },
            ),
            RaisedButton(
              onPressed: () async {
                if (password != passwordConfirm) {
                  setState(() => err = 'Passwords do not match');
                } else if (_formKey.currentState.validate()) {
                  dynamic signUpResult =
                      await _auth.registerWithEmailAndPassword(email, password);

                  if (signUpResult == null) {
                    setState(() => err = 'Please enter a valid email');
                  }
                }
              },
              color: Colors.blue,
              child: Text('Register',
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
