import 'package:e_commerce/core/services/api_order.dart';
import 'package:e_commerce/features/profile/data/repo/order_repository.dart';
import 'package:e_commerce/features/profile/domain/order_customer_entity.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<OrderCustomerEntity>> getOrders() async {
    final token = await _getToken();
    return await remoteDataSource.fetchOrders(token);
  }

  Future<String> _getToken() async {
    return "token"; // أو استخدم SharedPreferences حسب حالتك
  }
}
