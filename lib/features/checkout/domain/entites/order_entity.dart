import 'package:e_commerce/features/checkout/domain/entites/shipping_address_entity.dart';
import 'package:e_commerce/features/home/models/cart_model.dart';

class OrderEntity {
  final List<CartModel> cartItems;
  final String uID;
  bool? payWithCash;
  ShippingAddressEntity shippingAddressEntity;
  int? deliveryMethodId;

  OrderEntity(
    this.cartItems, {
    required this.uID,
    this.payWithCash,
    required this.shippingAddressEntity,
    this.deliveryMethodId,
  });

  double calculateTotalPrice() {
    return cartItems.fold(0, (total, item) => total + item.total);
  }
}
