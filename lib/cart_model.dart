class CartModel {
  late final int id;
  late final String name;
  late final String image;
  late final double price;
  late final String description;
  late final int count;

  CartModel(dynamic obj) {
    id = obj['id'];
    name = obj['name'];
    image = obj['image'];
    description = obj['description'];
    price = double.parse(obj['price']);
    count = obj['count'];
  }

  CartModel.fromJson(Map<String,dynamic> data) {
    id = data['id'];
    name = data['name'];
    image = data['image'];
    description = data['description'];
    price = data['price'];
    count = data['count'];
  }

  Map<String,dynamic> toMap()=> {'id':id,'name':name,'image':image,'price':price,'count':count,'description':description};
}