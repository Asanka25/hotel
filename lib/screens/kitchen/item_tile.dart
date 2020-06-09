import 'package:flutter/material.dart';
import 'package:hotel/models/kitchen/KitchenData.dart';
import 'package:hotel/screens/kitchen/editForm.dart';
import 'package:hotel/services/kitchen_database.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:hotel/shades/constants.dart';
import 'dart:io';

import 'package:hotel/services/auth.dart';
import 'package:hotel/shades/loading.dart';
import 'package:hotel/shades/searchBox.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:transparent_image/transparent_image.dart';

class ItemTile extends StatefulWidget {
  final Item item;
  final int index;
  final String categoryId;

  const ItemTile({Key key, this.item, this.categoryId, this.index})
      : super(key: key);
  // final bool available;
  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  File imageFile;

  Future<File> getImageFromGalery() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    return image;
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.item.name;
    String description = widget.item.description;
    int person = widget.item.persons;
    int price = widget.item.price;

    return Container(
      height: 180,
      margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.8,
            ),
          ),
        ),
        child: Row(children: <Widget>[
          CircleAvatar(
            radius: 65,
            backgroundImage: NetworkImage('${widget.item.imageUrl}'),
            backgroundColor: Colors.transparent,
          ),

          Expanded(
            child: Container(
              // color: Colors.yellowAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(150, 0, 0, 15),
                    child: IconButton(
                        iconSize: 17,
                        icon: Icon(Icons.edit,
                            color: Color.fromRGBO(181, 2, 100, 1)),
                        tooltip: 'Edit item data',
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
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: CircleAvatar(
                                                      child: Icon(Icons.close),
                                                      backgroundColor:
                                                          Colors.red,
                                                    ),
                                                  ),
                                                ),
                                                Form(
                                                  key: _formKey,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: TextFormField(
                                                            initialValue: widget
                                                                .item.name,
                                                            decoration:
                                                                textInputDecoration
                                                                    .copyWith(
                                                                        labelText:
                                                                            'Name'),
                                                            validator: (val) =>
                                                                val.isEmpty
                                                                    ? 'Enter Name'
                                                                    : null,
                                                            onChanged: (val) {
                                                              setState(() =>
                                                                  name = val);
                                                            }),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: TextFormField(
                                                            initialValue: widget
                                                                .item
                                                                .description,
                                                            decoration:
                                                                textInputDecoration
                                                                    .copyWith(
                                                                        labelText:
                                                                            'Description'),
                                                            validator: (val) => val
                                                                    .isEmpty
                                                                ? 'Enter description'
                                                                : null,
                                                            onChanged: (val) {
                                                              setState(() =>
                                                                  description =
                                                                      val);
                                                            }),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: TextFormField(
                                                            initialValue:
                                                                (widget.item
                                                                        .price)
                                                                    .toString(),
                                                            decoration:
                                                                textInputDecoration
                                                                    .copyWith(
                                                                        labelText:
                                                                            'Price'),
                                                            validator: (val) => val
                                                                    .isEmpty
                                                                ? 'Enter valid price'
                                                                : null,
                                                            onChanged: (val) {
                                                              setState(() {
                                                                price =
                                                                    int.parse(
                                                                        val);
                                                              });
                                                            }),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: TextFormField(
                                                            initialValue: (widget
                                                                    .item
                                                                    .persons)
                                                                .toString(),
                                                            decoration:
                                                                textInputDecoration
                                                                    .copyWith(
                                                                        labelText:
                                                                            'Person'),
                                                            validator: (val) => val
                                                                    .isEmpty
                                                                ? 'Enter valid number'
                                                                : null,
                                                            onChanged: (val) {
                                                              setState(() {
                                                                person =
                                                                    int.parse(
                                                                        val);
                                                              });
                                                            }),
                                                      ),
                                                      SizedBox(
                                                        width: 110,
                                                        child: RaisedButton(
                                                          color: imageFile ==
                                                                  null
                                                              ? Colors
                                                                  .orangeAccent
                                                              : Colors.green,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            // mainAxisSize: MainAxisSize.max,
                                                            children: <Widget>[
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                child: Text(
                                                                  "Upload",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .file_upload,
                                                                color: Colors
                                                                    .white,
                                                                size: 18,
                                                              ),
                                                            ],
                                                          ),
                                                          onPressed: () async {
                                                            if (_formKey
                                                                .currentState
                                                                .validate()) {
                                                              File image =
                                                                  await getImageFromGalery();
                                                              setState(() {
                                                                imageFile =
                                                                    image;
                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                      RaisedButton(
                                                        color: Color.fromRGBO(
                                                            181, 2, 100, 1),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          15.0),
                                                              child: Text(
                                                                "Update",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        onPressed: () async {
                                                          if (_formKey
                                                              .currentState
                                                              .validate()) {
                                                            setState(() {
                                                              loading = true;
                                                            });
                                                            await KitchenDatabase()
                                                                .updateItem(
                                                                    name,
                                                                    description,
                                                                    price,
                                                                    person,
                                                                    imageFile,
                                                                    widget.item
                                                                        .imageUrl,
                                                                    widget.item
                                                                        .docId);
                                                            // print("run");
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {
                                                              loading = false;
                                                              imageFile = null;
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
                        }),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Text(widget.item.name)),
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 15, 5, 0),
                      child: Text('Rs.${widget.item.price}')),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                    child: Transform.scale(
                      scale: 0.5,
                      child: LiteRollingSwitch(
                        //initial value
                        value: widget.item.available,
                        textOn: '   ADD',
                        textOff: 'Remove',
                        colorOn: Colors.greenAccent[700],
                        colorOff: Colors.redAccent[700],
                        iconOn: Icons.done,
                        iconOff: Icons.remove_circle_outline,
                        textSize: 18.0,
                        onChanged: (bool state) async {
                          await KitchenDatabase()
                              .updateAvailability(state, widget.item.docId);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),

        // elevation: 2.5,
        // color: Colors.white,
      ),
    );
  }
}
