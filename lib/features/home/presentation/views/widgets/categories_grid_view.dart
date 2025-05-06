import 'package:e_commerce/features/home/domain/entites/category_entity.dart';
import 'package:flutter/material.dart';

class CategoriesGridView extends StatelessWidget {
  final List<CategoryEntity> categories;
  const CategoriesGridView({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 16,
        childAspectRatio: 170 / 150,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];
        return GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(category.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(8),
            child: Container(
              color: Colors.black.withOpacity(0.4),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                category.categoryName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
