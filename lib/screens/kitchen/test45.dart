import 'package:hotel/models/kitchen/KitchenData.dart';
import 'package:hotel/screens/kitchen/filter.dart';
import 'package:hotel/services/kitchen_database.dart';
import 'package:hotel/screens/kitchen/foodItemList.dart';
import 'package:hotel/shades/loading.dart';
import 'package:hotel/shades/constants.dart';
import 'package:hotel/services/auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class KitchenChangeAvailability extends StatelessWidget {
  final List<Category> categoryList;
  KitchenChangeAvailability({this.categoryList});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
     
        // child: Center(
        //   child: Container(
        //     color: Colors.grey,
        //     child: InkWell(
        //         onTap: () async {
        //           var str = 'J0wrS7SivfQaJQBaydgd';
        //           List menuItems = await KitchenDatabase().getItemData(str);

        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => FilterItem(menuItems:menuItems)));
        //         },
        //         child: Container(
        //           height: 200,
        //           width: 150,
        //           child: Text('Pasta'),
        //         )),
        //   ),
        // ),
        child: ListView.builder(
          itemCount:categoryList.length,
          itemBuilder: (context, index) {
            var category=categoryList[index];
            return Container(
              // color: Colors.redAccent,
              // height: 120,
              // width: 70,
              child: Card(
                elevation: 5,
                child: InkWell(
                  onTap: () async {
                   
                    List menuItems = await KitchenDatabase().getItemData(category.docId);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FilterItem(menuItems: menuItems)));
                  },
                  child: Container(
                    height: 150,
                    // width: double.maxFinite,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(category.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ClipRRect(
                      // make sure we apply clip it properly
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.black.withOpacity(0.3),
                          child: Text(
                            "${category.categoryName}",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              ),
            );
          },
        ),
      ),
    );
  }
}
