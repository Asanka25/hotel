import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel/models/kitchen/KitchenData.dart';


class KitchenDatabase {
  //collection reference
  final CollectionReference categoryCollection =
      Firestore.instance.collection('main-menu');
  final CollectionReference itemCollection =
      Firestore.instance.collection('items');

//-----------------------------------------------------------------------------------------
//get category list
Future<List<Category>>_categoryListFromQuerySnaps(QuerySnapshot snap) async{
    return snap.documents.map((doc){
      return Category(categoryName: doc.data['category'],imageUrl: doc.data['image'],docId: doc.documentID);
    } ).toList();
}
Future<List<Category>> getCategoryList()async {
var snaps=await categoryCollection.getDocuments();
List<Category>category= await _categoryListFromQuerySnaps(snaps);
return category;
}










//Change availability of order
  Future updateAvailability(bool avaiability, String docId) async {
   
      return await itemCollection
          .document(docId)
          .updateData({'available': avaiability});

  }
  Future<List<Item>> getItemDataFromSnap(DocumentSnapshot snapshot) async {
    List<Item> itemData=[];
    List items = await snapshot.data['menuItems'];
    for (var item in items) {
      // var itemRef=item['item'];
      // print(item['item']);
      DocumentSnapshot dataSnap = await item['item'].get();

      itemData.add(Item(
        docId: dataSnap.documentID,
        name: dataSnap.data['name'],
        imageUrl:dataSnap.data['image'],
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
      List items = await getItemDataFromSnap(snapshot);

      return items;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
