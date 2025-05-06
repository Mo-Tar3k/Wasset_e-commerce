import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class InActiveStepItem extends StatelessWidget {
  const InActiveStepItem({super.key, required this.index, required this.text});

  final String index;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 10,
          backgroundColor:
              isDarkMode(context) ? AppColors.lightDarkMode : Color(0xFFF2F3F3),
          child: Text(
            index,
            style: TextStyle(
              color: AppColors.blac(context),
              fontSize: 13,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
              height: 1.70,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: Color(0xFFAAAAAA),
            fontSize: 13,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
