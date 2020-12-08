import 'package:ShoeShop/bloc/cart/cart_bloc.dart';
import 'package:ShoeShop/element/loader_element.dart';
import 'package:ShoeShop/model/product.dart';
import 'package:flutter/material.dart';
import 'package:ShoeShop/style/theme.dart' as Style;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  
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
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if(state is CartInitial){
              print('CartInitial');
              return buildLoadingWidget();
            }
            if(state is CartLoading){
              print('CartLoading');
              return buildLoadingWidget();
            }
            if(state is CartSuccess){
              print('CartSuccess');
              if(state.carts.length == 0)
                return Center(
                  child: Text('Cart is empty.',style: TextStyle(color: Colors.white,)
                ));
              else
                return _buildProductListWidget(state.carts);
            }
            if(state is CartFailed){
              print('CartFailed');
              return Center(
                child: Text('Something went wrong'),
              );
            }
            print('Nothing');
            return buildLoadingWidget();
          }
        )
      ),
    );
  }
  
  Widget _buildProductListWidget(List<ProductModel> data){
    List<ProductModel> products = data;
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
                      _cartBloc.add(RemoveFromCart(products[index]));
                      Fluttertoast.showToast(
                        msg: "Product removed from cart",
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
        Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          height: 56.0,
          width: double.infinity,
          color: Style.Colors.mainColor,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [ 
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if(state is CartSuccess){
                      return Text('TOTAL PURCHASE RM'+ state.totalPurchase.toStringAsFixed(2),style: TextStyle(color: Style.Colors.backgroundColor,fontWeight: FontWeight.bold));
                    }
                    return null;
                  }
                ),
                FlatButton(
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  color: Style.Colors.backgroundColor,
                  onPressed: () {
                  },
                  child: Text('CHECKOUT',style: TextStyle(color: Colors.white,fontSize: 12),),
                )

              ] 
            )
          ),
      ] 
    );
  }

}