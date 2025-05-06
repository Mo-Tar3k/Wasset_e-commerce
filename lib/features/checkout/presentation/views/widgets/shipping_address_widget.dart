import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/features/checkout/domain/entites/order_entity.dart';
import 'package:e_commerce/features/checkout/presentation/views/widgets/payment_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShippingAddressWidget extends StatelessWidget {
  const ShippingAddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PaymentItem(
      title: "Delivery Address",
      child: Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            color: AppColors.blac(context),
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            '${context.read<OrderEntity>().shippingAddressEntity}',
            textAlign: TextAlign.right,
            style: TextStyle(
              color:
                  isDarkMode(context) ? AppColors.lightMode : Color(0xFF4E5556),
              fontSize: 16,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w400,
              height: 1.40,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              // الوصول إلى PageController
              final pageController = context.read<PageController>();
              pageController.animateToPage(
                pageController.page!.toInt() - 1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.edit_location_alt_outlined,
                    color: AppColors.blac(context),
                    size: 20,
                  ),

                  const SizedBox(width: 8),
                  Text(
                    'Edit',
                    style: TextStyle(
                      color: const Color(0xFF949D9E),
                      fontSize: 13,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                      height: 1.70,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
