import 'package:flutter/material.dart';
import 'package:hotel/services/orderManager_database.dart';
import 'package:hotel/shades/loading.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hotel/shades/constants.dart';
import 'package:hotel/screens/kitchen/tableOrdersCalendar.dart';
import 'package:hotel/services/auth.dart';


class PastOrders extends StatefulWidget {
  @override
  _PastOrdersState createState() => _PastOrdersState();
}

class _PastOrdersState extends State<PastOrders> {
  final AuthService _auth = AuthService();

  CalendarController _controller;
  List orders = [];
  String type;
  int ordersLength = 0;
  bool loading = false;
  String orderType;

  final List<String> userType = ['All', 'Accepted', 'Delivered','Billed'];
  void initState() {
    super.initState();
    _controller = CalendarController();
    type = "All";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.blue),
                backgroundColor: Colors.white,
                centerTitle: true,
                title: Text('Past Orders', style: TextStyle(color: Colors.blue)),
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
        // body: Text("l"),
        body: Container(
          height: 570,
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: <Widget>[
                TableCalendar(
                  initialCalendarFormat: CalendarFormat.week,
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
                  width: 200,
                  child: DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: type,
                    items: userType.map((userType) {
                      return DropdownMenuItem(
                        value: userType,
                        child: Text(userType),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => type = value),
                  ),
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
