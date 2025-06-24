import 'package:e_commerce/features/payment/presentation/views/widgets/payment_success_view_body.dart';
import 'package:flutter/material.dart';

class PaymentSuccessView extends StatelessWidget {
  final String orderId;
  const PaymentSuccessView({super.key, required this.orderId});

  static const routeName = 'payment-view-success';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: PaymentSuccessViewBody(orderId: orderId));
  }
}
