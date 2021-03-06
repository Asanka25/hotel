import 'package:hotel/services/auth.dart';
import 'package:hotel/shades/constants.dart';
import 'package:hotel/shades/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Enter email' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.length < 6 ? 'Enter password 6 chars long' : null;
  }
}

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = " ";
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.red),
              backgroundColor: Colors.white,
              // elevation: 0.0,
              // backgroundColor: Colors.transparent,
              elevation: 1.5,
              title: Align(
                child: Text(
                  'Sign In to Pearl',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person,color: Colors.blueAccent,),
                  label: Text('Register',
                  style: TextStyle(color: Colors.blue),),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Email'),
                          validator: (val) => EmailFieldValidator.validate(val),
                          onChanged: (val) {
                            setState(() => email = val);
                          }),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'password'),
                        validator: (val) =>
                            PasswordFieldValidator.validate(val),
                        obscureText: true,
                        onChanged: (val) => password = val,
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = "Couldn't sign in";
                                loading = false;
                              });
                            }
                            print("sign in done");
                          }
                        },
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        '$error',
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
