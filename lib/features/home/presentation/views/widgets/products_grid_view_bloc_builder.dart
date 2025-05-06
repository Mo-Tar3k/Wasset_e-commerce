import 'package:e_commerce/core/cubits/products_cubit/products_cubit.dart';
import 'package:e_commerce/core/helper_funcations/get-dummy-product.dart';
import 'package:e_commerce/features/home/presentation/views/widgets/products_grid_view.dart';
import 'package:e_commerce/features/home/presentation/views/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductsGridViewBlocBuilder extends StatelessWidget {
  const ProductsGridViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsSuccess) {
          if (state.products.isEmpty) {
            return const SliverToBoxAdapter(
              child: CustomErrorWidget(
                text: 'No products available in this category.',
              ),
            );
          }
          return ProductsGridView(products: state.products);
        } else if (state is ProductsError) {
          return SliverToBoxAdapter(
            child: CustomErrorWidget(
              text:
                  state.message == 'No products found in this category.'
                      ? 'No products available in this category.'
                      : 'An error occurred while loading products.',
            ),
          );
        } else {
          return Skeletonizer.sliver(
            enabled: true,
            child: ProductsGridView(products: getDummyProducts()),
          );
        }
      },
    );
  }
}
