import 'package:dio/dio.dart';
import 'package:e_commerce/features/profile/data/models/order_customer_model.dart';

class OrderRemoteDataSource {
  final Dio dio;

  OrderRemoteDataSource(this.dio);

  Future<List<OrderCustomerModel>> fetchOrders(String token) async {
    final response = await dio.get(
      "http://waseet.runasp.net/api/Order",
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = response.data;
      return jsonList.map((e) => OrderCustomerModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch orders");
    }
  }
}
