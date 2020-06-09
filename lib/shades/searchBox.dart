import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

const searchBoxDecoration = InputDecoration(
  
  prefixIcon: Icon(Icons.search),
  fillColor: Colors.transparent,
  filled: true,
  //  TextField(
  // style: new TextStyle(color: Colors.white),),
  hintText: "          Search from table No...",
  hintStyle: TextStyle(fontStyle: FontStyle.italic,color: Colors.white),
  // enabledBorder: UnderlineInputBorder(
  //     borderSide: BorderSide(color: Colors.blue, width: 1.0)),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 1.0),
    borderRadius: const BorderRadius.all(
      const Radius.circular(45.0),
    ),
  ),
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 1.0),
    borderRadius: const BorderRadius.all(
      const Radius.circular(45.0),
    ),
  ),
 
);
