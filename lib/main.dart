import 'package:hotel/models/user/user.dart';
import 'package:hotel/screens/kitchen/KitchenDashboard.dart';
import 'package:hotel/screens/order_manager/orderManagerDashboard.dart';
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,initialRoute: '/', routes: {
        '/': (context) => Wrapper(),
        '/kitchenDashboard': (context) => KitchenDashboardScreen(),
        '/orderManagerDashboard': (context) => OrderManagerDashboardScreen(),


        // '/test': (context) => Kitchen(),
      }),
    );
   
  }
}
