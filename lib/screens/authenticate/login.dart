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
              title: Text('Gets It Done'),
              centerTitle: true,
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formKey,
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
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: RaisedButton(
                            color: Colors.blue[500],
                            onPressed: () async {
                              print(email);
                              print(password);
                              if (_formKey.currentState.validate()) {
                                setState(() => loading = true);

                                dynamic loginResult =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);

                                if (loginResult == null) {
                                  setState(
                                    () {
                                      loading = false;
                                      err =
                                          'Something went wrong. Please try again.';
                                    },
                                  );
                                }
                              }
                            },
                            child: Text('Login'),
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
                          'Not yet getting it done?',
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: FlatButton(
                            color: Colors.blue[200],
                            child: Text('Register'),
                            onPressed: () {
                              widget.toggleView();
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
