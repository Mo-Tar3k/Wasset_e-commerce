import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/utils/app_images.dart';
import 'package:e_commerce/core/widgets/custom_network_image.dart';
import 'package:e_commerce/features/home/models/cart_model.dart';
import 'package:e_commerce/features/home/presentation/views/cubits/cart_cubit/cart_cubit.dart';
import 'package:e_commerce/features/home/presentation/views/widgets/cart_item_action_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.cartItem});
  final CartModel cartItem;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.gray(context),
        ),
        child: Row(
          children: [
            Container(
              width: 73,
              height: 92,
              decoration: BoxDecoration(color: AppColors.white(context)),
              child: CustomNetworkImage(imageUrl: cartItem.imageUrl),
            ),
            const SizedBox(width: 17),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        cartItem.name,
                        style: TextStyle(
                          color: AppColors.blac(context),
                          fontSize: 18,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          context.read<CartCubit>().removeItem(cartItem.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(Assets.assetsImagesTrash),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColors.lightSecondaryColor,
                      fontSize: 13,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w400,
                      height: 1.60,
                    ),
                  ),
                  Row(
                    children: [
                      CartItemActionButtons(cartItem: cartItem),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${cartItem.price * cartItem.quantity} L.E',
                          style: TextStyle(
                            color: AppColors.lightSecondaryColor,
                            fontSize: 16,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
