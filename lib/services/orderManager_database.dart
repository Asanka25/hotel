import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hotel/models/orderManager/Order.dart';
import 'package:hotel/models/orderManager/tableData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderManagerDatabase {
  final int tableNo;
  OrderManagerDatabase({this.tableNo});
  //collection references
  final CollectionReference orderCollection =
      Firestore.instance.collection('orders');

  final CollectionReference itemCollection =
      Firestore.instance.collection('items');

  final CollectionReference tableCollection =
      Firestore.instance.collection('tables');

//---------------------------------------------------------------------------------------------------------
//Change status of order
  Future updateOrderStatus(String status, String orderId) async {
    if (status == 'placed') {
      return await orderCollection
          .document(orderId)
          .updateData({'status': 'confirmed'});
    } else if (status == 'cooked') {
      return await orderCollection
          .document(orderId)
          .updateData({'status': 'served'});
    } else {
      return await orderCollection
          .document(orderId)
          .updateData({'status': 'paid'});
    }
  }

//---------------------------------------------------------------------------------------------------------
//orders list from snapshot
  List<Order> _orderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      // if( doc.data['status']!='paid'){
      // DocumentReference a=doc;
      return Order(
          orderId: doc.documentID,
          status: doc.data['status'],
          total: doc.data['total'],
          subtotal: doc.data['subtotal'],
          datetime: doc.data['dateTime'],
          orderItems: doc.data['orderItems'],
          seat: doc.data['seat']);
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

//get tablereference from tablecoolection
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
    return snapshot.documents.map((doc) {
      return Tables(tableNo: doc.data['table_no']);
    }).toList();
  }

//get table stream
  Stream<List<Tables>> get tables {
    return tableCollection.snapshots().map(_tableListFromSnapshot);
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
          seat: order.seat));
    }
    return detailedOrderList;
  }
}
