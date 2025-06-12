import 'package:dartz/dartz.dart';
import 'package:e_commerce/features/add_products/add_product/domain/entities/product_entity_dashboard.dart';
import 'package:e_commerce/features/add_products/core/errors/failures_dashboard.dart';

abstract class ProductsRepoDashboard {
  Future<Either<FailureDashboard, void>> addProduct(
    ProductEntityDashboard addProductInputEntity,
  );
}
