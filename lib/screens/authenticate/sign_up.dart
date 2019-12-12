import 'package:flutter/material.dart';
import 'package:gets_it_done/services/auth.dart';
import 'package:gets_it_done/shared/loading.dart';
import 'package:gets_it_done/services/database.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // db setup
  DatabaseCalls _db = DatabaseCalls();

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // Text fields
  String email = '';
  String password = '';
  String passwordConfirm = '';
  String err = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('Gets It Done'),
              centerTitle: true,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/loginlogo.png',
                    fit: BoxFit.scaleDown,
                    height: 150.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
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
                          height: 10.0,
                        ),
                        TextFormField(
                          obscureText: true,
                          validator: (value) => value.isEmpty
                              ? 'Please input your password.'
                              : null,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Please enter password.',
                              fillColor: Colors.white,
                              filled: true),
                          onChanged: (value) {
                            setState(() => password = value);
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          obscureText: true,
                          validator: (value) => value.isEmpty
                              ? 'Please re-enter your password.'
                              : null,
                          decoration: InputDecoration(
                              labelText: 'Confirm password',
                              hintText: 'Please re-enter password.',
                              fillColor: Colors.white,
                              filled: true),
                          onChanged: (value) {
                            setState(() => passwordConfirm = value);
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: RaisedButton(
                            color: Colors.blue[900],
                            onPressed: () async {
                              if (password != passwordConfirm) {
                                setState(() => err = 'Passwords do not match');
                              } else if (_formKey.currentState.validate()) {
                                setState(() => loading = true);
                                final signUpResult =
                                    await _auth.registerWithEmailAndPassword(
                                        email, password);

                                if (signUpResult != null) {
                                  _db.createUser(signUpResult.uid);
                                }

                                if (signUpResult == null) {
                                  setState(() {
                                    err = 'Please enter a valid email';
                                    loading = false;
                                  });
                                }
                              }
                            },
                            child: Text('Register'),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          err,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Already getting it done?',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: FlatButton(
                            color: Colors.purple[900],
                            child: Text('Login'),
                            onPressed: () {
                              widget.toggleView();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
