import 'package:flutter/material.dart';
import 'package:hotel/models/kitchen/KitchenData.dart';
import 'package:hotel/services/kitchen_database.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
// import 'package:transparent_image/transparent_image.dart';

class ItemTile extends StatelessWidget {
  final Item item;
  ItemTile({this.item});

  // final bool available;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width:0.8,
            ),
          ),
        ),
        child: Row(children: <Widget>[
          CircleAvatar(
            radius: 65,
            backgroundImage: NetworkImage('${item.imageUrl}'),
            backgroundColor: Colors.transparent,
          ),

         

        //  Container(
        //     width: 120,
        //     height: 120,
        //    decoration: BoxDecoration(
        //                 shape: BoxShape.circle,
        //                 color: Color(0xFFe0f2f1)),
        //    child:  Image.network(
        //     '${item.imageUrl}',
        //     fit: BoxFit.fill,
        //     loadingBuilder: (BuildContext context, Widget child,
        //         ImageChunkEvent loadingProgress) {
        //       if (loadingProgress == null) return child;
        //       return Center(
        //         child: CircularProgressIndicator(
        //           value: loadingProgress.expectedTotalBytes != null
        //               ? loadingProgress.cumulativeBytesLoaded /
        //                   loadingProgress.expectedTotalBytes
        //               : null,
        //         ),
        //       );
        //     },
        //   ),
        //  ),
          Expanded(
            child: Container(
              // color: Colors.yellowAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                      child: Text(item.name)),
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Text('${item.price}')),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 5),
                    child: Transform.scale(
                      scale: 0.5,
                      child: LiteRollingSwitch(
                        //initial value
                        value: item.available,
                        textOn: '   ADD',
                        textOff: 'Remove',
                        colorOn: Colors.greenAccent[700],
                        colorOff: Colors.redAccent[700],
                        iconOn: Icons.done,
                        iconOff: Icons.remove_circle_outline,
                        textSize: 18.0,
                        onChanged: (bool state) async {
                          await KitchenDatabase()
                              .updateAvailability(state, item.docId);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),

        // elevation: 2.5,
        // color: Colors.white,
      ),
    );
  }
}
