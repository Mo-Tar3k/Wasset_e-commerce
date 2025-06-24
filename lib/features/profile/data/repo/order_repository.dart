import 'package:e_commerce/features/profile/domain/order_customer_entity.dart';

abstract class OrderRepository {
  Future<List<OrderCustomerEntity>> getOrders();
}
