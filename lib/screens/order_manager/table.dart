import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hotel/screens/order_manager/tableOrders.dart';
import 'package:hotel/screens/order_manager/tabbar.dart';

import 'package:hotel/services/orderManager_database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel/shades/loading.dart';

class TableView extends StatefulWidget {
  final tableNo;

  TableView({this.tableNo});
  @override
  TableViewState createState() => TableViewState();
}

class TableViewState extends State<TableView> {
  bool isLoading = false;
  Widget _buildBottomRow(var ordersStatus) => Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 7, 0, 0),
            child: Center(
              child: Text(
                "${ordersStatus['served'] ?? 0} Served",
                style: TextStyle(
                    fontSize: 12,
                    color: Color.fromRGBO(120, 120, 120, 1),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(30, 7, 0, 0),
            child: Center(
              child: Row(
                children: <Widget>[
                  Text(
                    "${ordersStatus['finished'] ?? 0} ",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.attach_money,
                    color: Colors.blue,
                    size: 17,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
  Widget _buildUpperRow(var ordersStatus, var orders) => Row(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(3, 40, 0, 10),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                border: Border.all(
                    width: 1, color: Color.fromRGBO(112, 112, 112, 0.15)),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${widget.tableNo}',
                  style: TextStyle(
                      fontSize: 24,
                      color: Color.fromRGBO(240, 79, 165, 1),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(2, 15, 4, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(17, 12, 10, 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Color.fromRGBO(112, 112, 112, 0.15)),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(12)),
                      ),
                      width: 80,
                      height: 25,
                      child: Center(
                          child: Text(
                        "Pending...",
                        style: TextStyle(
                            fontSize: 11,
                            color: Color.fromRGBO(42, 255, 133, 1),
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                    Positioned(
                      left: 83,
                      child: Container(
                        width: 23,
                        height: 23,
                        // color: Colors.black,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(104, 214, 255, 1),
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 0.5,
                              color: Color.fromRGBO(23, 183, 242, 1)),
                        ),
                        child: Center(
                            child: Text(
                          "${ordersStatus['placed'] ?? 0}",
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    )
                  ],
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(17, 12, 10, 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Color.fromRGBO(112, 112, 112, 0.15)),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(12)),
                      ),
                      width: 80,
                      height: 25,
                      // color: Colors.pink,
                      padding: EdgeInsets.all(1),
                      child: Center(
                          child: Text(
                        "Cooking...",
                        style: TextStyle(
                            fontSize: 11,
                            color: Color.fromRGBO(29, 189, 213, 1),
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                    Positioned(
                      left: 83,
                      child: Container(
                        width: 23,
                        height: 23,
                        // color: Colors.black,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(104, 214, 255, 1),
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 0.5,
                              color: Color.fromRGBO(23, 183, 242, 1)),
                        ),
                        child: Center(
                            child: Text(
                          "${ordersStatus['cooking'] ?? 0}",
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    )
                  ],
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(17, 12, 10, 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Color.fromRGBO(112, 112, 112, 0.15)),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(12)),
                      ),
                      width: 80,
                      height: 25,
                      // color: Colors.pink,
                      padding: EdgeInsets.all(1),
                      child: Center(
                          child: Text(
                        "Finished",
                        style: TextStyle(
                            fontSize: 11,
                            color: Color.fromRGBO(111, 46, 208, 1),
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                    Positioned(
                      left: 83,
                      child: Container(
                        width: 23,
                        height: 23,
                        // color: Colors.black,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(104, 214, 255, 1),
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 0.5,
                              color: Color.fromRGBO(23, 183, 242, 1)),
                        ),
                        child: Center(
                            child: Text(
                          "${ordersStatus['cooked'] ?? 0}",
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    )
                  ],
                ),

                // SizedBox(height:10.0),
              ],
            ),
          ),
        ],
      );

  Widget build(BuildContext context) {
    return StreamBuilder<List>(
        stream: OrderManagerDatabase(tableNo: widget.tableNo).orders,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var ordersStatus = snapshot.data[1];
            var orders = snapshot.data[0];
            return !isLoading
                ? InkWell(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      var detailedOrderList = await OrderManagerDatabase()
                          .ordersWithDetails(orders);
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TableOrders(orders: detailedOrderList)));
                      // builder: (context) => FilterOrder()));

                      // builder: (context) => TabBarDemo()));
                    },
                    child: Container(
                        // color: Colors.blue,
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(6),
                        child: Column(children: <Widget>[
                          _buildUpperRow(ordersStatus, orders),
                          _buildBottomRow(ordersStatus),
                          // Text('$ordersStatus'),
                        ])),
                  )
                : Loading();
          } else {
            return Container(height: 250.0, width: 250.0, child: Loading());
          }
        });
  }
}
