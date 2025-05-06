import 'package:e_commerce/features/home/presentation/views/cubits/cart_cubit/cart_cubit.dart';
import 'package:e_commerce/features/home/presentation/views/cubits/cart_item_cubit/cart_item_cubit.dart';
import 'package:e_commerce/features/home/presentation/views/widgets/cart_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: BlocProvider.of<CartCubit>(context)),
        BlocProvider(create: (_) => CartItemCubit()), // ✅ أضف هذا
      ],
      child: const CartViewBody(),
    );
  }
}
