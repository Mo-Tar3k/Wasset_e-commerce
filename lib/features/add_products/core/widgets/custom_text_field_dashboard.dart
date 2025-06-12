import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFieldFormDashboard extends StatefulWidget {
  CustomTextFieldFormDashboard({
    super.key,
    required this.labelText,
    required this.textInputType,
    this.suffixIcon,
    this.onSaved,
    this.validator,
    this.obscureText = false,
    this.maxLines = 1,
  });

  final String labelText;
  final TextInputType textInputType;
  final int? maxLines;
  final Widget? suffixIcon;
  final void Function(String?)? onSaved;
  final bool obscureText;
  final String? Function(String?)? validator;

  @override
  _CustomTextFieldFormDashboardState createState() =>
      _CustomTextFieldFormDashboardState();
}

class _CustomTextFieldFormDashboardState
    extends State<CustomTextFieldFormDashboard> {
  final ValueNotifier<bool?> _isValid = ValueNotifier<bool?>(null);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool?>(
      valueListenable: _isValid,
      builder: (context, isValid, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 8,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: TextFormField(
            maxLines: widget.maxLines,
            obscureText: widget.obscureText,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'هذا الحقل مطلوب';
              }
              if (widget.textInputType == TextInputType.number) {
                try {
                  num.parse(value);
                } catch (e) {
                  return 'القيمة المدخلة غير صحيحة';
                }
              }
              return null;
            },
            onSaved: widget.onSaved,

            keyboardType: widget.textInputType,
            decoration: InputDecoration(
              suffixIcon:
                  widget
                      .suffixIcon, // عرض suffixIcon فقط إذا لم يكن الحقل رقمًا أو بريدًا إلكترونيًا
              fillColor: AppColors.gray(context),
              filled: true,
              labelText: widget.labelText,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        );
      },
    );
  }
}
