import 'package:flutter/material.dart';
import 'package:hotel/services/orderManager_database.dart';

class getButton extends StatefulWidget {
  String status;
  String orderId;
  getButton({this.status, this.orderId});

  @override
  _getButtonState createState() => _getButtonState();
}

class _getButtonState extends State<getButton> {
  bool clicked;
  @override
  void initState() {
    super.initState();
    clicked = false;
  }

  Widget build(BuildContext context) {
    if (this.widget.status == 'cooking')
      return RaisedButton(
        color: Colors.blue,
        disabledColor: Color.fromRGBO(38, 153, 251, 1),
        child: Text(
          'cooking..',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: null,
      );
    else if (this.widget.status == 'served')
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Served',
          style: TextStyle(
              color: Colors.pinkAccent,
              fontSize: 16,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
      );
    // color: Color.fromRGBO( 111, 46, 208,1),

    else {
      return RaisedButton(
        color: this.widget.status == 'placed'
            ? Colors.pink[400]
            : this.widget.status == 'cooked'
                ? Color.fromRGBO(111, 46, 208, 1)
                : this.widget.status == 'finished'
                    ? Color.fromRGBO(43, 204, 89, 1)
                    : Colors.white,
        child: Text(
          (this.widget.status == 'placed')
              ? 'Accept'
              : this.widget.status == 'cooked'
                  ? 'Deliver'
                  : this.widget.status == 'finished' ? 'Paid' : "",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: !clicked
            ? () async {
              setState(() {
                  clicked = true;
                });
                await OrderManagerDatabase()
                    .updateOrderStatus(this.widget.status, this.widget.orderId);
                
              }
            : null,
      );
    }
  }
}
