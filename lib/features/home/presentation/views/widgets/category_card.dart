import 'package:e_commerce/core/cubits/products_cubit/products_cubit.dart';
import 'package:e_commerce/core/services/get_it_service.dart';
import 'package:e_commerce/features/home/domain/entites/category_entity.dart';
import 'package:e_commerce/features/home/presentation/views/widgets/category_products_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCard extends StatelessWidget {
  final CategoryEntity category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => BlocProvider(
                  create: (_) => ProductsCubit(getIt()),
                  child: CategoryProductsView(
                    categoryId: category.id,
                    categoryName: category.categoryName,
                  ),
                ),
          ),
        );
      },

      child: Card(
        child: Column(
          children: [
            Expanded(
              child: Image.network(category.imageUrl, fit: BoxFit.cover),
            ),
            const SizedBox(height: 8),
            Text(
              category.categoryName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
