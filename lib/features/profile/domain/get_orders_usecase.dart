import 'package:e_commerce/features/profile/data/repo/order_repository.dart';
import 'package:e_commerce/features/profile/domain/order_customer_entity.dart';

class GetOrdersUseCase {
  final OrderRepository repository;

  GetOrdersUseCase(this.repository);

  Future<List<OrderCustomerEntity>> call() async {
    return await repository.getOrders();
  }
}
