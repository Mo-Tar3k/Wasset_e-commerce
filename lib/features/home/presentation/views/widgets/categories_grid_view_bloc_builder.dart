import 'package:e_commerce/features/home/presentation/views/cubits/categories_cubit/categories_cubit.dart';
import 'package:e_commerce/features/home/presentation/views/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesGridViewBlocBuilder extends StatelessWidget {
  const CategoriesGridViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesSuccess) {
          return SliverGrid.builder(
            itemCount: state.categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 12,
              childAspectRatio: 170 / 180,
            ),
            itemBuilder: (context, index) {
              return CategoryCard(category: state.categories[index]);
            },
          );
        } else if (state is CategoriesError) {
          return SliverToBoxAdapter(child: Center(child: Text(state.message)));
        } else {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
