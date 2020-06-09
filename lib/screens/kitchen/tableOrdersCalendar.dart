import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel/screens/kitchen/orderDetailsTile.dart';
import 'package:hotel/services/orderManager_database.dart';
import 'package:hotel/shades/kitchenStyles.dart';
import 'package:provider/provider.dart';
import 'package:hotel/screens/kitchen/item_tile.dart';
import 'package:hotel/services/auth.dart';
import 'package:intl/intl.dart';

class TableOrders extends StatelessWidget {
  final AuthService _auth = AuthService();
  final List orders;
  final String type;
  TableOrders({this.orders,this.type});

  // List<>
  Widget build(BuildContext context) {
    // // print(orderItemsDetails);
    // print("in ${orders.length}");
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.blue),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(type=="All"?'Orders':'$type Orders', style: TextStyle(color: Colors.blue)),
          elevation: 1.5,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/orderManagerDashboard', (Route<dynamic> route) => false);
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
                      label:
                          Text('Logout', style: TextStyle(color: Colors.blue)),
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
        body: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            var datetime = DateTime.fromMillisecondsSinceEpoch(
                orders[index].datetime.millisecondsSinceEpoch);
            String formattedDate =
                DateFormat('yyyy-MM-dd   kk:mm').format(datetime);
           
            return Column(
              children: <Widget>[
                SizedBox(height: 20),
                Card(
                  elevation: 4,
                  child: Container(
                    width: 320,
                    // height: 500,
                    child: Column(
                      children: <Widget>[
                        OrderDetailesTile(order: orders[index]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Align(
                              // alignment: Alignment.centerLeft,
                              child: Text(
                                'seat: ${orders[index].seat}',
                      
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Align(
                                // alignment:Alignment(-0.2,0.2),
                                child: Padding(
                              padding: const EdgeInsets.fromLTRB(70, 10, 0, 10),
                              child: Text(
                                '$formattedDate',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                          ],
                        ),
                        // getButton(status, orderId),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
