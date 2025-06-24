import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failures.dart';
import 'package:e_commerce/core/repos/products_repo/orders_repo/orders_repo.dart';
import 'package:e_commerce/features/checkout/domain/entites/order_entity.dart';
import 'package:e_commerce/features/payment/presentation/views/data/models/repos/payment_repo_impl.dart';

class OrdersRepoImpl implements OrdersRepo {
  final PaymentRepoImpl paymentRepo;

  OrdersRepoImpl({PaymentRepoImpl? injectedRepo})
    : paymentRepo =
          injectedRepo ?? (throw Exception("❌ PaymentRepoImpl was null")) {
    print("✅ OrdersRepoImpl constructed with paymentRepo = $paymentRepo");
  }

  @override
  Future<Either<Failure, void>> addOrders({
    required OrderEntity order,
    required String token,
  }) async {
    try {
      print("🧠 [OrdersRepoImpl] calling processPayment...");
      await paymentRepo.processPayment(order, token);
      print("✅ [OrdersRepoImpl] payment + order succeeded");
      return const Right(null);
    } catch (e) {
      print("❌ [OrdersRepoImpl] error: $e");
      return Left(ServerFailure(e.toString()));
    }
  }
}
