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
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CartLoaded) {
          final cartItems = state.cartItems;

          // ✅ اطبع عدد أو محتوى المنتجات علشان تتأكد
          print("🧾 UI - rendering cartItems: ${cartItems.length} items");
          for (var item in cartItems) {
            print("🔸 ${item.name} x${item.quantity}"); // أو أي خاصية تهمك
          }

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
                  if (cartItems.isNotEmpty) ...[
                    const SliverToBoxAdapter(child: CustomDivider()),
                    CarItemsList(cartItems: cartItems),
                  ] else ...[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            Icon(Icons.shopping_cart), // مثال
                            const SizedBox(height: 16),
                            Text(
                              "Your cart is empty",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
        } else if (state is CartError) {
          return Center(child: Text('Error loading cart'));
        } else {
          return const SizedBox.shrink(); // For CartInitial or unknown state
        }
      },
    );
  }
}
