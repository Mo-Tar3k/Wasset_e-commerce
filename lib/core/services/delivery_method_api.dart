import 'package:dio/dio.dart';
import 'package:e_commerce/features/checkout/data/models/delivery_method_model.dart';

class DeliveryMethodApi {
  final Dio dio;
  DeliveryMethodApi(this.dio);

  Future<List<DeliveryMethodModel>> fetchDeliveryMethods(String token) async {
    final res = await dio.get(
      'http://waseet.runasp.net/api/Order/deliveryMethods',
      options: Options(headers: {'Authorization': token}),
    );
    final list = res.data as List;
    return list.map((e) => DeliveryMethodModel.fromJson(e)).toList();
  }

  Future<String> fetchBasketId(String token) async {
    final res = await dio.get(
      'http://waseet.runasp.net/api/Cart/basket/id',
      options: Options(headers: {'Authorization': token}),
    );
    return res.data.toString();
  }

  Future<void> updateDeliveryMethod(int methodId, String token) {
    return dio.put(
      'http://waseet.runasp.net/api/Cart/basket/delivery-method',
      queryParameters: {'deliveryMethodId': methodId},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
