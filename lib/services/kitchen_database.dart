import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hotel/models/kitchen/KitchenData.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

class KitchenDatabase {
  //collection reference
  final CollectionReference categoryCollection =
      Firestore.instance.collection('main-menu');
  final CollectionReference itemCollection =
      Firestore.instance.collection('items');
  final CollectionReference orderCollection =
      Firestore.instance.collection('orders');
  final CollectionReference test = Firestore.instance.collection('test');
  // StorageReference reference= FirebaseStorage.instance.ref();

//---------------------------------------------------------------------------------------------------------
//Change status of order
  Future updateOrderStatus(String status, String orderId) async {
    DateTime datetime = DateTime.now();
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String id = user.uid;
    var snap = await orderCollection.document(orderId).get();
    Map data = snap.data['staffInteract'];
    if (status == 'confirmed') {
      await orderCollection.document(orderId).updateData({'status': 'cooking'});
      List cookedBy = [id, datetime, orderId];
      data['cookedBy'] = cookedBy;
      await orderCollection
          .document(orderId)
          .updateData({'staffInteract': data});
    } else if (status == 'cooking') {
      return await orderCollection
          .document(orderId)
          .updateData({'status': 'cooked'});
    }
  }

//Add new item
//upload image
  Future<String> uploadImage(File imageFile) async {
    String path = imageFile.path.split('/').last;
    StorageReference reference = FirebaseStorage.instance.ref().child(path);
    StorageUploadTask uploadTask = reference.putFile(imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadUrl =
        await FirebaseStorage.instance.ref().child(path).getDownloadURL();
    return downloadUrl;
  }

  Future addItem(String name, String description, int price, int persons,
      File imageFile, String categoryId, String categoryName) async {
    String downloadUrl = await uploadImage(imageFile);
    DocumentReference docRef = await itemCollection.add({
      'name': name,
      'category': categoryName,
      'description': description,
      'persons': persons,
      'price': price,
      'available': true,
      'image': downloadUrl
    });

    var snap = await categoryCollection.document(categoryId).get();
    List data = snap.data['menuItems'];
    Map map = {'item': docRef, 'type': 'Default'};
    data.add(map);
    // print(dat);
    await categoryCollection
        .document(categoryId)
        .updateData({'menuItems': data});
  }

//------------------------------------------------------------------------------------------
//update item
  Future updateItem(String name, String description, int price, int persons,
      File imageFile, String downloadURL, String docId) async {
    String downloadUrl =
        imageFile != null ? await uploadImage(imageFile) : downloadURL;
    await itemCollection.document(docId).updateData({
      'name': name,
      'description': description,
      'persons': persons,
      'price': price,
      'available': true,
      'image': downloadUrl
    });
  }

//-----------------------------------------------------------------------------------------
//get category list
  Future<List<Category>> _categoryListFromQuerySnaps(QuerySnapshot snap) async {
    return snap.documents.map((doc) {
      return Category(
          categoryName: doc.data['category'],
          imageUrl: doc.data['image'],
          docId: doc.documentID);
    }).toList();
  }

  Future<List<Category>> getCategoryList() async {
    var snaps = await categoryCollection.getDocuments();
    List<Category> category = await _categoryListFromQuerySnaps(snaps);
    return category;
  }

//-----------------------------------------------------------------------------------------------------------

//Change availability of item
  Future updateAvailability(bool avaiability, String docId) async {
    return await itemCollection
        .document(docId)
        .updateData({'available': avaiability});
  }

  //-----------------------------------------------------------------------------------------------------
//Get item list with data

  Future<List<Item>> getItemDataFromSnap(DocumentSnapshot snapshot) async {
    List<Item> itemData = [];
    List items = await snapshot.data['menuItems'];

    for (var item in items) {
      // var itemRef=item['item'];
      // print(item['item']);
      DocumentSnapshot dataSnap = await item['item'].get();

      itemData.add(Item(
        docId: dataSnap.documentID,
        name: dataSnap.data['name'],
        imageUrl: dataSnap.data['image'],
        persons: dataSnap.data['persons'],
        description: dataSnap.data['description'],
        price: dataSnap.data['price'],
        available: dataSnap.data['available'],
      ));
    }
    return itemData;
  }

  Future<List> getItemData(String docId) async {
    try {
      DocumentSnapshot snapshot =
          await categoryCollection.document(docId).get();
      List<Item> items = await getItemDataFromSnap(snapshot);
      
      return items;
    } catch (e) {
      
      return null;
    }
  }
}
