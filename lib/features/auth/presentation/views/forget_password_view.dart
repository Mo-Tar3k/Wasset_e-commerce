import 'package:e_commerce/core/helper_funcations/show_error_bar.dart';
import 'package:e_commerce/core/widgets/custom_app_bar.dart';
import 'package:e_commerce/features/auth/presentation/views/widgets/forget_password_view_body.dart';
import 'package:e_commerce/features/auth/presentation/cubits/reset_password_cubit/reset_password_cubit.dart';
import 'package:e_commerce/core/services/api_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});
  static const routeName = 'forget-password';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(ApiAuthService()),
      child: Scaffold(
        appBar: CustomBuildAppBar(
          context,
          title: "Forget Password",
          showNotification: false,
          showBackButton: true,
        ),
        body: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          listener: (context, state) {
            if (state is ResetPasswordEmailSent) {
              showMassgeBar(context, '✅ Reset code sent to your email');
              Navigator.pushNamed(
                context,
                'verify-reset-code',
                arguments: {'email': context.read<ResetPasswordCubit>().email},
              );
            } else if (state is ResetPasswordFailure) {
              String message = state.message;
              if (message.contains('DioException')) {
                final regex = RegExp(r'message\":\"(.*?)\"');
                final match = regex.firstMatch(message);
                message =
                    match != null
                        ? match.group(1)!
                        : "Failed to send reset code, please try again";
              }
              showMassgeBar(context, message);
            }
          },
          builder: (context, state) => const ForgetPasswordViewBody(),
        ),
      ),
    );
  }
}
