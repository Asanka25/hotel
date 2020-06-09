import 'package:flutter/material.dart';
import 'package:hotel/services/kitchen_database.dart';
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
    if (this.widget.status == 'cooked')
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          'Finished',
          style: TextStyle(
              color: Colors.pinkAccent,
              fontSize: 19,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
      );
    else {
      return RaisedButton(
        color: this.widget.status == 'confirmed'
            ? Colors.pink[400]
            : this.widget.status == 'cooking'
                ? Color.fromRGBO(111, 46, 208, 1)
                : Colors.white,
        child: Text(
          (this.widget.status == 'confirmed')
              ? 'Accept'
              : this.widget.status == 'cooking' ? 'Cooked' : "",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: !clicked
            ? () async {
                setState(() {
                  clicked = true;
                });
                await KitchenDatabase()
                    .updateOrderStatus(this.widget.status, this.widget.orderId);
              }
            : null,
      );
    }
  }
}
