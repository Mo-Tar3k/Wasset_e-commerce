import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/widgets/product_item.dart';
import 'package:e_commerce/features/search/presentation/views/cubits/search_cubit/search_cubit.dart';
import 'package:e_commerce/features/search/presentation/views/cubits/search_cubit/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultBuilder extends StatelessWidget {
  const SearchResultBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        final cubit = context.read<SearchCubit>();
        final query = cubit.query;
        final results = cubit.results;
        final recent = cubit.recentSearches;

        if (state is SearchLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (query.isEmpty) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (recent.isNotEmpty) ...[
                const Text(
                  'Latest Searches',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...recent.map(
                  (e) => ListTile(
                    title: Text(e),
                    leading: const Icon(Icons.history),
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => cubit.removeSearch(e),
                    ),
                    onTap: () => cubit.updateQuery(e),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: cubit.clearAllSearches,
                  child: Text(
                    'Clear All Searches',
                    style: TextStyle(color: AppColors.blac(context)),
                  ),
                ),
              ],
            ],
          );
        }

        if (state is SearchNoResults) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/no_result.png', height: 230),
                const SizedBox(height: 24),
                const Text(
                  'Search',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),
                const Text('No Results Found'),
              ],
            ),
          );
        }

        if (state is SearchSuccess) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: results.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 16,
              childAspectRatio: 170 / 250,
            ),
            itemBuilder: (context, index) {
              return ProductItem(productEntity: results[index]);
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
