import 'package:flutter/material.dart';
import 'package:hotel/screens/order_manager/table.dart';
import 'package:hotel/services/auth.dart';
import 'package:hotel/services/orderManager_database.dart';
import 'package:hotel/models/orderManager/Order.dart';
import 'package:hotel/models/orderManager/tableData.dart';
import 'package:provider/provider.dart';

class OrderManagerHome extends StatelessWidget {
  final AuthService _auth = AuthService();

  Widget build(BuildContext context) {
    return StreamBuilder<List<Tables>>(
        stream: OrderManagerDatabase().tables,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                centerTitle: true,
                title: Text('Order manager'),
                backgroundColor: Colors.white,
                elevation: 1.5,
                actions: <Widget>[
                  FlatButton.icon(
                    icon: Icon(Icons.person),
                    label: Text('Logout'),
                    onPressed: () async {
                      await _auth.signOut();
                    },
                  ),
                ],
              ),
              body: GridView.builder(
                  itemCount: snapshot.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return TableView(tableNo: snapshot.data[index].tableNo);
                    // return Text('$index');
                  }),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
