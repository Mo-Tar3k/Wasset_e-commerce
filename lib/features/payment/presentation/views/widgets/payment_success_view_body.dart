import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/utils/app_images.dart';
import 'package:e_commerce/core/widgets/custom_button.dart';
import 'package:e_commerce/features/home/presentation/views/main_view.dart';
import 'package:flutter/material.dart';

class PaymentSuccessViewBody extends StatelessWidget {
  final String orderId;

  const PaymentSuccessViewBody({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Assets.assetsImagesSucssesPay, height: 120),
          const SizedBox(height: 35),
          const Text(
            'Payment Successful!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Order Number: #$orderId',
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(MainView.routeName, (route) => false);
              },
              text: 'View Orders',
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(MainView.routeName, (route) => false);
            },
            child: Text(
              'Back to Home',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
