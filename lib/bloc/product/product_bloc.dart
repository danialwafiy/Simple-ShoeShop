import 'dart:async';

import 'package:ShoeShop/model/product.dart';
import 'package:ShoeShop/repository/product_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial());

  ProductRepository _repository = ProductRepository();

  @override
  Stream<ProductState> mapEventToState(ProductEvent event,) async* {
    
    if(event is FetchProduct){
      yield ProductLoading();
      try{
        print('fetching product');
        final List<ProductModel> products = await _repository.getProducts();
        yield ProductSuccess(products);
        print('fetching complete');
      }catch(e){
        yield ProductFailed();
        print(e);
        print('fetching failed');
      }
    }

  }
}
