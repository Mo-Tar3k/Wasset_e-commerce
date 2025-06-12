// import 'package:e_commerce/features/add_products/core/repos/images_repo/images_dashboard_repo.dart';
// import 'package:e_commerce/features/add_products/core/repos/images_repo/images_dashboard_repo_impl.dart';
// import 'package:e_commerce/features/add_products/core/repos/product_repo/products_dashboard_repo.dart';
// import 'package:e_commerce/features/add_products/core/repos/product_repo/products_dashboard_repo_impl.dart';
// import 'package:e_commerce/features/add_products/core/services/api_service_dashboard.dart';
// import 'package:get_it/get_it.dart';

// final getItDashboard = GetIt.instance;

// void setupGetItDashboard() {
//   getItDashboard.registerSingleton<ApiServiceDashboard>(ApiServiceDashboard());
//   // Log to check ApiService registration
//   print('ApiService registered: ${getItDashboard<ApiServiceDashboard>()}');

//   getItDashboard.registerSingleton<ProductsRepoDashboard>(
//     ProductsRepoImplDashboard(getItDashboard<ApiServiceDashboard>()),
//   );
//   // Log to check ProductsRepoImpl registration
//   print('ProductsRepo registered: ${getItDashboard<ProductsRepoDashboard>()}');

//   getItDashboard.registerSingleton<ImagesRepoDashboard>(
//     ImagesRepoImplDashboard(getItDashboard<ApiServiceDashboard>()),
//   );
//   // Log to check ImagesRepoImpl registration
//   print('ImagesRepo registered: ${getItDashboard<ImagesRepoDashboard>()}');
// }
