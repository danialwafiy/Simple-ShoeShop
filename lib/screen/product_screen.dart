import 'package:ShoeShop/bloc/cart/cart_bloc.dart';
import 'package:ShoeShop/bloc/product/product_bloc.dart';
import 'package:ShoeShop/element/loader_element.dart';
import 'package:ShoeShop/model/product.dart';
import 'package:flutter/material.dart';
import 'package:ShoeShop/style/theme.dart' as Style;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  CartBloc _cartBloc;
  
  void initState() {
    _cartBloc = BlocProvider.of<CartBloc>(context);
    super.initState();
  } 


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if(state is ProductInitial){
              print('ProductInitial');
              return buildLoadingWidget();
            }
            if(state is ProductLoading){
              print('ProductLoading');
              return buildLoadingWidget();
            }
            if(state is ProductSuccess){
              print('ProductSuccess');
              return _buildProductListWidget(state.products);
            }
            if(state is ProductFailed){
              print('ProductFailed');
              return Center(
                child: Text('Something went wrong'),
              );
            }
            print('Nothing');
            return buildLoadingWidget();
          }
        )
      )
    );
  }
  
  Widget _buildProductListWidget(List<ProductModel> data){
    List<ProductModel> products = data;
    if (products.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [Text('No products to show')],
        ),
      );
    }
    return Column(
      children:[
        Expanded(
            child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.transparent,
              child: ListTile(
                leading: 
                CircleAvatar(
                  backgroundImage: NetworkImage(products[index].imageUrl),
                ),
                title: Text(products[index].name,style: TextStyle(color: Colors.white),),
                subtitle: Text('RM'+products[index].price,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
                trailing: IconButton(
                  icon: Icon(Icons.shopping_cart,color: Style.Colors.mainColor),
                  onPressed: () {
                    _cartBloc.add(AddToCart(products[index]));
                    Fluttertoast.showToast(
                      msg: "Product added to cart",
                      gravity: ToastGravity.TOP,
                      webPosition: 'center',
                      toastLength: Toast.LENGTH_SHORT,
                      backgroundColor: Style.Colors.mainColor,
                      textColor: Colors.white,
                      webBgColor:'#9F5AFD'
                    );
                  },
                )
              ),
            );
          }
        ),
      ),
      ] 
    );
  }

}
