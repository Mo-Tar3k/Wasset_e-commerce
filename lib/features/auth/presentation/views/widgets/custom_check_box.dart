import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/utils/app_images.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  CustomCheckBox({super.key, required this.isChecked, required this.onChecked});
  final bool isChecked;
  final ValueChanged<bool> onChecked;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChecked(!isChecked);
      },
      child: AnimatedContainer(
        width: 24,
        height: 24,
        duration: const Duration(milliseconds: 100),
        decoration: ShapeDecoration(
          color: isChecked ? AppColors.primaryColor : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.50,
              color: isChecked ? Colors.transparent : Color(0xFFBDBDBD),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child:
            isChecked
                ? Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset(Assets.assetsImagesCheckIcon),
                )
                : SizedBox(),
      ),
    );
  }
}
