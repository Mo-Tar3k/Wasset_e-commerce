import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/widgets/build_app_bar.dart';
import 'package:e_commerce/features/home/presentation/views/widgets/categories_grid_view_bloc_builder.dart';
import 'package:flutter/material.dart';

class CategoriesViewBody extends StatelessWidget {
  const CategoriesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: KTopPadding),
                buildAppBar(
                  context,
                  title: 'Categories',
                  showBackButton: true,
                  showNotification: false,
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 12),
              ],
            ),
          ),
          const CategoriesGridViewBlocBuilder(),
        ],
      ),
    );
  }
}
