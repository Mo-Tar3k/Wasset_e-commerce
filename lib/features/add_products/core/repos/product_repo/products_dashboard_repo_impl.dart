import 'dart:developer' as developer; // Import for logging

import 'package:dartz/dartz.dart';

import 'package:dio/dio.dart';
import 'package:e_commerce/features/add_products/add_product/domain/entities/product_entity_dashboard.dart';
import 'package:e_commerce/features/add_products/core/errors/failures_dashboard.dart';
import 'package:e_commerce/features/add_products/core/repos/product_repo/products_dashboard_repo.dart';
import 'package:e_commerce/features/add_products/core/services/api_service_dashboard.dart';

class ProductsRepoImplDashboard implements ProductsRepoDashboard {
  final ApiServiceDashboard apiService;

  ProductsRepoImplDashboard(this.apiService) {
    print('ApiService received in ProductsRepoImpl: $apiService');
  }

  @override
  Future<Either<FailureDashboard, void>> addProduct(
    ProductEntityDashboard addProductInputEntity,
  ) async {
    try {
      final formData = {
        'Name': addProductInputEntity.name,
        'Description': addProductInputEntity.description,
        'Price':
            addProductInputEntity.price
                .toDouble(), // Ensure Price is cast to double
        'category': addProductInputEntity.category,
        'image': await MultipartFile.fromFile(addProductInputEntity.image.path),
      };

      // Use ApiService to send the data
      print('Calling ApiService.addProduct with data: $formData');
      await apiService.addProduct(
        image: addProductInputEntity.image,
        name: addProductInputEntity.name,
        description: addProductInputEntity.description,
        price:
            addProductInputEntity.price
                .toDouble(), // Ensure Price is cast to double
        category: int.parse(addProductInputEntity.category),
      );
      return const Right(null);
    } catch (e) {
      developer.log('ProductsRepoImpl Error: $e'); // Log the error
      return Left(ServerFailureDashboard("Failed to add product: $e"));
    }
  }
}
