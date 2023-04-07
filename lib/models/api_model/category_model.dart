class CategoryModel {
  final int id;
  final String image;
  final String name;

  CategoryModel({required this.id,required this.image,required this.name});

  factory CategoryModel.fromJson(Map<String,dynamic> json){
    return CategoryModel(
      id: json['id'],
      image: json['image'].toString(),
      name: json['name'].toString(),
    );
  }
}