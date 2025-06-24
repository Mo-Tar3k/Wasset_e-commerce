import 'package:e_commerce/features/profile/domain/get_orders_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUseCase getOrdersUseCase;

  OrdersCubit(this.getOrdersUseCase) : super(OrdersInitial());

  void fetchOrders() async {
    emit(OrdersLoading());

    try {
      final orders = await getOrdersUseCase();
      emit(OrdersLoaded(orders));
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }
}
