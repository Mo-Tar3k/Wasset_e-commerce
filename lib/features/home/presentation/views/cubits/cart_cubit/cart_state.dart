part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartModel> items;
  CartLoaded(this.items);
}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}

class CartItemAdded extends CartState {}

class CartItemRemoved extends CartState {}
