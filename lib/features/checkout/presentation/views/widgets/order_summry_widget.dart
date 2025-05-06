import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/features/checkout/domain/entites/order_entity.dart';
import 'package:e_commerce/features/checkout/presentation/views/widgets/payment_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderSummryWidget extends StatelessWidget {
  const OrderSummryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PaymentItem(
          title: "Order Summary",
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 4,
                ),
                child: Row(
                  children: [
                    Text(
                      'Subtotal :',
                      style: TextStyle(
                        color:
                            isDarkMode(context)
                                ? AppColors.lightMode
                                : Color(0xFF4E5556),
                        fontSize: 13,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w400,
                        height: 1.60,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${context.read<OrderEntity>().calculateTotalPrice()} L.E',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: AppColors.blac(context),
                        fontSize: 16,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w600,
                        height: 1.40,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    Text(
                      'Delivery :',
                      style: TextStyle(
                        color:
                            isDarkMode(context)
                                ? AppColors.lightMode
                                : Color(0xFF4E5556),
                        fontSize: 13,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w400,
                        height: 1.60,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '30 L.E',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color:
                            isDarkMode(context)
                                ? AppColors.lightMode
                                : Color(0xFF4E5556),
                        fontSize: 13,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w400,
                        height: 1.60,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 9),
              Divider(
                color:
                    isDarkMode(context)
                        ? AppColors.lightMode
                        : Color(0xFFCACECE),
                thickness: .5,
              ),
              SizedBox(height: 9),
              Padding(
                padding: const EdgeInsets.only(
                  right: 12.0,
                  left: 12.0,
                  bottom: 8,
                ),
                child: Row(
                  children: [
                    Text(
                      'Total :',
                      style: TextStyle(
                        color: AppColors.blac(context),
                        fontSize: 16,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${context.read<OrderEntity>().calculateTotalPrice() + 30} L.E',
                      style: TextStyle(
                        color: AppColors.blac(context),
                        fontSize: 16,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
