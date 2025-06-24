abstract class PaymentRepo {
  Future<String> createPaymentIntent(String basketId, String token);
  Future<bool> confirmPayment(String clientSecret);
  Future<void> createOrder(String token, Map<String, dynamic> shippingInfo);
  Future<void> clearBasket(String token);
}
