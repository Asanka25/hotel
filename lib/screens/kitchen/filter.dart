import 'package:flutter/material.dart';
import 'package:hotel/screens/kitchen/item_tile.dart';
import 'package:hotel/screens/kitchen/setting_form.dart';
import 'package:hotel/screens/kitchen/test45.dart';
import 'package:hotel/services/kitchen_database.dart';
import 'package:hotel/shades/constants.dart';
import 'dart:io';

import 'package:hotel/services/auth.dart';
import 'package:hotel/shades/loading.dart';
import 'package:hotel/shades/searchBox.dart';
import 'package:image_picker/image_picker.dart';

class FilterItem extends StatefulWidget {
  final List menuItems;
  final String categoryId;
  final String categoryName;

  const FilterItem({Key key, this.menuItems, this.categoryId,this.categoryName})
      : super(key: key);

  @override
  _FilterItemState createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  File imageFile;
  String name;
  String description;
  bool available = true;
  int person;
  int price;
  bool loading = false;
  TextEditingController controller = new TextEditingController();
  String filter;
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
    print("items");

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Order manager'),
        backgroundColor: Colors.white,
        elevation: 1.5,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                                                .copyWith(hintText: 'Name'),
                                            validator: (val) => val.isEmpty
                                                ? 'Enter Name'
                                                : null,
                                            onChanged: (val) {
                                              setState(() => name = val);
                                            }),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextFormField(
                                            decoration:
                                                textInputDecoration.copyWith(
                                                    hintText: 'Description'),
                                            validator: (val) => val.isEmpty
                                                ? 'Enter description'
                                                : null,
                                            onChanged: (val) {
                                              setState(() => description = val);
                                            }),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextFormField(
                                            decoration: textInputDecoration
                                                .copyWith(hintText: 'Price'),
                                            validator: (val) => val.isEmpty
                                                ? 'Enter valid price'
                                                : null,
                                            onChanged: (val) {
                                              setState(() {
                                                price = int.parse(val);
                                              });
                                            }),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextFormField(
                                            decoration: textInputDecoration
                                                .copyWith(hintText: 'Person'),
                                            validator: (val) => val.isEmpty
                                                ? 'Enter valid number'
                                                : null,
                                            onChanged: (val) {
                                              setState(() {
                                                person = int.parse(val);
                                              });
                                            }),
                                      ),
                                      SizedBox(
                                        width: 110,
                                        child: RaisedButton(
                                          color: imageFile == null
                                              ? Colors.orangeAccent
                                              : Colors.green,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            // mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Text(
                                                  "Upload",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Icon(
                                                Icons.file_upload,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                            ],
                                          ),
                                          onPressed: () async {
                                            if (_formKey.currentState.validate()) {
                                   
                                            File image =
                                                await getImageFromGalery();
                                            setState(() {
                                              imageFile = image;
                                            });
                                            print("run");
                                            }
                                          },
                                        ),
                                      ),
                                      RaisedButton(
                                        color: Color.fromRGBO(181, 2, 100, 1),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.all(15.0),
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
                                          if (_formKey.currentState
                                                  .validate() &&
                                              imageFile != null) {
                                            setState(() {
                                              loading = true;
                                            });
                                            await KitchenDatabase().addItem(
                                                name,
                                                description,
                                                price,
                                                person,
                                                imageFile,
                                                widget.categoryId,
                                                widget.categoryName);
                                            // print("run");
                                            Navigator.pop(context);
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
                            height: 250.0, width: 250.0, child: Loading()),
                  );
                },
              );
            },
          );
        },
        tooltip: 'Add Item',
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(181, 2, 100, 1),
        elevation: 2.0,
      ),
      body: Container(
        // height: 500,
        // width: 500,
        child: Column(
          children: <Widget>[
            Container(
              width: 320,
              child: TextField(
                decoration: searchBoxDecoration,
                controller: controller,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.menuItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return filter == null || filter == ""
                      ? new ItemTile(item: widget.menuItems[index])
                      : widget.menuItems[index].name
                              .toLowerCase()
                              .contains(filter.toLowerCase())
                          ? new ItemTile(item: widget.menuItems[index])
                          : new Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
