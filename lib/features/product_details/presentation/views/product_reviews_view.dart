import 'package:e_commerce/core/widgets/build_app_bar.dart';
import 'package:e_commerce/features/product_details/presentation/views/widgets/product_reviews_view_body.dart';
import 'package:flutter/material.dart';

class ProductReviewsView extends StatelessWidget {
  static const String routeName = 'product-reviews';
  final int productId;

  const ProductReviewsView({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'Reviews', showNotification: false),
      body: ProductReviewsViewBody(productId: productId),
    );
  }
}
