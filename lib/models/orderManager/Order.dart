import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Order {
  final String orderId;
  final String status;
  final int subtotal;
  final int total;
  final Timestamp datetime;
  final List orderItems;
  final Map staffInteract;

  final int seat;
  // final String table;
  Order({this.orderId,this.status, this.datetime, this.orderItems, this.total,this.subtotal,this.staffInteract, this.seat});
}




class OrderWithDetails {
  final String orderId;
  final String status;
  final int subtotal;
  final int total;
  final Timestamp datetime;
  final List orderItems;
  final Map staffInteract;
  final int seat;
  // final String table;
  OrderWithDetails ({this.orderId,this.status, this.datetime, this.orderItems,this.staffInteract, this.total,this.subtotal, this.seat});
}

class OrderItem{
  final String name;
  final String description;
  final int price;
  final int qty;
  OrderItem({this.name, this.description, this.price,this.qty});
}
