import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/features/home/domain/entites/bottom_navigation_bar_entity.dart';
import 'package:e_commerce/features/home/presentation/views/widgets/naivation_bar_theme.dart';
import 'package:flutter/material.dart';

class CustomButtomNavigationBar extends StatefulWidget {
  const CustomButtomNavigationBar.CustomButtonNavigationBar({
    super.key,
    required this.onItemTapped,
  });
  final ValueChanged<int> onItemTapped;

  @override
  State<CustomButtomNavigationBar> createState() =>
      _CustomButtomNavigationBarState();
}

class _CustomButtomNavigationBarState extends State<CustomButtomNavigationBar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 70,
      decoration: ShapeDecoration(
        color: AppColors.white(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 25,
            offset: Offset(0, -2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children:
            bottomNavigationBarItems.asMap().entries.map((e) {
              var index = e.key;
              var entity = e.value;
              return Expanded(
                flex: index == selectedIndex ? 3 : 2,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      widget.onItemTapped(index);
                    });
                  },
                  child: NavigationBarItem(
                    isSelected: index == selectedIndex,
                    bottomNavigationBarEntity: entity,
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
