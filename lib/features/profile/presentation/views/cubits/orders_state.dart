import 'package:e_commerce/features/profile/domain/order_customer_entity.dart';

abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<OrderCustomerEntity> orders;

  OrdersLoaded(this.orders);
}

class OrdersError extends OrdersState {
  final String message;

  OrdersError(this.message);
}
