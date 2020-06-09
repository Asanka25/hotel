import 'package:flutter/material.dart';
import 'package:hotel/screens/kitchen/kitchenCalendar.dart';
import 'package:hotel/screens/kitchen/kitchen_orders.dart';
import 'package:hotel/screens/kitchen/menu.dart';
import 'package:hotel/services/kitchen_database.dart';
import 'package:hotel/services/auth.dart';
// import 'package:hotel/screens/order_manager/kitchenCalendar.dart';

class KitchenDashboardScreen extends StatelessWidget {
  const KitchenDashboardScreen({
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
            'Kitchen Home',
            style: TextStyle(
                color: Colors.blueAccent, fontWeight: FontWeight.bold),
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
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              width: 350,
              child: GestureDetector(
                onTap: () async {
                  var category = await KitchenDatabase().getCategoryList();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => KitchenOrders()));
                },
                child: Card(
                  elevation: 40,
                  // color: Colors.grey[50],
                  color: Colors.white,

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
                          Text("4/7",
                              style: TextStyle(
                                  color: Colors.pink,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 25)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("3 free tables",
                                style: TextStyle(
                                    color: Colors.pink,
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

//first row

            Row(
              children: <Widget>[
                Container(
                  height: 150,
                  width: 200,
                  child: GestureDetector(
                    onTap: () async {
                      var category = await KitchenDatabase().getCategoryList();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => KitchenChangeAvailability(
                                  categoryList: category)));
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
                            child: Text("Menu items",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ),
                          ImageIcon(
                            AssetImage("assets/kitchen/menu.png"),
                            size: 68,
                            color: Colors.green[800],
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

//My progress
            Container(
              height: 240,
              width: 350,
              child: GestureDetector(
                onTap: null,
                child: Card(
                  elevation: 40,
                  // color: Colors.grey[50],
                  color: Colors.white,

                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(height: 30),
              
                          Container(
                            padding: EdgeInsets.all(8),
                            width: 150,
                            height: 150,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/kitchen/cheff.jpg'),
                            ),
                          ),

                          SizedBox(height: 30),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(9, 30, 0, 0),
                            child: Text("Scout Meyer",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(7, 28, 0, 0),
                            child: Text("scout@pearl.com",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15,fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Text("071-1234567",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15,fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
