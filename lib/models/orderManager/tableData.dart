import 'package:hotel/models/orderManager/Order.dart';


class Tables {
  final int tableNo;
  final int noOfSeats;
  final String docId;
  Tables({this.tableNo,this.noOfSeats,this.docId});
}


class TableData {
  final int tableNo;
  final List<Order> orders;
  TableData({this.tableNo, this.orders});
}
