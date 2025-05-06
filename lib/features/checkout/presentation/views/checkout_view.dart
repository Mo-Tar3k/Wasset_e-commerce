import 'package:e_commerce/core/helper_funcations/get_user.dart';
import 'package:e_commerce/core/repos/products_repo/orders_repo/orders_repo.dart';
import 'package:e_commerce/core/services/get_it_service.dart';
import 'package:e_commerce/core/widgets/build_app_bar.dart';
import 'package:e_commerce/features/checkout/domain/entites/order_entity.dart';
import 'package:e_commerce/features/checkout/domain/entites/shipping_address_entity.dart';
import 'package:e_commerce/features/checkout/presentation/manger/add_order_cubit/add_order_cubit.dart';
import 'package:e_commerce/features/checkout/presentation/views/widgets/add_order_cubit_bloc_builder.dart';
import 'package:e_commerce/features/checkout/presentation/views/widgets/checkout_view_body.dart';
import 'package:e_commerce/features/home/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key, required this.cartItems});

  static const String routeName = 'checkout';
  final List<CartModel> cartItems;

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  late final OrderEntity orderEntity;

  @override
  void initState() {
    super.initState();
    orderEntity = OrderEntity(
      widget.cartItems, // ✅ positional argument
      uID: getUser().uId,
      shippingAddressEntity: ShippingAddressEntity(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddOrderCubit(getIt.get<OrdersRepo>()),
      child: Scaffold(
        appBar: buildAppBar(
          context,
          title: "Delivery",
          showNotification: false,
        ),
        body: Provider.value(
          value: orderEntity,
          child: AddOrderCubitBlocBuilder(child: CheckoutViewBody()),
        ),
      ),
    );
  }
}
