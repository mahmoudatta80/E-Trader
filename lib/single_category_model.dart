class SingleCategoryModel {
  final int id;
  final String price;
  final String old_price;
  final String discount;
  final String image;
  final String name;
  final String description;

  SingleCategoryModel({required this.id,required this.price,required this.old_price,required this.discount,required this.image,required this.name,required this.description});

  factory SingleCategoryModel.fromJson(Map<String,dynamic> json){
    return SingleCategoryModel(
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