part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartModel> cartItems;

  CartLoaded(this.cartItems);

  List<Object> get props => [cartItems]; // لو بتستخدم Equatable
}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}

class CartItemAdded extends CartState {}

class CartItemRemoved extends CartState {}
