import 'package:e_commerce_app/models/api_model/category_model.dart';
import 'package:e_commerce_app/models/api_model/product_model.dart';
import 'package:e_commerce_app/models/api_model/single_category_model.dart';

class Data {
  late final List<ProductModel> productModel;
  late final List<CategoryModel> categoryModel;
  late final List<SingleCategoryModel> singleCategoryModel;

  Data({required this.productModel,required this.categoryModel,required this.singleCategoryModel});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      productModel: List<ProductModel>.from(json['data'].map((e)=>ProductModel.fromJson(e))),
      categoryModel: List<CategoryModel>.from(json['data'].map((e)=>CategoryModel.fromJson(e))),
      singleCategoryModel: List<SingleCategoryModel>.from(json['data'].map((e)=>SingleCategoryModel.fromJson(e))),
    );
  }
}
