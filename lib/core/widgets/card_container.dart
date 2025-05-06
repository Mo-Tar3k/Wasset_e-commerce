import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final List<Widget> children;
  const CardContainer({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color cardColor = isDark ? AppColors.lightDarkMode : Colors.white;

    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // ✅ علشان ما يحصلش Overflow
        children: children,
      ),
    );
  }
}
