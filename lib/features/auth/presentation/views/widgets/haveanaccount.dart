import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HaveAnAccountWidget extends StatelessWidget {
  const HaveAnAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Have an account?",
            style: TextStyle(
              color: AppColors.blac(context),
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
                    Navigator.pop(context);
                  },
            text: 'Sign in',
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
