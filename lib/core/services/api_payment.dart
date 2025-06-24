import 'package:dio/dio.dart';
import 'package:e_commerce/features/checkout/data/models/order_model.dart';
import 'package:e_commerce/features/checkout/data/models/shipping_address_model.dart';

class PaymentApi {
  final Dio dio;

  PaymentApi(this.dio);

  // 1. إنشاء PaymentIntent
  Future<String> createPaymentIntent(String basketId, String token) async {
    final response = await dio.post(
      'http://waseet.runasp.net/api/Payments/$basketId',
      data: {}, // ✅ مهم حتى لو فاضي
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    final clientSecret = response.data['clientSecret'];
    if (clientSecret == null) {
      throw Exception("❌ clientSecret not received");
    }
    return clientSecret;
  }

  // 2. إنشاء الطلب
  Future<void> createOrder({
    required String basketId,
    required int deliveryMethodId,
    required ShippingAddressModel address,
    required String token,
  }) async {
    final data = {
      "basketId": basketId,
      "deliveryMethodId": deliveryMethodId,
      "shippingToAddress": address.toJson(),
    };

    print("🚀 [createOrder] Sending:");
    print("🧺 basketId: $basketId");
    print("🚚 deliveryMethodId: $deliveryMethodId");
    print("📦 address: ${address.toJson()}");
    print("🔐 token: $token");

    try {
      final response = await dio.post(
        'http://waseet.runasp.net/api/Order',
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      print("📨 [createOrder] Response code: ${response.statusCode}");
      print("📨 [createOrder] Response body: ${response.data}");

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception("❌ Failed to create order: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ [createOrder] Dio error: $e");
      if (e is DioException) {
        print("📛 DioException.response: ${e.response}");
        print("📛 DioException.status: ${e.response?.statusCode}");
        print("📛 DioException.data: ${e.response?.data}");
      }
      rethrow;
    }
  }

  // 3. حذف الباسكت
  Future<void> clearBasket(String token) async {
    await dio.delete(
      'http://waseet.runasp.net/api/Cart/basket',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  // 4. الحصول على basketId
  Future<String> fetchBasketId(String token) async {
    final res = await dio.get(
      'http://waseet.runasp.net/api/Cart/basket/id',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return res.data.toString();
  }
}
