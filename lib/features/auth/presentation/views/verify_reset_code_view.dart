import 'package:e_commerce/core/helper_funcations/show_error_bar.dart';
import 'package:e_commerce/core/widgets/custom_app_bar.dart';
import 'package:e_commerce/features/auth/presentation/views/widgets/verify_reset_code_view_body.dart';
import 'package:e_commerce/features/auth/presentation/cubits/reset_password_cubit/reset_password_cubit.dart';
import 'package:e_commerce/core/services/api_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyResetCodeView extends StatelessWidget {
  const VerifyResetCodeView({super.key});
  static const routeName = 'verify-reset-code';

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final email = arguments?['email'];

    return BlocProvider(
      create: (context) => ResetPasswordCubit(ApiAuthService())..email = email,
      child: Scaffold(
        appBar: CustomBuildAppBar(
          context,
          title: "Verify Reset Code",
          showNotification: false,
          showBackButton: true,
        ),
        body: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          listener: (context, state) {
            if (state is ResetPasswordCodeVerified) {
              showMassgeBar(context, '✅ Code verified successfully');
              Navigator.pushNamed(
                context,
                'reset-password',
                arguments: {'email': email, 'resetToken': state.resetToken},
              );
            } else if (state is ResetPasswordFailure) {
              String message = state.message;

              if (message.contains('DioException')) {
                final regex = RegExp(r'message\":\"(.*?)\"');
                final match = regex.firstMatch(message);
                message =
                    match != null
                        ? match.group(1)!
                        : "Code verification failed, please try again";
              }

              showMassgeBar(context, message);
            }
          },
          builder: (context, state) => const VerifyResetCodeViewBody(),
        ),
      ),
    );
  }
}
