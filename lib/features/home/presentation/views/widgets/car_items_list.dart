import 'package:e_commerce/features/home/models/cart_model.dart';
import 'package:e_commerce/features/home/presentation/views/widgets/cart_item.dart';
import 'package:flutter/material.dart';

class CarItemsList extends StatelessWidget {
  final List<CartModel> cartItems;

  const CarItemsList({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CartItem(cartItem: cartItems[index]), // تأكد إن CartItem معدل
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 12),
    );
  }
}
