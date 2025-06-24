import 'package:e_commerce/features/home/models/cart_model.dart';

class OrderProductModel {
  final String name;
  final String imageUrl;
  final double price;
  final int quantity;

  OrderProductModel({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  factory OrderProductModel.fromCartModel(CartModel cartItem) {
    return OrderProductModel(
      name: cartItem.name,
      imageUrl: cartItem.imageUrl,
      price: cartItem.price,
      quantity: cartItem.quantity,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'imageUrl': imageUrl,
    'price': price,
    'quantity': quantity,
  };
}
