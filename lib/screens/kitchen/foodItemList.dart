import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hotel/screens/kitchen/item_tile.dart';

import 'package:hotel/services/auth.dart';


class FoodItemList extends StatelessWidget {
final List menuItems;
final AuthService _auth = AuthService();

FoodItemList(this.menuItems);
  @override
  Widget build(BuildContext context) {


    // return SafeArea(
    //       child: Scaffold(
    //     backgroundColor: Colors.white,
    //     appBar: AppBar(
    //       centerTitle: true,
    //       title: Text(
    //         'Food Items',
    //         style: TextStyle(color: Colors.black),
    //       ),
    //       iconTheme: IconThemeData(
    //           color: Colors.blueAccent, //change your color here
    //         ),
    //       backgroundColor: Colors.white,
    //       elevation: 0.5,
    //       actions: <Widget>[
    //         FlatButton.icon(
    //           icon: Icon(Icons.person),
    //           label: Text('Logout'),
    //           onPressed: () async {
    //             await _auth.signOut();
    //           },
    //         ),
    //       ],
    //     ),
    //     body: ListView.builder(
        
    //     itemCount: menuItems.length,
    //     itemBuilder: (context,index){
    //       return ItemTile(item:menuItems[index]);
    //     },
          
    //   ),
    //   ),
    // );

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("Collapsing Toolbar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: Image.network(
                    "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: Center(
          child: Text("Sample Text"),
        ),
      ),
    );

  }
}