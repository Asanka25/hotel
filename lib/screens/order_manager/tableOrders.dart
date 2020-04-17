import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel/screens/order_manager/orderDetailsTile.dart';
import 'package:hotel/services/orderManager_database.dart';
import 'package:hotel/shades/orderManagerStyles.dart';
import 'package:provider/provider.dart';
import 'package:hotel/screens/kitchen/item_tile.dart';
import 'package:hotel/services/auth.dart';
import 'package:intl/intl.dart';

// class TableOrders extends StatefulWidget {
//   @override
//   _TableOrdersState createState() => _TableOrdersState();
// }

// class _TableOrdersState extends State<TableOrders> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//     );
//   }
// }


class TableOrders extends StatelessWidget {
  final AuthService _auth = AuthService();
  final List orders;
  TableOrders({this.orders});

  // List<>
  Widget build(BuildContext context) {
    // print(orderItemsDetails);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Orders',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(
            color: Colors.blueAccent, //change your color here
          ),
          backgroundColor: Colors.white,
          elevation: 2,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
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
            String status=orders[index].status;
            String orderId=orders[index].orderId;

            return Column(
              children: <Widget>[
                SizedBox(height:20),
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
            // '$orderId',
                                    
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),),
                            Align(
                                // alignment:Alignment(-0.2,0.2),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(70, 10, 0, 10),
                                  child: Text(
                                    '$formattedDate',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        getButton(status,orderId),
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
