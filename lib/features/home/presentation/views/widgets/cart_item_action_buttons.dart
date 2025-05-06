import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/features/home/models/cart_model.dart';
import 'package:e_commerce/features/home/presentation/views/cubits/cart_cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemActionButtons extends StatelessWidget {
  const CartItemActionButtons({super.key, required this.cartItem});
  final CartModel cartItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CartItemActionButton(
          iconColor: Colors.white,
          onPressed: () {
            cartItem.quantity++;
            context.read<CartCubit>().updateQuantity(cartItem);
          },
          color: AppColors.primaryColor,
          icon: Icons.add,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            cartItem.quantity.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.blac(context),
              fontSize: 16,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        CartItemActionButton(
          iconColor: Colors.grey,
          onPressed: () {
            cartItem.quantity--;
            if (cartItem.quantity <= 0) {
              context.read<CartCubit>().removeItem(cartItem.id);
            } else {
              context.read<CartCubit>().updateQuantity(cartItem);
            }
          },
          color: const Color(0xFFF3F5F7),
          icon: Icons.remove,
        ),
      ],
    );
  }
}

class CartItemActionButton extends StatelessWidget {
  const CartItemActionButton({
    super.key,
    required this.onPressed,
    required this.color,
    required this.icon,
    required this.iconColor,
  });

  final VoidCallback onPressed;
  final Color color;
  final Color iconColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 24,
        height: 24,
        padding: const EdgeInsets.all(2),
        decoration: ShapeDecoration(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: FittedBox(child: Icon(icon, color: iconColor)),
      ),
    );
  }
}
