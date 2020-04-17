import 'package:flutter/material.dart';
import 'package:hotel/screens/kitchen/item_tile.dart';
import 'package:hotel/services/auth.dart';
import 'package:hotel/shades/searchBox.dart';

class FilterItem extends StatefulWidget {
  final List menuItems;

  const FilterItem({Key key, this.menuItems}) : super(key: key);

  @override
  _FilterItemState createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  final AuthService _auth = AuthService();

  TextEditingController controller = new TextEditingController();
  String filter;
  @override
  initState() {
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    print("items");

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
        // height: 500,
        // width: 500,
        child: Column(
          children: <Widget>[
            Container(
              width: 320,
              child: TextField(
                decoration: searchBoxDecoration,
                controller: controller,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.menuItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return filter == null || filter == ""
                      ? new ItemTile(item: widget.menuItems[index])
                      : widget.menuItems[index].name.toLowerCase().contains(filter.toLowerCase())
                          ? new ItemTile(item: widget.menuItems[index])
                          : new Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
