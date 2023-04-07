class ProductModel {
  final int id;
  final String price;
  final String old_price;
  final String discount;
  final String image;
  final String name;
  final String description;

  ProductModel({required this.id,required this.price,required this.old_price,required this.discount,required this.image,required this.name,required this.description});

  factory ProductModel.fromJson(Map<String,dynamic> json){
    return ProductModel(
      id: json['id'],
      price: json['price'].toString(),
      old_price: json['old_price'].toString(),
      discount: json['discount'].toString(),
      image: json['image'].toString(),
      name: json['name'].toString(),
      description: json['description'].toString(),
    );
  }
}