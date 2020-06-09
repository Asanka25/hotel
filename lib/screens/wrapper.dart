import 'package:flutter/foundation.dart';
import 'package:hotel/models/user/user.dart';
import 'package:hotel/screens/authenticate/authenticate.dart';
import 'package:hotel/screens/kitchen/kitchenDashboard.dart';
// import 'package:hotel/screens/kitchen/edit_menu.dart';
import 'package:hotel/screens/kitchen/menu.dart';
import 'package:flutter/material.dart';
import 'package:hotel/screens/order_manager/orderManagerDashboard.dart';

import 'package:hotel/screens/order_manager/order_manager_home.dart';

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
 
     if (userdata.type == "Order Manager") {
      setState(() {
        widgt = OrderManagerDashboardScreen();
      });
    
    } else if (userdata.type == "Chef") {
      setState(() {
        // widgt = Kitchen();
        widgt = KitchenDashboardScreen();
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
