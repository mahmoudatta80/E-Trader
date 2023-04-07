import 'package:e_commerce_app/models/api_model/data.dart';

class Softagi {
  Data? data;

  Softagi({this.data});

  factory Softagi.fromJson(Map<String,dynamic> json) {
    return Softagi(
      data: json['data']!=null?Data.fromJson(json['data']):null,
    );
  }
}