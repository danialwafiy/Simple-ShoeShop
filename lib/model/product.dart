class ProductModel{

  final int id;
  final String name,brand,detail,imageUrl,price;

  ProductModel(this.id,this.name,this.brand,this.imageUrl,this.price,this.detail);

  ProductModel.fromJson(Map<String,dynamic> json)
  : id = json['id'],
    name = json['name'],
    brand = json['brand'],
    detail = json['detail'],
    imageUrl = json['image_url'],
    price = json['price'];

}