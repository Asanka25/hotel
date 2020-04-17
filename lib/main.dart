import 'package:hotel/models/user/user.dart';
import 'package:hotel/screens/kitchen/test45.dart';
// import 'package:hotel/screens/kitchen/test.dart';
import 'package:hotel/screens/wrapper.dart';
import 'package:hotel/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(initialRoute: '/', routes: {
        '/': (context) => Wrapper(),
        // '/test': (context) => Kitchen(),
      }),
    );
   
  }
}
