import 'package:e_commerce/core/helper_funcations/show_error_bar.dart';
import 'package:e_commerce/core/widgets/custom_app_bar.dart';
import 'package:e_commerce/features/auth/presentation/views/signin_view.dart';
import 'package:e_commerce/features/auth/presentation/views/widgets/reset_password_view_body.dart';
import 'package:e_commerce/features/auth/presentation/cubits/reset_password_cubit/reset_password_cubit.dart';
import 'package:e_commerce/core/services/api_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});
  static const routeName = 'reset-password';

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments
            as Map<String, dynamic>; // تعديل هنا
    final email = arguments['email']!;
    final resetToken = arguments['resetToken']!;

    return BlocProvider(
      create: (context) => ResetPasswordCubit(ApiAuthService())..email = email,
      child: Scaffold(
        appBar: CustomBuildAppBar(
          context,
          title: "Reset Password",
          showNotification: false,
          showBackButton: true,
        ),
        body: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          listener: (context, state) {
            if (state is ResetPasswordSuccess) {
              showMassgeBar(context, '✅ Password reset successfully');
              Navigator.pushNamedAndRemoveUntil(
                context,
                SigninView.routeName, // Redirect to SignInView
                (route) => false, // Remove all previous routes
              );
            } else if (state is ResetPasswordFailure) {
              String message = state.message;
              if (message.contains('DioException')) {
                final regex = RegExp(r'message\":\"(.*?)\"');
                final match = regex.firstMatch(message);
                message =
                    match != null
                        ? match.group(1)!
                        : "Password reset failed, please try again, password is too weak";
              }
              showMassgeBar(context, message);
            }
          },
          builder:
              (context, state) => ResetPasswordViewBody(resetToken: resetToken),
        ),
      ),
    );
  }
}
