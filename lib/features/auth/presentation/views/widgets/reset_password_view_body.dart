import 'package:e_commerce/core/widgets/custom_button.dart';
import 'package:e_commerce/core/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/features/auth/presentation/cubits/reset_password_cubit/reset_password_cubit.dart';

class ResetPasswordViewBody extends StatefulWidget {
  final String resetToken;
  const ResetPasswordViewBody({super.key, required this.resetToken});

  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String newPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(height: 24),
            SizedBox(
              width: 342,
              child: Text(
                'Enter your new password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF0C0D0D),
                  fontSize: 19,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                  height: 1.40,
                ),
              ),
            ),
            const SizedBox(height: 29),
            PasswordField(
              labelText: 'New Password',
              onSaved: (value) => newPassword = value!,
            ),
            const SizedBox(height: 29),

            CustomButton(
              text: 'Reset Password',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  context.read<ResetPasswordCubit>().resetPassword(
                    widget.resetToken,
                    newPassword,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
