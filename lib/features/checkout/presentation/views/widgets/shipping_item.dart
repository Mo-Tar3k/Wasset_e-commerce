import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ShippingItem extends StatelessWidget {
  const ShippingItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.isSelected,
    required this.onTap,
  });
  final String title, subtitle, price;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),

        padding: const EdgeInsets.only(
          top: 16,
          left: 13,
          right: 28,
          bottom: 16,
        ),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color:
              isDarkMode(context) ? AppColors.lightDarkMode : Color(0x33D9D9D9),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 2,
              color: isSelected ? AppColors.primaryColor : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isSelected
                  ? const ActiveShippingItemDot()
                  : const InActiveShippingItemDot(),
              const SizedBox(width: 18),

              /// Expanded علشان ياخد المساحة كلها اللي فاضلة قبل السعر
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.blac(context),
                        fontSize: 15,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w600,
                        height: 1.70,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.blac(context),
                        fontSize: 13,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w400,
                        height: 1.60,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              /// السعر: حطيناه في Container بحجم مناسب
              Center(
                child: Text(
                  price,
                  style: TextStyle(
                    color:
                        isSelected
                            ? AppColors.primaryColor
                            : isDarkMode(context)
                            ? AppColors.lightMode
                            : Colors.black.withAlpha(128),
                    fontSize: 16,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InActiveShippingItemDot extends StatelessWidget {
  const InActiveShippingItemDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: ShapeDecoration(
        shape: OvalBorder(
          side: BorderSide(width: 1, color: const Color(0xFF949D9E)),
        ),
      ),
    );
  }
}

class ActiveShippingItemDot extends StatelessWidget {
  const ActiveShippingItemDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: ShapeDecoration(
        color: AppColors.primaryColor,
        shape: OvalBorder(
          side: BorderSide(width: 4, color: AppColors.gray(context)),
        ),
      ),
    );
  }
}
