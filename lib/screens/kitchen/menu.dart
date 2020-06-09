import 'package:hotel/models/kitchen/KitchenData.dart';
import 'package:hotel/screens/kitchen/KitchenDashboard.dart';
import 'package:hotel/screens/kitchen/filter.dart';
import 'package:hotel/services/kitchen_database.dart';
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
        iconTheme: IconThemeData(color: Colors.blue),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Category View', style: TextStyle(color: Colors.blue)),
        elevation: 1.5,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            color: Colors.blue,
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/kitchenDashboard', (Route<dynamic> route) => false);
            },
          ),
          SizedBox(width: 1),
          PopupMenuButton<int>(
            icon: Icon(
              Icons.more_vert,
              color: Colors.blue,
            ),
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<int>>[
                PopupMenuItem(
                  value: 1,
                  child: FlatButton.icon(
                    icon: Icon(Icons.person,color: Colors.blue,),
                    label: Text('Logout',style:TextStyle(color: Colors.blue)),
                    onPressed: () async {
                      await _auth.signOut();
                    },
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            var category = categoryList[index];
            return Container(
              child: Card(
                elevation: 5,
                child: InkWell(
                  onTap: () async {
                    List menuItems =
                        await KitchenDatabase().getItemData(category.docId);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FilterItem(
                                menuItems: menuItems,
                                categoryName: category.categoryName,
                                categoryId: category.docId)));
                  },
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(category.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.white10.withOpacity(0.1),
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
