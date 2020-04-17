import 'package:flutter/material.dart';
import 'package:hotel/services/orderManager_database.dart';

Widget getButton(String status, String orderId) {
  if (status == 'cooking')
    return RaisedButton(
      color: Colors.blue,
      disabledColor: Color.fromRGBO( 38, 153, 251,1),
      child: Text(
        'cooking..' ,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: null,
    );
  else if (status == 'served')
    return  RaisedButton(
      color: Colors.blue,
      disabledColor: Color.fromRGBO( 111, 46, 208,1),
      child: Text(
        'Served' ,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: null,
    );
            // color: Color.fromRGBO( 111, 46, 208,1),
  else if (status == 'paid')
    return  RaisedButton(
      color: Colors.blue,
      disabledColor: Colors.redAccent,
      child: Text(
        'completed' ,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: null,
    );    
            

  else {
    switch(status) { 
   case 'placed': { 
      // statements; 
   } 
   break; 
  
   case 'cooked': { 
      //statements; 
   } 
   break; 
      
   default: { 
      //statements;  
   }
   break; 
} 
    return RaisedButton(
      color: status == 'placed'
          ? Colors.pink[400]
          : status == 'cooked' ? Color.fromRGBO( 111, 46, 208,1):status == 'finished' ? Color.fromRGBO( 43, 204, 89,1): Colors.amber,
      child: Text(
        status == 'placed' ? 'Accept' : status == 'cooked' ? 'Deliver' :status == 'finished' ? 'Paid' : "error",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () async {
        // print(orderId);
        await OrderManagerDatabase().updateOrderStatus(status, orderId);
    //     setState(() {
      
    // });
        // print(status);
      },
    );
  }
}
