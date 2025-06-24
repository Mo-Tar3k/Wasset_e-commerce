import 'package:dio/dio.dart';
import 'package:e_commerce/core/services/api_payment.dart';
import 'package:e_commerce/features/checkout/data/models/shipping_address_model.dart';
import 'package:e_commerce/features/checkout/domain/entites/order_entity.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentRepoImpl {
  final PaymentApi api;
  final Dio dio = Dio(); // Add this line to define and initialize Dio

  PaymentRepoImpl(this.api);

  // 1. إنشاء PaymentIntent مع الطباعة
  Future<String> createPaymentIntent(String basketId, String token) async {
    try {
      print("🚀 [createPaymentIntent] Called with basketId: $basketId");

      final response = await dio.post(
        'http://waseet.runasp.net/api/Payments/$basketId',
        data: {}, // مهم
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      print("📩 [createPaymentIntent] Response: ${response.data}");

      final clientSecret = response.data['clientSecret'];
      if (clientSecret == null) {
        throw Exception("❌ clientSecret not received");
      }

      return clientSecret;
    } catch (e) {
      print("❌ [createPaymentIntent] Dio error: $e");

      if (e is DioException) {
        print("📛 DioException.status: ${e.response?.statusCode}");
        print("📛 DioException.data: ${e.response?.data}");
      }

      rethrow;
    }
  }

  // 2. تنفيذ الدفع الكامل مع تسجيل كل خطوة
  Future<void> processPayment(OrderEntity orderEntity, String token) async {
    try {
      print("⚙️ [processPayment] Start processing payment...");

      // الخطوة 1: جلب basketId
      final basketId = await api.fetchBasketId(token);
      print("✅ basketId: $basketId");

      final clientSecret = await api.createPaymentIntent(basketId, token);
      print("✅ clientSecret: $clientSecret");

      // الخطوة 3: تهيئة واجهة Stripe
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Waseet',
        ),
      );
      print("💳 [Stripe] Payment sheet initialized");

      // الخطوة 4: عرض ورقة الدفع
      await Stripe.instance.presentPaymentSheet();
      print("✅ [Stripe] Payment completed successfully");

      // الخطوة 5: إنشاء الطلب
      print("📦 [Create Order] Creating order...");
      await api.createOrder(
        basketId: basketId,
        deliveryMethodId: orderEntity.deliveryMethodId!,
        address: ShippingAddressModel.fromEntity(
          orderEntity.shippingAddressEntity,
        ),
        token: token,
      );
      print("✅ [Create Order] Order submitted");

      // الخطوة 6: مسح السلة
      print("🧹 [Clear Basket] Removing basket...");
      await api.clearBasket(token);
      print("✅ [Clear Basket] Basket cleared");
    } catch (e) {
      print("❌ [processPayment] Error during payment process: $e");
      rethrow;
    }
  }
}
