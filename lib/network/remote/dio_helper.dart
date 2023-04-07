import 'package:dio/dio.dart';

class DioHelper {
  static late Dio productDio;
  static late Dio categoryDio;
  static late Dio singleCategory;

  static init() {
    productDio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
    categoryDio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
    singleCategory = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getProduct() async {
    productDio.options.headers={
      'lang':'en',
    };
    return await productDio.get(
      'products',
    );
  }

  static Future<Response> getCategory() async {
    categoryDio.options.headers={
      'lang':'en',
    };
    return await categoryDio.get(
      'categories',
    );
  }

  static Future<Response> getSingleCategory(int id) async {
    categoryDio.options.headers={
      'lang':'en',
    };
    return await categoryDio.get(
      'categories/$id',
    );
  }
}
