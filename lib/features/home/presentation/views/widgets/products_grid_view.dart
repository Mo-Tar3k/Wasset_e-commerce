import 'package:e_commerce/core/entities/product_entity.dart';
import 'package:e_commerce/core/widgets/product_item.dart';
import 'package:flutter/material.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({super.key, required this.products});

  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: products.length,

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 16,
        // mainAxisExtent: 270,
        childAspectRatio: 170 / 250,
      ),
      itemBuilder: (context, index) {
        return ProductItem(productEntity: products[index]);
      },
    );
  }
}
