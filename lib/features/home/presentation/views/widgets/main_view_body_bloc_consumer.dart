import 'package:e_commerce/core/helper_funcations/show_error_bar.dart';
import 'package:e_commerce/features/home/presentation/views/cubits/cart_cubit/cart_cubit.dart';
import 'package:e_commerce/features/home/presentation/views/widgets/main_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainViewBodyBlocConsumer extends StatelessWidget {
  const MainViewBodyBlocConsumer({super.key, required this.currentViewIndex});

  final int currentViewIndex;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartItemAdded) {
          showMassgeBar(context, "✅ Product added to cart");
          context.read<CartCubit>().loadCart();
        }
        if (state is CartItemRemoved) {
          showMassgeBar(context, "🗑️ Product removed from cart");
        }
      },
      child: MainViewBody(currentViewIndex: currentViewIndex),
    );
  }
}
