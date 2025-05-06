import 'package:e_commerce/features/checkout/domain/entites/shipping_address_entity.dart';
import 'package:e_commerce/features/home/models/cart_model.dart';

class OrderEntity {
  final String uID;
  final List<CartModel> cartItems;
  bool? payWithCash;
  ShippingAddressEntity shippingAddressEntity;

  OrderEntity(
    this.cartItems, {
    required this.uID,
    this.payWithCash,
    required this.shippingAddressEntity,
  });

  double calculateTotalPrice() {
    return cartItems.fold(0, (total, item) => total + item.total);
  }
}
