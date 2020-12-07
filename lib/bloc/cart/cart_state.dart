part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
  
  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final List<ProductModel> carts;
  final double totalPurchase;
  const CartSuccess(this.carts,this.totalPurchase);
  @override
  List<Object> get props => [carts,totalPurchase];
}

class CartFailed extends CartState {}
