import 'package:flutter/material.dart';
import 'package:hotel/screens/kitchen/test45.dart';
import 'package:hotel/services/kitchen_database.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online-Campus | mobil'),
        actions: <Widget>[
          PopupMenuButton<int>(
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<int>>[
                PopupMenuItem(
                  value: 0,
                  child: Text("e"),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Text('Einstellungen'),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text('Download-Container'),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text('Soziale Netzwerke'),
                ),
                PopupMenuItem(
                  value: 3,
                  child: Text('FAQ'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(
        height: 150,
        width: 350,
        child: GestureDetector(
          onTap: () async {
            var category = await KitchenDatabase().getCategoryList();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        KitchenChangeAvailability(categoryList: category)));
          },
          child: Card(
            elevation: 40,
            color: Colors.grey[50],
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.fromLTRB(10, 20, 0, 0),
            child: Center(child: Text("Change items' avaiability")),
          ),
        ),
      ),
    );
  }
}
