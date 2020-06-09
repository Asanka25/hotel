import 'package:flutter/material.dart';
import 'package:hotel/models/kitchen/KitchenData.dart';
import 'dart:io';
import 'package:hotel/shades/constants.dart';
import 'package:hotel/shades/loading.dart';
import 'package:image_picker/image_picker.dart';

class EditForm extends StatefulWidget {

 final Item item;
 final int index;
  final String categoryId;
  

  const EditForm({Key key, this.item, this.categoryId,this.index})
      : super(key: key);


  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final _formKey = GlobalKey<FormState>();
   File imageFile;
  String name;
  String description;
  bool available = true;
  int person;
  int price;
  bool loading = false;



 Future<File> getImageFromGalery() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    return image;
  }
void runn(){}
  @override
  Widget build(BuildContext context) {
    void popUp(){
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
                                                .copyWith(labelText: 'Name'),
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
                                                    labelText: 'Description'),
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
                                                .copyWith(labelText: 'Price'),
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
                                                .copyWith(labelText: 'Person'),
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
                                            // await KitchenDatabase().addItem(
                                            //     name,
                                            //     description,
                                            //     price,
                                            //     person,
                                            //     imageFile,
                                            //     widget.categoryId,
                                            //     widget.categoryName);
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
    }
    return Container(
      color: Colors.redAccent,
      child: Text('index'),
    );
  }
}