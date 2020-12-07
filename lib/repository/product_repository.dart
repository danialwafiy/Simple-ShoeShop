import 'package:ShoeShop/model/product.dart';
import 'package:dio/dio.dart';

class ProductRepository {
  static String mainUrl = "http://127.0.0.1:8000";
  var productListUrl = '$mainUrl/api/shoe';
  final Dio _dio = Dio();

  Future<List<ProductModel>> getProducts() async {
    try {
        Response response = await _dio.get(productListUrl);
        return (response.data as List)
              .map((i) =>
              ProductModel.fromJson(i)).toList();
    } catch (error, stacktrace) {
        print("Something went wrong: $error stackTrace: $stacktrace");
        return [];
    }
  }

}

/* class ProductRepository {
  static String mainUrl = "http://127.0.0.1:8000";
  var productListUrl = '$mainUrl/api/shoe';
  final Dio _dio = Dio();

  Future<ProductResponse> getProducts() async {
    try {
        Response response = await _dio.get(productListUrl);
        return ProductResponse.fromJson(response.data);
    } catch (error, stacktrace) {
        print("Something went wrong: $error stackTrace: $stacktrace");
        return ProductResponse.withError("$error");
    }
  }

} */