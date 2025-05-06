import 'package:flutter/material.dart';
import 'package:e_commerce/core/entities/product_entity.dart';
import 'package:e_commerce/core/utils/app_colors.dart';

class CardInfoSection extends StatelessWidget {
  final ProductEntity productEntity;
  final VoidCallback onAdd;
  final Animation<double> scaleAnimation;

  const CardInfoSection({
    super.key,
    required this.productEntity,
    required this.onAdd,
    required this.scaleAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? Colors.white : Colors.black87;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              productEntity.name,
              overflow: TextOverflow.ellipsis, // ✅ قص النص لو طويل
              maxLines: 1, // ✅ سطر واحد فقط
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Cairo',
                color: textColor,
              ),
            ),
          ),

          const SizedBox(height: 4),
          Text(
            '${productEntity.price} L.E / Piece',
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontFamily: 'Cairo',
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildServiceProviderImage(productEntity.serviceProviderImage),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  productEntity.serviceProviderName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Cairo',
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ScaleTransition(
            scale: scaleAnimation,
            child: GestureDetector(
              onTap: onAdd,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, color: Colors.white, size: 20),
                    SizedBox(width: 6),
                    Text(
                      "Add",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceProviderImage(String? imageUrl) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return CircleAvatar(radius: 12, backgroundImage: NetworkImage(imageUrl));
    } else {
      return const CircleAvatar(
        radius: 12,
        backgroundColor: Colors.grey,
        child: Icon(Icons.broken_image, color: Colors.white, size: 14),
      );
    }
  }
}
