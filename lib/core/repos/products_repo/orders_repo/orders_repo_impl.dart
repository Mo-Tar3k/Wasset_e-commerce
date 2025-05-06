import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failures.dart';
import 'package:e_commerce/core/repos/products_repo/orders_repo/orders_repo.dart';
import 'package:e_commerce/core/services/data_service.dart';
import 'package:e_commerce/core/utils/backend_endpoint.dart';
import 'package:e_commerce/features/checkout/domain/entites/order_entity.dart';
import 'package:e_commerce/features/checkout/presentation/views/data/models/order_model.dart';

class OrdersRepoImpl implements OrdersRepo {
  final DatabaseService firestoreSevices;

  OrdersRepoImpl(this.firestoreSevices);
  @override
  Future<Either<Failure, void>> addOrders({required OrderEntity order}) async {
    try {
      await firestoreSevices.addData(
        path: BackendEndpoint.addOrder,
        data: OrderModel.fromEntity(order).toJson(),
      );
      return const Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
