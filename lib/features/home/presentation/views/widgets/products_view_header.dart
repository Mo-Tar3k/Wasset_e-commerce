import 'package:flutter/material.dart';

class ProductsViewHeader extends StatelessWidget {
  const ProductsViewHeader({super.key, required this.productsLength});
  final int productsLength;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$productsLength Products',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const Spacer(),
        // Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        //   decoration: ShapeDecoration(
        //     color: AppColors.white(context),
        //     shape: RoundedRectangleBorder(
        //       side: BorderSide(width: 1, color: const Color(0x66CACECE)),
        //       borderRadius: BorderRadius.circular(4),
        //     ),
        //   ),
        //   child: Image.asset(Assets.assetsImagesFilter),
        // ),
      ],
    );
  }
}
