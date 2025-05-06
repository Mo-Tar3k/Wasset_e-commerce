import 'package:e_commerce/features/home/presentation/views/cart_view.dart';
import 'package:e_commerce/features/home/presentation/views/categories_view.dart';
import 'package:e_commerce/features/home/presentation/views/profile_view.dart';
import 'package:e_commerce/features/home/presentation/views/widgets/home_view.dart';
import 'package:flutter/material.dart';

class MainViewBody extends StatelessWidget {
  const MainViewBody({super.key, required this.currentViewIndex});

  final int currentViewIndex;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: currentViewIndex,
      children: const [HomeView(), CartView(), CategoriesView(), ProfileView()],
    );
  }
}
