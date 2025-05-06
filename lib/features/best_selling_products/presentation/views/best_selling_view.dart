import 'package:e_commerce/core/widgets/custom_app_bar.dart';
import 'package:e_commerce/features/best_selling_products/presentation/views/widgets/best_selling_view_body.dart';
import 'package:flutter/material.dart';

class BestSellingView extends StatelessWidget {
  const BestSellingView({super.key});
  static const String routeName = "best_selling_view";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBuildAppBar(context, title: 'Best Selling'),
      body: BestSellingViewBody(),
    );
  }
}
