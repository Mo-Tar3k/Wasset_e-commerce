import 'package:e_commerce/core/widgets/custom_button.dart';
import 'package:e_commerce/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/features/auth/presentation/cubits/reset_password_cubit/reset_password_cubit.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String email;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  width: 300,
                  child: Text(
                    'Enter your email address to receive a reset code',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF616A6B),
                      fontSize: 16,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                      height: 1.40,
                    ),
                  ),
                ),
                const SizedBox(height: 31),
                CustomTextFieldForm(
                  labelText: 'Email',
                  textInputType: TextInputType.emailAddress,
                  onSaved: (value) => email = value!,
                ),
                const SizedBox(height: 30),
                CustomButton(
                  text: 'Send Reset Code',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      context.read<ResetPasswordCubit>().forgotPassword(email);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
