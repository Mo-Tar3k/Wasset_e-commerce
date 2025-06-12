import 'package:bloc/bloc.dart';
import 'package:e_commerce/features/add_products/add_product/domain/entities/product_entity_dashboard.dart';
import 'package:e_commerce/features/add_products/core/repos/images_repo/images_dashboard_repo.dart';
import 'package:e_commerce/features/add_products/core/repos/product_repo/products_dashboard_repo.dart';
import 'package:meta/meta.dart';
import 'dart:developer'; // Import for logging

part 'add_product_dashboard_state.dart';

class AddProductDashboardCubit extends Cubit<AddProductDashboardState> {
  AddProductDashboardCubit(this.imagesRepo, this.productsRepo)
    : super(AddProductCubitInitial());

  final ImagesRepoDashboard imagesRepo;
  final ProductsRepoDashboard productsRepo;

  Future<void> addProduct(ProductEntityDashboard addProductInputEntity) async {
    emit(AddProductLoading());
    try {
      print('Calling ProductsRepoImpl to add product');
      var result = await productsRepo.addProduct(addProductInputEntity);
      result.fold(
        (f) {
          if (f.message.contains('Service Unavailable')) {
            log(
              'AddProduct Failure: The server is temporarily unavailable. Please try again later.',
            );
          } else if (f.message.contains('Unauthorized')) {
            log(
              'AddProduct Failure: Unauthorized access. Please check your token.',
            );
          } else {
            log('AddProduct Failure: ${f.message}');
          }
          emit(AddProductFailure(f.message));
        },
        (r) {
          emit(AddProductSuccess());
        },
      );
    } catch (e) {
      log('Unexpected Error: $e');
      emit(AddProductFailure('An unexpected error occurred.'));
    }
  }
}
