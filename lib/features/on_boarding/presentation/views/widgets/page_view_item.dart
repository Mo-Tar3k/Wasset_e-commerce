import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/services/shared_preferences_singleton.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/utils/app_images.dart';
import 'package:e_commerce/features/auth/presentation/views/signin_view.dart';
import 'package:flutter/material.dart';

class PageViewItem extends StatelessWidget {
  PageViewItem({
    super.key,
    required this.imagePath,
    required this.background,
    required this.subtitle,
    required this.title,
    required this.isVisible,
  });

  final String imagePath, background, subtitle;
  final Widget title;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(Assets.assetsImagesBack1, fit: BoxFit.fill),
              ),
              Positioned(
                bottom: -50,
                left: 0,
                right: 0,
                child: Image.asset(Assets.assetsImagesOnboarding1),
              ),
              GestureDetector(
                onTap: () {
                  Prefs.setBool(kIsOnBoardingViewSeen, true);
                  Navigator.of(
                    context,
                  ).pushReplacementNamed(SigninView.routeName);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Visibility(
                    visible: isVisible,
                    child: Container(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.primaryColor,
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 64),
        DefaultTextStyle(
          style: TextStyle(
            decoration: TextDecoration.none,
            color: Colors.black, // Set the color for the title
            fontSize: 24, // Set the font size for the title
          ),
          child: title,
        ),
        SizedBox(height: 0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF4B5563),
              fontSize: 17,
              fontFamily: 'ABeeZee',
              fontWeight: FontWeight.w400,
              height: 1.50,
              letterSpacing: -0.41,
            ),
          ),
        ),
      ],
    );
  }
}
