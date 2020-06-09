import 'package:flutter/material.dart';
import 'package:hotel/services/orderManager_database.dart';
import 'package:hotel/shades/loading.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hotel/shades/constants.dart';
import 'package:hotel/screens/kitchen/tableOrdersCalendar.dart';

// import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PastOrders extends StatefulWidget {
  @override
  _PastOrdersState createState() => _PastOrdersState();
}

class _PastOrdersState extends State<PastOrders> {
  CalendarController _controller;
  List orders = [];
  String type;
  int ordersLength = 0;
  bool loading = false;
  String orderType;

  
  void initState() {
    super.initState();
    _controller = CalendarController();
    type = "Cooked";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Past orders")),
        // body: Text("l"),
        body: Container(
          height: 570,
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: <Widget>[
                TableCalendar(
                  initialCalendarFormat: CalendarFormat.month,
                  calendarStyle: CalendarStyle(
                    selectedColor: Color.fromRGBO(181, 2, 100, 1),
                  ),
                  calendarController: _controller,
                  onDaySelected: (date, events) async {
                    String day = (date.day) < 10
                        ? '0${date.day}'
                        : (date.day).toString();
                    String month = (date.month) < 10
                        ? '0${date.month}'
                        : (date.month).toString();
                    String year = (date.year).toString();
                    // print(type);
                    setState(() {
                      loading = true;
                    });
                    List dorders = await OrderManagerDatabase()
                        .getOrdersForGivenDate(year, month, day, type);
                    setState(() {
                      orders = dorders;
                      ordersLength = orders.length;
                      loading = false;
                      // print('length ss ${orders.length}');
                    });
                  },
                ),
                
                Container(
                  height: 160,
                  width: 195,
                  child: loading == false
                      ? GestureDetector(
                          onTap: () {
                            print('ord ${orders.length}');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TableOrders(orders: orders,type:type)));
                          },
                          child: Card(
                              elevation: 10,
                              color: Colors.grey[50],
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.fromLTRB(5, 20, 0, 0),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 0, 10, 10),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 20),
                                    Text(
                                        (orders.length) == null
                                            ? "0"
                                            : " $ordersLength",
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 55)),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 10, 0),
                                      child: Text(
                                          ordersLength == 1
                                              ? "Order"
                                              : "Orders",
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                    ),
                                  ],
                                ),
                              )),
                        )
                      // : CircularProgressIndicator(),
                      :Loading(),
                ),
              ])),
        ));
  }
}
