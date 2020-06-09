import 'package:flutter/material.dart';
import 'package:hotel/models/kitchen/KitchenData.dart';
import 'package:hotel/screens/kitchen/editForm.dart';
import 'package:hotel/services/kitchen_database.dart';
import 'package:hotel/services/orderManager_database.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:hotel/shades/constants.dart';
import 'dart:io';

import 'package:hotel/services/auth.dart';
import 'package:hotel/shades/loading.dart';
import 'package:hotel/shades/searchBox.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:transparent_image/transparent_image.dart';

class TableTile extends StatefulWidget {
  final int tableNo;
  final int noOfSeats;
  final String docId;

  const TableTile({Key key, this.tableNo, this.noOfSeats, this.docId})
      : super(key: key);
  // final bool available;
  @override
  _TableTileState createState() => _TableTileState();
}

class _TableTileState extends State<TableTile> {
  bool loading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    int tableNo = widget.tableNo;
    int noOfSeats = widget.noOfSeats;
    String docId = widget.docId;
    String validTableNo = '';

    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/kitchen/table.jpeg'),
            backgroundColor: Colors.transparent,
          ),
          title: Text('Table No: $tableNo'),
          subtitle: Text('No of seats : $noOfSeats'),
          trailing: IconButton(
              iconSize: 17,
              icon: Icon(Icons.edit, color: Color.fromRGBO(181, 2, 100, 1)),
              tooltip: 'Edit table data',
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
                                                  initialValue:
                                                      (tableNo).toString(),
                                                  decoration: textInputDecoration
                                                      .copyWith(
                                                          labelText: 'Table No',
                                                          errorText: validTableNo ==
                                                                  'error'
                                                              ? 'Entered table no already exist'
                                                              : null),
                                                  validator: (val) =>
                                                      (val.isEmpty)
                                                          ? 'Enter table no'
                                                          : null,

                                                  // errorText:validTableNo==''?'error':null,
                                                  onChanged: (val) {
                                                    setState(() => tableNo =
                                                        int.parse(val));
                                                  }),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                  initialValue:
                                                      noOfSeats.toString(),
                                                  decoration: textInputDecoration
                                                      .copyWith(
                                                          labelText:
                                                              'No of seats'),
                                                  validator: (val) =>
                                                      val.isEmpty
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
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    child: Text(
                                                      "Update",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onPressed: () async {
                                                if (_formKey.currentState
                                                    .validate()) {
                                                  setState(() {
                                                    loading = true;
                                                  });

                                                  var result =
                                                      await OrderManagerDatabase()
                                                          .updateTable(tableNo,
                                                              noOfSeats, docId);
                                                  print(result);
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
              }),
        ),
      ),
    );
    //   height: 140,
    //   margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
    //   child: Container(
    //     decoration: BoxDecoration(
    //       border: Border(
    //         bottom: BorderSide(
    //           color: Colors.grey,
    //           width: 0.8,
    //         ),
    //       ),
    //     ),

    // );
  }
}
