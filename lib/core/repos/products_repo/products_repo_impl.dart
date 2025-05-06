import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/entities/product_entity.dart';
import 'package:e_commerce/core/errors/failures.dart';
import 'package:e_commerce/core/models/product_model.dart';
import 'package:e_commerce/core/repos/products_repo/products_repo.dart';
import 'package:e_commerce/core/services/data_service.dart';
import 'package:e_commerce/core/utils/backend_endpoint.dart';

class ProductsRepoImpl extends ProductsRepo {
  final DatabaseService databaseService;
  ProductsRepoImpl({required this.databaseService});
  @override
  Future<Either<Failure, List<ProductEntity>>> getBestSellingProducts() async {
    try {
      var data =
          await databaseService.getData(
                role: "customer",
                path: BackendEndpoint.getProducts(pageIndex: 2, pageSize: 10),
              )
              as List<Map<String, dynamic>>;
      List<ProductEntity> products =
          data.map((e) => ProductModel.fromjson(e).toEntity()).toList();

      return Right(products);
    } catch (e) {
      return Left(ServerFailure('An error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final data =
          await databaseService.getData(
                path: BackendEndpoint.getProducts(pageIndex: 1, pageSize: 100),
                role: "customer",
              )
              as List<Map<String, dynamic>>;

      final products =
          data.map((e) => ProductModel.fromjson(e).toEntity()).toList();

      // ترتيب المنتجات حسب ID تنازليًا لاختيار الأحدث
      products.sort((a, b) => b.id.compareTo(a.id));

      final latestProducts = products.take(10).toList();

      return Right(latestProducts);
    } catch (e) {
      return Left(ServerFailure('An error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
    int categoryId,
  ) async {
    try {
      final rawData = await databaseService.getData(
        path: 'Product/ProductsCards',
        role: "customer",
        query: {'CategoryId': categoryId},
      );

      if (rawData is List) {
        if (rawData.isEmpty) {
          return Left(ServerFailure('No products found in this category.'));
        }

        final products =
            rawData
                .map(
                  (e) =>
                      ProductModel.fromjson(
                        Map<String, dynamic>.from(e),
                      ).toEntity(),
                )
                .toList();

        return Right(products);
      }

      return Left(ServerFailure('Invalid response structure'));
    } catch (e) {
      return Left(
        ServerFailure('Something went wrong while loading products.'),
      );
    }
  }
}
