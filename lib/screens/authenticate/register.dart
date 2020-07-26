import 'package:hotel/services/auth.dart';
import 'package:hotel/shades/constants.dart';
import 'package:hotel/shades/loading.dart';
import 'package:flutter/material.dart';

class NameFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Enter name' : null;
  }
}

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

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  final List<String> userType = ['Vwaiter', 'Order Manager', 'Manager', "Chef"];

  String email = '';
  String name = '';
  String type = 'Vwaiter';
  String password = '';
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1.5,
              title: Text('Sign Up to Pearl crew'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person, color: Colors.blueAccent),
                  label: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Name'),
                          validator: (val) => NameFieldValidator.validate(val),
                          onChanged: (val) {
                            setState(() => name = val);
                          }),
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
                      DropdownButtonFormField(
                        decoration: textInputDecoration,
                        value: type,
                        items: userType.map((userType) {
                          return DropdownMenuItem(
                            value: userType,
                            child: Text(userType),
                          );
                        }).toList(),
                        onChanged: (value) => setState(() => type = value),
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            // print(email);
                            // print(password);
                            // print(type);

                            dynamic result =
                                await _auth.registerWithEmailAndPassword(
                                    email, password, name, type);
                            if (result == null) {
                              setState(() {
                                error = 'please enter valid email';
                                loading = false;
                                print("regiter incomplete!!");
                              });
                            }
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
