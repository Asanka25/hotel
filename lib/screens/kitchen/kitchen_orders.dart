import 'package:flutter/material.dart';
import 'package:hotel/screens/kitchen/table.dart';
import 'package:hotel/services/auth.dart';
import 'package:hotel/services/orderManager_database.dart';
import 'package:hotel/models/orderManager/tableData.dart';
import 'package:hotel/shades/loading.dart';

class KitchenOrders extends StatelessWidget {
  final AuthService _auth = AuthService();

  Widget build(BuildContext context) {
    return StreamBuilder<List<Tables>>(
        stream: OrderManagerDatabase().tables,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.blue),
                backgroundColor: Colors.white,
                centerTitle: true,
                title: Text('Table View', style: TextStyle(color: Colors.blue)),
                elevation: 1.5,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.home),
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/kitchenDashboard', (Route<dynamic> route) => false);
                    },
                  ),
                  SizedBox(width: 1),
                  PopupMenuButton<int>(
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.blue,
                    ),
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuEntry<int>>[
                        PopupMenuItem(
                          value: 1,
                          child: FlatButton.icon(
                            icon: Icon(
                              Icons.person,
                              color: Colors.blue,
                            ),
                            label: Text('Logout',
                                style: TextStyle(color: Colors.blue)),
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
              body: GridView.builder(
                  itemCount: snapshot.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return TableView(tableNo: snapshot.data[index].tableNo);
                    // return Text('$index');
                  }),
            );
          } else {
            return Container(height: 250.0, width: 250.0, child: Loading());
           
          }
        });
  }
}
