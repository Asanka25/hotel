import 'package:flutter/material.dart';
import 'package:hotel/models/orderManager/Order.dart';



class OrderDetailesTile extends StatefulWidget {
  final OrderWithDetails order;
  const OrderDetailesTile({Key key, this.order}) : super(key: key);
  @override
  _OrderDetailesTileState createState() => _OrderDetailesTileState();
}

class _OrderDetailesTileState extends State<OrderDetailesTile> {
  // int total = widget.order.total;

  void createOrderTableRows(List _rowList) {
    for (var items in widget.order.orderItems) {
      _rowList.insert(
          0,
          DataRow(cells: <DataCell>[
            DataCell(Text(
              '${items.name}',
              style:
                  TextStyle(fontStyle: FontStyle.italic, fontFamily: 'Calibri'),
            )),
            DataCell(Text(
              '${items.qty}',
              style:
                  TextStyle(fontStyle: FontStyle.italic, fontFamily: 'Calibri'),
            )),
          ]));
    }
  }

  @override
  Widget build(BuildContext context) {
    
    List<DataRow> _rowList = [
      DataRow(cells: <DataCell>[
        DataCell(Text(
          'SUBTOTAL',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        DataCell(Text(
          '${widget.order.subtotal}',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ]),
      DataRow(cells: <DataCell>[
        DataCell(Text(
          'TOTAL',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        DataCell(Text(
          '${widget.order.total}',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ]),
    ];
    createOrderTableRows(_rowList);
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 4),
  
          Card(
            elevation: 2,
            child: Container(
              child: DataTable(columns: [
                DataColumn(label: Text("Item")),
                DataColumn(label: Text("qty"), numeric: true)
              ], rows: _rowList),
            ),
          ),
        ],
      ),
    );
  }
}
