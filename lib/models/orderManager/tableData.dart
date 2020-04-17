import 'package:hotel/models/orderManager/Order.dart';


class Tables {
  final int tableNo;
  Tables({this.tableNo});
}


class TableData {
  final int tableNo;
  final List<Order> orders;
  TableData({this.tableNo, this.orders});
}
