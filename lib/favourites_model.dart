class FavouritesModel {
  late final int id;
  late final String name;
  late final String image;
  late final String description;
  late final double price;

  FavouritesModel(dynamic obj) {
    id = obj['id'];
    name = obj['name'];
    image = obj['image'];
    description = obj['description'];
    price = double.parse(obj['price']);
  }

  FavouritesModel.fromJson(Map<String,dynamic> data) {
    id = data['id'];
    name = data['name'];
    image = data['image'];
    description = data['description'];
    price = data['price'];
  }

  Map<String,dynamic> toMap()=> {'id':id,'name':name,'image':image,'price':price,'description':description};
}