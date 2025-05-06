import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ActiveStepItem extends StatelessWidget {
  const ActiveStepItem({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 11.5,
          backgroundColor: AppColors.primaryColor,
          child: const Icon(Icons.check, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 13,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
