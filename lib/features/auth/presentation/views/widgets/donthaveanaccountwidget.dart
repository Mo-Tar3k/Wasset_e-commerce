import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/features/auth/presentation/views/signup_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DontHaveAnAccountWidget extends StatelessWidget {
  const DontHaveAnAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Don't have an account?",
            style: TextStyle(
              color: AppColors.secondaryColor,
              fontSize: 16,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
              height: 1.40,
            ),
          ),
          TextSpan(
            text: ' ',
            style: TextStyle(
              color: Color(0xFF616A6B),
              fontSize: 16,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
              height: 1.40,
            ),
          ),
          TextSpan(
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, SignupView.routeName);
                  },
            text: 'Create an account',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 16,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
              height: 1.40,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
