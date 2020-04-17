import 'package:flutter/foundation.dart';
import 'package:hotel/models/user/user.dart';
import 'package:hotel/screens/authenticate/authenticate.dart';
import 'package:hotel/screens/kitchen/dashboard.dart';
// import 'package:hotel/screens/kitchen/edit_menu.dart';
import 'package:hotel/screens/kitchen/test45.dart';
import 'package:flutter/material.dart';

import 'package:hotel/screens/order_manager/order_manager_home.dart';
import 'package:hotel/screens/virtual_waiter/vwaiter_home.dart';
import 'package:hotel/services/database.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Widget widgt;

  getUserType(User user) async {
    UserData userdata = await DatabaseService(uid: user.uid).getUserData();
    // print(userdata.type);
    if (userdata.type == "Vwaiter") {
      setState(() {
        // widgt = VwaiterHome();
      });
    } else if (userdata.type == "Order Manager") {
      setState(() {
        widgt = OrderManagerHome();
      });
    } else if (userdata.type == "Manager") {
      setState(() {
        // widgt = Manager();
      });
    } else if (userdata.type == "Chef") {
      setState(() {
        // widgt = Kitchen();
        widgt = DashboardScreen();
      });
    }
  }

  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // print(user);
    if (user == null)
      return Authenticate();
    else
      getUserType(user);
    return widgt;
  }
}
