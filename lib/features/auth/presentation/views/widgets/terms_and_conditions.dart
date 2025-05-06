import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/features/auth/presentation/views/widgets/custom_check_box.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key, required this.onChanged});
  final ValueChanged<bool> onChanged;
  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  bool isTermsAccepted = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCheckBox(
          onChecked: (value) {
            setState(() {
              isTermsAccepted = value;
              widget.onChanged(value);
            });
          },
          isChecked: isTermsAccepted,
        ),
        SizedBox(width: 16),
        // SizedBox(
        //   width:
        //       MediaQuery.sizeOf(context).width - (KHorizontalPadding * 2) - 48,
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'By creating an account, you agree to',
                  style: TextStyle(
                    color: Color(0xFF949D9E),
                    fontSize: 13,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                    height: 1.70,
                  ),
                ),
                TextSpan(
                  text: ' ',
                  style: TextStyle(
                    color: AppColors.lightPrimaryColor,
                    fontSize: 13,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                    height: 1.70,
                  ),
                ),
                TextSpan(
                  text: 'Our Terms and Conditions',
                  style: TextStyle(
                    color: AppColors.lightPrimaryColor,
                    fontSize: 13,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                    height: 1.70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
