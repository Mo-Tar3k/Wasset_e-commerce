import 'package:e_commerce/features/home/domain/entites/bottom_navigation_bar_entity.dart';
import 'package:e_commerce/features/home/presentation/views/widgets/active_nav_bar_item.dart';
import 'package:e_commerce/features/home/presentation/views/widgets/in_active_nav_bar_item.dart';
import 'package:flutter/material.dart';

class NavigationBarItem extends StatelessWidget {
  const NavigationBarItem({
    super.key,
    required this.isSelected,
    required this.bottomNavigationBarEntity,
  });
  final bool isSelected;
  final BottomNavigationBarEntity bottomNavigationBarEntity;

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? ActiveItem(
          image: bottomNavigationBarEntity.activeImage,
          name: bottomNavigationBarEntity.name,
        )
        : InActiveItem(image: bottomNavigationBarEntity.inActiveImage);
  }
}
