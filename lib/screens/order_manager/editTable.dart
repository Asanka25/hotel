import 'package:flutter/material.dart';
import 'package:hotel/screens/kitchen/item_tile.dart';
import 'package:hotel/screens/order_manager/tableTile.dart';
import 'package:hotel/services/kitchen_database.dart';
import 'package:hotel/services/orderManager_database.dart';
import 'package:hotel/shades/constants.dart';
import 'dart:io';
import 'package:hotel/services/auth.dart';
import 'package:hotel/shades/loading.dart';
import 'package:hotel/shades/searchBox.dart';
import 'package:image_picker/image_picker.dart';

class EditTable extends StatefulWidget {
  // final List tableList;

  // const EditTable(
  //     {Key key, this.tableList})
  //     : super(key: key);

  @override
  _EditTableState createState() => _EditTableState();
}

class _EditTableState extends State<EditTable> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool available = true;
  int tableNo;
  int noOfSeats;
  bool loading = false;
  TextEditingController controller = new TextEditingController();
  String filter;
  String validTableNo = '';
  @override
  initState() {
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<File> getImageFromGalery() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Widget build(BuildContext context) {
    return StreamBuilder<List>(
        stream: OrderManagerDatabase().tables,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var tables = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.blue),
                backgroundColor: Colors.white,
                centerTitle: true,
                title: Text('Add Table', style: TextStyle(color: Colors.blue)),
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
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            content: loading == false
                                ? SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Stack(
                                      overflow: Overflow.visible,
                                      children: <Widget>[
                                        Positioned(
                                          right: -40.0,
                                          top: -90.0,
                                          child: InkResponse(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: CircleAvatar(
                                              child: Icon(Icons.close),
                                              backgroundColor: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Form(
                                          key: _formKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                    decoration: textInputDecoration
                                                        .copyWith(
                                                            labelText:
                                                                'Table No',
                                                            errorText:
                                                                validTableNo ==
                                                                        'error'
                                                                    ? "Entered table no already exist"
                                                                    : null),
                                                    validator: (val) => val
                                                            .isEmpty
                                                        ? 'Enter valid number'
                                                        : null,
                                                    onChanged: (val) {
                                                      setState(() {
                                                        tableNo =
                                                            int.parse(val);
                                                      });
                                                    }),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                    decoration: textInputDecoration
                                                        .copyWith(
                                                            labelText:
                                                                'No of seats'),
                                                    validator: (val) => val
                                                            .isEmpty
                                                        ? 'Enter valid number'
                                                        : null,
                                                    onChanged: (val) {
                                                      setState(() {
                                                        noOfSeats =
                                                            int.parse(val);
                                                      });
                                                    }),
                                              ),
                                              RaisedButton(
                                                color: Color.fromRGBO(
                                                    181, 2, 100, 1),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(15.0),
                                                      child: Text(
                                                        "ADD",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onPressed: () async {
                                                  setState(() {
                                                    loading = true;
                                                  });
                                                  var result =
                                                      await OrderManagerDatabase()
                                                          .addTable(tableNo,
                                                              noOfSeats);

                                                  if (result == null) {
                                                    Navigator.pop(context);
                                                    setState(() {
                                                      validTableNo = '';
                                                      loading = false;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      validTableNo = 'error';
                                                      loading = false;
                                                    });
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    height: 250.0,
                                    width: 250.0,
                                    child: Loading()),
                          );
                        },
                      );
                    },
                  );
                },
                tooltip: 'Add Table',
                child: Icon(Icons.add),
                backgroundColor: Color.fromRGBO(181, 2, 100, 1),
                elevation: 2.0,
              ),
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/kitchen/restaurant_table.jpg'),
                      fit: BoxFit.fitHeight),
                ),
                // height: 500,
                // width: 500,
                child: Column(
                  children: <Widget>[
                    // SizedBox(height: 8),
                    Container(
                      color: Colors.transparent,
                      width: 320,
                      child: TextField(
                        decoration: searchBoxDecoration.copyWith(
                            fillColor: Color.fromRGBO(40, 50, 150, 0.3)),
                        style: TextStyle(color: Colors.white),
                        controller: controller,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: tables.length,
                        itemBuilder: (BuildContext context, int index) {
                          return filter == null || filter == ""
                              ? new TableTile(
                                  tableNo: tables[index].tableNo,
                                  noOfSeats: tables[index].noOfSeats,
                                  docId: tables[index].docId)
                              : tables[index]
                                      .tableNo
                                      .toString()
                                      .contains(filter)
                                  ? TableTile(
                                      tableNo: tables[index].tableNo,
                                      noOfSeats: tables[index].noOfSeats,
                                      docId: tables[index].docId)
                                  : new Container();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container(height: 250.0, width: 250.0, child: Loading());
          }
        });
  }
}
