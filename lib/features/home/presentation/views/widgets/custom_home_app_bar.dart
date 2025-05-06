import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/helper_funcations/get_user.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/utils/app_images.dart';
import 'package:flutter/material.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 40,
        backgroundImage:
            Image.network(
              getUser().profileImage ?? Assets.assetsImagesProfileImage,
            ).image,
      ),
      title: Text(
        'Welcome',
        textAlign: TextAlign.left,
        style: TextStyle(
          color: isDarkMode(context) ? AppColors.lightMode : Color(0xFF949D9E),
          fontSize: 16,
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w400,
          height: 1.40,
        ),
      ),
      subtitle: Text(
        getUser().name,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: AppColors.blac(context),
          fontSize: 16,
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
