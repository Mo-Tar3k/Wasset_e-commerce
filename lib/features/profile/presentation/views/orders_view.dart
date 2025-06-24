import 'package:e_commerce/core/widgets/build_app_bar.dart';
import 'package:e_commerce/features/profile/presentation/views/widgets/orders_view_body.dart';
import 'package:flutter/material.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  static const routeName = 'orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'My Orders', showNotification: false),
      body: OrdersViewBody(),
    );
  }
}
