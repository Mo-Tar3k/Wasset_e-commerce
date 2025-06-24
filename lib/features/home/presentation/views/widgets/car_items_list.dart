import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:e_commerce/features/home/models/cart_model.dart';
import 'cart_item.dart';

class CarItemsList extends StatelessWidget {
  final List<CartModel> cartItems;

  const CarItemsList({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: CartItem(cartItem: cartItems[index]),
        );
      }, childCount: cartItems.length),
    );
  }
}
