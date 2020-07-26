import 'package:flutter_driver/driver_extension.dart';
import 'package:hotel/screens/authenticate/sign_in.dart' ;
import 'package:flutter/material.dart';


void main(){
  enableFlutterDriverExtension();
  MaterialApp(home: SignIn());
}
