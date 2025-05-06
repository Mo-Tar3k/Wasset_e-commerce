import 'package:e_commerce/core/helper_funcations/show_error_bar.dart';
import 'package:e_commerce/core/widgets/custom_progres_hud.dart';
import 'package:e_commerce/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:e_commerce/features/auth/presentation/views/widgets/signup_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupViewBodyBlocConsumer extends StatelessWidget {
  const SignupViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          Navigator.pop(context);
        }
        if (state is SignupFailure) {
          showMassgeBar(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomProgresHUD(
          isLoading: state is SignupLoading ? true : false,
          child: SignupViewBody(),
        );
      },
    );
  }
}
