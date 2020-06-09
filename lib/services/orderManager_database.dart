import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hotel/models/orderManager/Order.dart';
import 'package:hotel/models/orderManager/tableData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderManagerDatabase {
  final int tableNo;
  OrderManagerDatabase({this.tableNo});
  //collection references
  final CollectionReference orderCollection =
      Firestore.instance.collection('orders');
  final CollectionReference testorderCollection =
      Firestore.instance.collection('testOrders');

  final CollectionReference itemCollection =
      Firestore.instance.collection('items');

  final CollectionReference tableCollection =
      Firestore.instance.collection('tables');
  final AuthService _auth = AuthService();
//---------------------------------------------------------------------------------------------------------
//Change status of order
  Future updateOrderStatus(String status, String orderId) async {
    DateTime datetime = DateTime.now();
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String id = user.uid;
    var snap = await orderCollection.document(orderId).get();
    Map data = snap.data['staffInteract'];
    if (status == 'placed') {
      await orderCollection
          .document(orderId)
          .updateData({'status': 'confirmed'});
      List acceptedBy = [id, datetime, orderId];
      data['acceptedBy'] = acceptedBy;
      await orderCollection
          .document(orderId)
          .updateData({'staffInteract': data});
    } else if (status == 'cooked') {
      await orderCollection.document(orderId).updateData({'status': 'served'});
      List deliveredBy = [id, datetime, orderId];
      data['deliveredBy'] = deliveredBy;
      await orderCollection
          .document(orderId)
          .updateData({'staffInteract': data});
    } else {
      await orderCollection.document(orderId).updateData({'status': 'paid'});
      List billedBy = [id, datetime, orderId];
      data['billedBy'] = billedBy;
      await orderCollection
          .document(orderId)
          .updateData({'staffInteract': data});
    }
  }

//---------------------------------------------------------------------------------------------------------
//orders list from snapshot
  List<Order> _orderListFromSnapshot(QuerySnapshot snapshot) {
    List incompleteOrderList = snapshot.documents.where((doc) {
      if (doc.data['status'] != 'paid')
        return true;
      else
        return false;
    }).toList();
    return incompleteOrderList.map((doc) {
      // if(doc.data['status']!='paid'){
      return Order(
          orderId: doc.documentID,
          status: doc.data['status'],
          total: doc.data['total'],
          subtotal: doc.data['subtotal'],
          datetime: doc.data['dateTime'],
          orderItems: doc.data['orderItems'],
          staffInteract: doc.data['staffInteract'],
          seat: doc.data['seat']);
      // }
      // else return null;
      // }else
    }).toList();
  }

  List _orderCount(QuerySnapshot snapshot) {
    var map = Map();
    List<Order> orders;
    orders = _orderListFromSnapshot(snapshot);
    orders.forEach((element) {
      if (!map.containsKey(element.status)) {
        map[element.status] = 1;
      } else {
        map[element.status] += 1;
      }
    });
    return [orders, map];
  }

//get tablereference from tablecollection
  Future<String> tableDocID(int tableNo) async {
    String docID = '';
    QuerySnapshot tableDocs = await tableCollection.getDocuments();
    tableDocs.documents.forEach((doc) {
      if (doc.data['table_no'] == tableNo) {
        docID = doc.documentID;
      }
    });

    return docID;
  }

// get table data stream
  Stream<List> get orders async* {
    DocumentReference tableRef;

    await tableDocID(tableNo).then((value) => {
          tableRef = Firestore.instance
              .collection('tables')
              .document(value.toString()),
        });

    yield* orderCollection
        .where('table', isEqualTo: tableRef)
        .snapshots()
        .map(_orderCount);
  }

//----------------------------------------------------------------------------------------------------------

//tablelist from snapshot

  List<Tables> _tableListFromSnapshot(QuerySnapshot snapshot) {
    var tableList= snapshot.documents.map((doc) {
      return Tables(
          tableNo: doc.data['table_no'],
          noOfSeats: doc.data['no_of_seats'],
          docId: doc.documentID);
    }).toList();
    tableList.sort((a, b) => a.tableNo.compareTo(b.tableNo));
    return tableList;
  }

//get table stream
  Stream<List<Tables>> get tables {
    return tableCollection.snapshots().map(_tableListFromSnapshot);
  }

//------------------------------------------------------------------------------------------
//check for table existence
  Future<bool> checkForValidTableNumber(int tableNo) async {
    var table = await tableCollection.getDocuments();
    bool isValid = true;
    for (int i = 0; i < table.documents.length; i++) {
      if (table.documents[i].data['table_no'] == tableNo) {
        isValid = false;
        break;
      }
    }
    return isValid;
  }

//add table
  Future addTable(int tableNo, int noOfSeats) async {
    bool isValid = await checkForValidTableNumber(tableNo);
    if (isValid) {
      await tableCollection.add({
        'table_no': tableNo,
        'no_of_seats': noOfSeats,
        'activeStatus': false
      });
    } else {
      return 'error';
    }
  }
//check for table existence
  Future<String> checkForValidTableNumberWhenUpdate(int tableNo,String docId) async {
    var table = await tableCollection.getDocuments();
    String id ;
    for (int i = 0; i < table.documents.length; i++) {
      if (table.documents[i].data['table_no'] == tableNo) {
        id=table.documents[i].documentID;
        break;
      }
    }
    if (id==docId)
      return "sameTable";
    else return id;
  }

//------------------------------------------------------------------------------------------
//update table
  Future updateTable(int tableNo, int noOfSeats, String docId) async {
    String validity = await checkForValidTableNumberWhenUpdate(tableNo,docId);
    
    
    if (validity==null || validity=="sameTable") {
      await tableCollection.document(docId).updateData({
        'table_no': tableNo,
        'no_of_seats': noOfSeats,
      });
    } else {
      return "error";
    }
  }

//------------------------------------------------------------------------------------------------------------

  Future<List> orderItemsWithDetails(Order order) async {
    List<OrderItem> items = [];

    for (var orderItem in order.orderItems) {
      DocumentReference itemRef = orderItem['item'];
      var qty = orderItem['qty'];

      var dataSnap = await itemRef.get();

      items.add(OrderItem(
          name: dataSnap.data['name'],
          description: dataSnap.data['description'],
          price: dataSnap.data['price'],
          qty: qty));
    }

    return items;
  }

//Orders details from references.

  Future<List> ordersWithDetails(List orders) async {
    List<OrderWithDetails> detailedOrderList = [];
    for (var order in orders) {
      var orderItemList = await orderItemsWithDetails(order);
      detailedOrderList.add(OrderWithDetails(
          orderId: order.orderId,
          status: order.status,
          subtotal: order.subtotal,
          total: order.total,
          datetime: order.datetime,
          orderItems: orderItemList,
          staffInteract: order.staffInteract,
          seat: order.seat));
    }
    return detailedOrderList;
  }

  Future<List> getOrdersForGivenDate(
      String year, String month, String day, String type) async {
    List orders = await getOrderList(year, month, day);
    List detailedOrderList = await ordersWithDetails(orders);
    // print(detailedOrderList.length);
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String id = user.uid;
    if (type == 'Accepted') {
      detailedOrderList = detailedOrderList.where((x) {
        if (x.staffInteract['acceptedBy'] != null) {
          if (x.staffInteract['acceptedBy'][0] == id)
            return true;
          else
            return false;
        }
        return false;
      }).toList();
    } else if (type == 'Delivered') {
      detailedOrderList = detailedOrderList.where((x) {
        if (x.staffInteract['deliveredBy'] != null) {
          if (x.staffInteract['deliveredBy'][0] == id)
            return true;
          else
            return false;
        }
        return false;
      }).toList();
    } else if (type == 'Billed') {
      detailedOrderList = detailedOrderList.where((x) {
        if (x.staffInteract['billedBy'] != null) {
          if (x.staffInteract['billedBy'][0] == id)
            return true;
          else
            return false;
        }
        return false;
      }).toList();
    } else if (type == 'Cooked') {
      detailedOrderList = detailedOrderList.where((x) {
        if (x.staffInteract['cookedBy'] != null) {
          if (x.staffInteract['cookedBy'][0] == id)
            return true;
          else
            return false;
        }
        return false;
      }).toList();
    }
    return detailedOrderList;
  }

  Future<List<Order>> _orderListFromQuerySnaps(QuerySnapshot snap) async {
    return snap.documents.map((doc) {
      return Order(
          orderId: doc.documentID,
          status: doc.data['status'],
          total: doc.data['total'],
          subtotal: doc.data['subtotal'],
          datetime: doc.data['dateTime'],
          orderItems: doc.data['orderItems'],
          staffInteract: doc.data['staffInteract'],
          seat: doc.data['seat']);
    }).toList();
  }

  Future<List<Order>> getOrderList(
    String year, String month, String day) async {
    DateTime startdatetime = DateTime.parse('$year-$month-$day 00:00:00');
    DateTime enddatetime = DateTime.parse('$year-$month-$day 23:59:59');
    var snaps = await orderCollection
        // .where('status', isEqualTo: "served")
        .where('dateTime', isGreaterThan: startdatetime)
        .where('dateTime', isLessThan: enddatetime)
        .getDocuments();

    List<Order> ordersList = await _orderListFromQuerySnaps(snaps);
    return ordersList;
  }

  Future<Map> progressCount() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String id = user.uid;
    var snaps = await orderCollection.getDocuments();
    var countMap = {'Accepted': 0, 'Billed': 0, 'Delivered': 0};

    snaps.documents.forEach((doc) {
      var map = doc.data['staffInteract'];


     map.forEach((k,v) { 
        if (k=='acceptedBy') {
          if (v[0] == id) countMap['Accepted'] += 1;
      } else if (k=='billedBy') {
        if (v[0] == id) countMap['Billed'] += 1;
      } else if (k=='deliveredBy') {
        if (v[0] == id) countMap['Delivered'] += 1;
      }

    }); 
    });
  
    return countMap;
  }
}
