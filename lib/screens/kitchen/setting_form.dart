// import 'package:brew_crew/services/database.dart';
// import 'package:brew_crew/models/user.dart';
// import 'package:brew_crew/shades/loading.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hotel/shades/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  File imageFile;
  String _currentName = '';
  String _currentSugar = '';
  int _currentStrength = 0;
  Color color=Colors.redAccent;
  @override
  Widget build(BuildContext context) {
    showDialog(
              context: context,
            
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: color,
                  content: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Positioned(
                        right: -40.0,
                        top: -40.0,
                        child: InkResponse(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: CircleAvatar(
                            child: Icon(Icons.close),
                            backgroundColor: Colors.redAccent,
                          ),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            // Padding(
                            //   padding: EdgeInsets.all(8.0),
                            //   child: TextFormField(
                            //       decoration: textInputDecoration.copyWith(
                            //           hintText: 'Name'),
                            //       validator: (val) =>
                            //           val.isEmpty ? 'Enter Name' : null,
                            //       onChanged: (val) {
                            //         setState(() => _currentName = val);
                            //       }),
                            // ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Price'),
                                  validator: (val) =>
                                      val.isEmpty ? 'Enter valid price' : null,
                                  onChanged: (val) {
                                    setState(() { _currentStrength = int.parse(val);
                                    color=Colors.amber;});
                                  }),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.all(8.0),
                            //   child: RaisedButton(
                            //     child: Text(
                            //       imageFile==null?'k':'done'),
                            //     onPressed: () async {
                            //       await getImageFromGalery();
                            //       print("aa");
                               
                            //     },
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: RaisedButton(
                            //     child: Text("Add Item"),
                            //     onPressed: () async {
                            //       if (_formKey.currentState.validate()) {
                            //         // _formKey.currentState.save();
                            //         await KitchenDatabase()
                            //             .addItem(name, price,imageFile);
                            //         // print("run");
                            //       }
                            //     },
                            //   ),
                            // ),
                            
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
    // return Form(
    //   key: _formKey,
    //   child: Column(
    //     children: <Widget>[
    //       Text(
    //         'Update your brew settings',
    //         style: TextStyle(fontSize: 18.0),
    //       ),
    //       SizedBox(height: 20.0),
    //       TextFormField(
    //           decoration: textInputDecoration,
    //           validator: (val) => val.isEmpty ? 'Enter email' : null,
    //           onChanged: (val) {
    //             setState(() => _currentName = val);
    //           }),
    //       SizedBox(height: 20.0),
    //       TextFormField(
    //           decoration: textInputDecoration,
    //           validator: (val) => val.isEmpty ? 'Enter email' : null,
    //           onChanged: (val) {
    //             setState(() => _currentName = val);
    //           }),
    //       //dropdown

    //       //slider
    //       RaisedButton(
    //         color: Colors.pink[400],
    //         child: Text(
    //           _currentName==''?'Update':'done',
    //           style: TextStyle(color: Colors.white),
    //         ),
    //         onPressed: () {},
    //       ),
    //     ],
    //   ),
    // );
  }
}
