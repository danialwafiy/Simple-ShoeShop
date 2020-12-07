import 'dart:async';

import 'package:ShoeShop/model/product.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial());

  List<ProductModel> carts = [];
  double totalPurchase = 0;
  
  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    
    if(event is FetchCart){
        yield CartSuccess(carts,totalPurchase);
        print(carts.length);
    }

    if(event is AddToCart){
      yield CartLoading();
      try{
        carts.add(event.product);
        totalPurchase = totalPurchase + double.parse(event.product.price);
        yield CartSuccess(carts,totalPurchase);
        print(carts.length);
      }catch(e){
        yield CartFailed();
        print(e);
      }
    }

    if(event is RemoveFromCart){
      yield CartLoading();
      try{
        carts.remove(event.product);
        totalPurchase = totalPurchase - double.parse(event.product.price);
        yield CartSuccess(carts,totalPurchase);
        print(carts.length);
      }catch(e){
        yield CartFailed();
        print(e);
      }
    }

  }
}
