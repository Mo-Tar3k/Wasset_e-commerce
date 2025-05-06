import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class CustomTextFieldForm extends StatefulWidget {
  CustomTextFieldForm({
    super.key,
    required this.labelText,
    required this.textInputType,
    this.suffixIcon,
    this.onSaved,
    this.obscureText = false,
  });

  final String labelText;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final void Function(String?)? onSaved;
  final bool obscureText;

  @override
  _CustomTextFieldFormState createState() => _CustomTextFieldFormState();
}

class _CustomTextFieldFormState extends State<CustomTextFieldForm> {
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<bool?> _isValid = ValueNotifier<bool?>(null);
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _validateInput(_controller.text);
    });
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _isValid.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _validateInput(String value) {
    final trimmedValue = value.trim();
    bool? isValid;

    if (widget.textInputType == TextInputType.number) {
      isValid = RegExp(r'^[0-9]+\.?[0-9]*$').hasMatch(trimmedValue);
    } else if (widget.textInputType == TextInputType.emailAddress) {
      isValid = EmailValidator.validate(trimmedValue);
    } else {
      isValid = null; // عدم إظهار أيقونة الصح أو الخطأ لأي نوع آخر
    }

    _isValid.value = isValid;
  }

  bool _isNumberOrEmailType() {
    return widget.textInputType == TextInputType.emailAddress;
    // || widget.textInputType == TextInputType.number  ;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool?>(
      valueListenable: _isValid,
      builder: (context, isValid, child) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.gray(context),
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color:
                    isDarkMode(context)
                        ? AppColors.lightDarkMode
                        : Colors.grey.withOpacity(0.4),
                blurRadius: 8,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: TextFormField(
            obscureText: widget.obscureText,
            onSaved: widget.onSaved,
            validator: (value) {
              if (value!.isEmpty) {
                return 'This field is required';
              }
              if (widget.textInputType == TextInputType.emailAddress &&
                  !EmailValidator.validate(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
            controller: _controller,
            focusNode: _focusNode,
            keyboardType: widget.textInputType,
            decoration: InputDecoration(
              suffixIcon:
                  (_isNumberOrEmailType() &&
                          (_isFocused || _controller.text.isNotEmpty))
                      ? (isValid == true
                          ? const Icon(Icons.check, color: Colors.green)
                          : const Icon(Icons.close, color: Colors.red))
                      : widget
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
