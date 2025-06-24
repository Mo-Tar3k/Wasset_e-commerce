import 'package:bloc/bloc.dart';
import 'package:e_commerce/core/repos/products_repo/orders_repo/orders_repo.dart';
import 'package:e_commerce/core/services/get_it_service.dart';
import 'package:e_commerce/features/checkout/domain/entites/order_entity.dart';
import 'package:e_commerce/features/home/presentation/views/cubits/cart_cubit/cart_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:e_commerce/core/services/shared_preferences_singleton.dart';

part 'add_order_state.dart';

class AddOrderCubit extends Cubit<AddOrderState> {
  AddOrderCubit(this.ordersRepo) : super(AddOrderInitial());

  final OrdersRepo ordersRepo;

  Future<void> addOrder({required OrderEntity order}) async {
    emit(AddOrderLoading());
    print("🚀 [AddOrderCubit] Started addOrder");

    try {
      final token = Prefs.getString('token');
      if (token == null) {
        print("❌ [AddOrderCubit] Token is null");
        emit(const AddOrderFailure("User token not found"));
        return;
      }

      final result = await ordersRepo.addOrders(order: order, token: token);

      result.fold(
        (failure) {
          print("❌ [AddOrderCubit] Failure: ${failure.message}");
          emit(AddOrderFailure(failure.message));
        },
        (success) {
          print("✅ [AddOrderCubit] Success");

          // ✅ امسح الكارت بعد نجاح الطلب
          getIt<CartCubit>().loadCart(); // أو clearCart() لو عندك

          emit(AddOrderSuccess());
        },
      );
    } catch (e) {
      print("❌ [AddOrderCubit] Uncaught error: $e");
      emit(const AddOrderFailure("Unexpected error occurred"));
    }
  }
}
