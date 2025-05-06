import 'package:e_commerce/features/home/repos/categories_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/core/services/get_it_service.dart';
import 'package:e_commerce/features/home/presentation/views/cubits/categories_cubit/categories_cubit.dart';
import 'package:e_commerce/features/home/presentation/views/widgets/categories_view_body.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              CategoriesCubit(getIt.get<CategoriesRepo>())..fetchCategories(),
      child: const CategoriesViewBody(),
    );
  }
}
