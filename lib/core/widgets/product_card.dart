import 'package:e_commerce/core/widgets/card_container.dart';
import 'package:e_commerce/core/widgets/card_image.dart';
import 'package:e_commerce/core/widgets/card_info_section.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/core/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.productEntity,
    required this.onAdd,
    required this.onTap,
    required this.scaleAnimation,
  });

  final ProductEntity productEntity;
  final VoidCallback onAdd;
  final VoidCallback onTap;
  final Animation<double> scaleAnimation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CardContainer(
        children: [
          CardImage(imageUrl: productEntity.imageUrl),
          CardInfoSection(
            productEntity: productEntity,
            onAdd: onAdd,
            scaleAnimation: scaleAnimation,
          ),
        ],
      ),
    );
  }
}
