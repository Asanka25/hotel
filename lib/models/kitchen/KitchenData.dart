class ItemData{
  final String description;
  final int price;
  final bool available;
  
  ItemData({this.description,this.price,this.available});
}

class Item{
  final String docId;
  final bool available;
  final String imageUrl;
  final String name;
  final String description;
  final int price;

  Item({ this.docId,this.imageUrl,this.available, this.name, this.description,  this.price });

}

class Category {
  final String categoryName;
  final String imageUrl;
  final String docId;
  Category({this.categoryName,this.docId,this.imageUrl});
}