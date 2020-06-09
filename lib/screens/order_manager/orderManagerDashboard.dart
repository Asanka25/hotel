import 'package:flutter/material.dart';
import 'package:hotel/screens/kitchen/kitchen_orders.dart';
import 'package:hotel/screens/kitchen/menu.dart';
import 'package:hotel/screens/order_manager/editTable.dart';
import 'package:hotel/screens/order_manager/myProgress.dart';
import 'package:hotel/screens/order_manager/oMcalendar.dart';
import 'package:hotel/screens/order_manager/order_manager_home.dart';
import 'package:hotel/services/kitchen_database.dart';
import 'package:hotel/services/auth.dart';
import 'package:hotel/services/orderManager_database.dart';

class OrderManagerDashboardScreen extends StatelessWidget {
  const OrderManagerDashboardScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Order Manager Home',
            style: TextStyle(
                color: Colors.blueAccent, fontWeight: FontWeight.w600),
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<int>(
            icon: Icon(
              Icons.more_vert,
              color: Colors.blue,
            ),
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<int>>[
                PopupMenuItem(
                  value: 0,
                  child: FlatButton.icon(
                    icon: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    label: Text('Logout', style: TextStyle(color: Colors.blue)),
                    onPressed: () async {
                      await _auth.signOut();
                    },
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white70,
        child: Column(
          children: <Widget>[
            //My progress
            Container(
              height: 240,
              width: 350,
              child: GestureDetector(
                onTap: () async {
                  var count = await OrderManagerDatabase().progressCount();
                  print(count);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyProgress(count:count)
                              ));
                },
                child: Card(
                  elevation: 40,
                  color: Colors.grey[50],
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Text("My progress",
                          style: TextStyle(
                              color: Colors.blueAccent, fontSize: 25)),
                      SizedBox(height: 30),
                      Image.asset(
                        'assets/kitchen/chart.png',
                        scale: 1.8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 150,
              width: 350,
              child: GestureDetector(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderManagerHome()));
                },
                child: Card(
                  elevation: 40,
                  color: Colors.grey[50],
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15.0, 26, 8, 10),
                            child: Text("Table View",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 25)),
                          ),
                          Text("4/6",
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 25)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("2 free tables",
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15)),
                          ),
                        ],
                      ),
                      SizedBox(width: 50),
                      ImageIcon(
                        AssetImage("assets/kitchen/tableView.png"),
                        size: 88,
                        color: Colors.pinkAccent,
                      ),
                    ],
                  ),
                ),
              ),
            ),

//last row

            Row(
              children: <Widget>[
                Container(
                  height: 150,
                  width: 200,
                  child: GestureDetector(
                    onTap: () async {
                      // var category = await KitchenDatabase().getTableList();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => EditTable()));
                    },
                    child: Card(
                      elevation: 40,
                      color: Colors.grey[50],
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.fromLTRB(14, 20, 10, 0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 25, 0, 5),
                            child: Text("Add tables",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ),
                          ImageIcon(
                            AssetImage("assets/kitchen/add.png"),
                            size: 68,
                            color: Colors.green[600],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 150,
                  width: 155,
                  child: GestureDetector(
                    onTap: () async {
                      // var category = await KitchenDatabase().getCategoryList();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PastOrders()));
                    },
                    child: Card(
                      elevation: 40,
                      color: Colors.grey[50],
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.fromLTRB(14, 20, 10, 0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 1),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Text("Past orders",
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                            ),
                            Icon(
                              Icons.assignment,
                              color: Colors.purple[600],
                              size: 54.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
