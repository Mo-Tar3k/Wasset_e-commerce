import 'package:e_commerce/core/services/data_service.dart';
import 'package:e_commerce/features/home/models/category_model.dart';
import 'package:e_commerce/features/home/repos/categories_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failures.dart';
import 'package:e_commerce/features/home/domain/entites/category_entity.dart';

class CategoriesRepoImpl extends CategoriesRepo {
  final DatabaseService databaseService;
  CategoriesRepoImpl({required this.databaseService});

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      var data =
          await databaseService.getData(
                path: 'Category/Categories',
                role: 'customer',
              )
              as List<dynamic>;

      final categories =
          data.map((e) => CategoryModel.fromJson(e).toEntity()).toList();
      return Right(categories);
    } catch (e) {
      return Left(ServerFailure('An error occurred'));
    }
  }
}
