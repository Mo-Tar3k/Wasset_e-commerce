import 'package:e_commerce/features/profile/domain/order_customer_entity.dart';
import 'package:e_commerce/features/profile/presentation/views/cubits/orders_cubit.dart';
import 'package:e_commerce/features/profile/presentation/views/cubits/orders_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersViewBody extends StatefulWidget {
  const OrdersViewBody({super.key});

  @override
  State<OrdersViewBody> createState() => _OrdersViewBodyState();
}

class _OrdersViewBodyState extends State<OrdersViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<OrdersCubit>().fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state is OrdersLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is OrdersLoaded) {
          return ListView.builder(
            itemCount: state.orders.length,
            itemBuilder: (context, index) {
              final OrderCustomerEntity order = state.orders[index];
              return ListTile(
                title: Text(order.title),
                subtitle: Text("Order ID: ${order.id}"),
              );
            },
          );
        } else if (state is OrdersError) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
