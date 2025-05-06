import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PaymentItem extends StatelessWidget {
  const PaymentItem({super.key, required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title :',
          style: TextStyle(
            color: AppColors.blac(context),
            fontSize: 13,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
          child: Container(
            decoration: AppDecorations.appContainerDecoration(
              color:
                  isDarkMode(context)
                      ? AppColors.lightDarkMode
                      : Color(0x33D9D9D9),
              borderRadius: BorderRadius.circular(4),
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}

class AppDecorations {
  // Existing methods and properties

  static BoxDecoration appContainerDecoration({
    required Color color,
    required BorderRadius borderRadius,
  }) {
    return BoxDecoration(color: color, borderRadius: borderRadius);
  }
}
