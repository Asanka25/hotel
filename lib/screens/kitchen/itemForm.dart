// import 'package:flutter/material.dart';

// import 'package:flutter/cupertino.dart';

// Widget getItemForm( Context context){
//   return showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     content: Stack(
//                       overflow: Overflow.visible,
//                       children: <Widget>[
//                         Positioned(
//                           right: -40.0,
//                           top: -40.0,
//                           child: InkResponse(
//                             onTap: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: CircleAvatar(
//                               child: Icon(Icons.close),
//                               backgroundColor: Colors.red,
//                             ),
//                           ),
//                         ),
//                         Form(
//                           key: _formKey,
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: <Widget>[
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: TextFormField(),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: TextFormField(),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: RaisedButton(
//                                   child: Text("Submitß"),
//                                   onPressed: () {
//                                     if (_formKey.currentState.validate()) {
//                                       _formKey.currentState.save();
//                                     }
//                                   },
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 });
// }