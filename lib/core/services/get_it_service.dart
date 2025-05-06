import 'package:e_commerce/core/repos/products_repo/orders_repo/orders_repo.dart';
import 'package:e_commerce/core/repos/products_repo/orders_repo/orders_repo_impl.dart';
import 'package:e_commerce/core/repos/products_repo/products_repo.dart';
import 'package:e_commerce/core/repos/products_repo/products_repo_impl.dart';
import 'package:e_commerce/core/services/api_service.dart';
import 'package:e_commerce/core/services/data_service.dart';
import 'package:e_commerce/core/services/api_auth_service.dart';
import 'package:e_commerce/features/auth/data/domain/repos/auth_repo.dart';
import 'package:e_commerce/features/auth/data/repos/auth_repo_impl.dart';
import 'package:e_commerce/features/home/repos/categories_repo.dart';
import 'package:e_commerce/features/home/repos/categories_repo_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<ApiAuthService>(ApiAuthService());
  getIt.registerSingleton<DatabaseService>(ApiService());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      apiAuthService: getIt<ApiAuthService>(),
      databaseService: getIt<DatabaseService>(),
    ),
  );
  getIt.registerSingleton<ProductsRepo>(
    ProductsRepoImpl(databaseService: getIt()),
  );
  getIt.registerSingleton<OrdersRepo>(OrdersRepoImpl(getIt<DatabaseService>()));
  getIt.registerSingleton<CategoriesRepo>(
    CategoriesRepoImpl(databaseService: getIt()),
  );
}
