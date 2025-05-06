import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/core/cubits/products_cubit/products_cubit.dart';
import 'package:e_commerce/features/home/presentation/views/widgets/products_grid_view_bloc_builder.dart';

class CategoryProductsView extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const CategoryProductsView({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<CategoryProductsView> createState() => _CategoryProductsViewState();
}

class _CategoryProductsViewState extends State<CategoryProductsView> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsCubit>().getProductsByCategory(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName)),
      body: const CustomScrollView(slivers: [ProductsGridViewBlocBuilder()]),
    );
  }
}
