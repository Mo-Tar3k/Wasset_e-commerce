import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ActiveItem extends StatelessWidget {
  const ActiveItem({super.key, required this.image, required this.name});
  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(right: 16),
        decoration: ShapeDecoration(
          color: AppColors.gray(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,

              decoration: ShapeDecoration(
                color: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Center(child: Image.asset(image)),
            ),
            SizedBox(width: 4),
            Flexible(
              child: Text(
                name,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 12,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  height: 1.40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
