import 'package:ShoeShop/model/product.dart';

class ProductResponse{

  final List<ProductModel> products;
  final String error;

  ProductResponse(this.products,this.error);

  ProductResponse.fromJson(List json)
  : products = json.map((i)=>ProductModel.fromJson(i)).toList(),
    error = '';

  ProductResponse.withError(String errorValue)
  : products = List(),
    error = errorValue;

}