import 'package:e_commerce/core/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'widgets/product_details_body.dart';

class ProductDetailsView extends StatelessWidget {
  static const routeName = 'product-details';
  final ProductEntity product;

  const ProductDetailsView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name), elevation: 0),
      body: ProductDetailsBody(product: product),
    );
  }
}
