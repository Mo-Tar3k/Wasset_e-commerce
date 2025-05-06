import 'package:e_commerce/core/repos/products_repo/products_repo.dart';
import 'package:e_commerce/core/services/get_it_service.dart';
import 'package:e_commerce/features/search/presentation/views/cubits/search_cubit/search_cubit.dart';
import 'package:e_commerce/features/search/presentation/views/widgets/search_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  static const routeName = 'search';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>(
      create: (context) => SearchCubit(getIt.get<ProductsRepo>()),
      child: Builder(
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              context.read<SearchCubit>().resetSearch();
              return true;
            },
            child: const SearchViewBody(),
          );
        },
      ),
    );
  }
}
