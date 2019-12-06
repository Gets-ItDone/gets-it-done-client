import 'package:flutter/material.dart';
import 'package:gets_it_done/services/auth.dart';
import 'package:gets_it_done/shared/loading.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  Login({this.toggleView});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String err = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('Login'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Register',
                      style: TextStyle(color: Colors.white, fontSize: 18.0)),
                  onPressed: () {
                    widget.toggleView();
                  },
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
                        setState(() => loading = true);

                        dynamic loginResult = await _auth
                            .signInWithEmailAndPassword(email, password);

                        if (loginResult == null) {
                          setState(() {
                            loading = false;
                            err = 'Something went wrong. Please try again.';
                          });
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
