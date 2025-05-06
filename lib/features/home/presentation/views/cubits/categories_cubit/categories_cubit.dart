import 'package:e_commerce/features/home/domain/entites/category_entity.dart';
import 'package:e_commerce/features/home/repos/categories_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesRepo repo;
  CategoriesCubit(this.repo) : super(CategoriesInitial());

  Future<void> fetchCategories() async {
    emit(CategoriesLoading());
    final result = await repo.getCategories();
    result.fold(
      (failure) => emit(CategoriesError(failure.message)),
      (categories) => emit(CategoriesSuccess(categories)),
    );
  }
}
