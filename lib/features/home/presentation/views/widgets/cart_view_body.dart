import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/widgets/build_app_bar.dart';
import 'package:e_commerce/features/home/presentation/views/cubits/cart_cubit/cart_cubit.dart';
import 'package:e_commerce/features/home/presentation/views/widgets/car_items_list.dart';
import 'package:e_commerce/features/home/presentation/views/widgets/cart_header.dart';
import 'package:e_commerce/features/home/presentation/views/widgets/custom_cart_button.dart';
import 'package:e_commerce/features/home/presentation/views/widgets/custom_divider_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItems = context.watch<CartCubit>().cartItems;

    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: KTopPadding),
                  buildAppBar(
                    context,
                    title: 'Cart',
                    showNotification: false,
                    showBackButton: false,
                  ),
                  SizedBox(height: 24),
                  CartHeader(),
                  SizedBox(height: 8),
                ],
              ),
            ),
            if (cartItems.isNotEmpty)
              const SliverToBoxAdapter(child: CustomDivider()),
            CarItemsList(cartItems: cartItems),
          ],
        ),
        Positioned(
          right: 0,
          left: 0,
          bottom: MediaQuery.sizeOf(context).height * 0.04,
          child: const CustomCartButton(),
        ),
      ],
    );
  }
}
