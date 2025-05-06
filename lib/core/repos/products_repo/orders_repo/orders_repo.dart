import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failures.dart';
import 'package:e_commerce/features/checkout/domain/entites/order_entity.dart';

abstract class OrdersRepo {
  Future<Either<Failure, void>> addOrders({required OrderEntity order});
}
