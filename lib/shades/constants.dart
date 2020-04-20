import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.transparent,
  filled: true,
  enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 1.0)),
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.pink, width: 1.0)),
);

var circuar =()=> {
      SizedBox(
          height: 300.0,
          width: 300.0,
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              strokeWidth: 5.0))
    };
