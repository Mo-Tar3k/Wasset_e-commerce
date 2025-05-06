import 'package:e_commerce/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, this.onSaved});
  final void Function(String?)? onSaved;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return CustomTextFieldForm(
      obscureText: obscureText,
      onSaved: widget.onSaved,

      suffixIcon: GestureDetector(
        onTap: () {
          obscureText = !obscureText;
          setState(() {});
        },
        child:
            obscureText
                ? Icon(Icons.remove_red_eye, color: Color(0xFFBDBDBD))
                : Icon(Icons.visibility_off, color: Color(0xFFBDBDBD)),
      ),
      labelText: 'Password',
      textInputType: TextInputType.visiblePassword,
    );
  }
}
