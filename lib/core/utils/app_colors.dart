import 'package:e_commerce/constants.dart';
import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primaryColor = Color(0xFFF05D3B);
  static const Color lightPrimaryColor = Color.fromARGB(255, 226, 111, 85);
  static const Color secondaryColor = Color(0xFF374151);
  static const Color veryLightSecondaryColor = Color(0xFFF8C76D);
  static const Color lightSecondaryColor = Color(0xFFF4A91F);
  static const Color lightMode = Colors.white;
  static const Color darkMode = Color(0xFF141218);
  static const Color lightDarkMode = Color(0xFF1E1E1E);
  static Color white(BuildContext context) =>
      isDarkMode(context) ? AppColors.darkMode : AppColors.lightMode;
  static Color blac(BuildContext context) =>
      isDarkMode(context) ? AppColors.lightMode : AppColors.darkMode;

  static Color gray(BuildContext context) =>
      isDarkMode(context) ? AppColors.lightDarkMode : AppColors.lightMode;
}
