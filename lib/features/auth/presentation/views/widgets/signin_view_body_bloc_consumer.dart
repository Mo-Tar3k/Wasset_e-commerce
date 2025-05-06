import 'package:e_commerce/core/helper_funcations/show_error_bar.dart';
import 'package:e_commerce/core/widgets/custom_progres_hud.dart';
import 'package:e_commerce/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:e_commerce/features/auth/presentation/views/widgets/signin_view_body.dart';
import 'package:e_commerce/features/home/presentation/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class signinviewbodyblocconsumer extends StatelessWidget {
  const signinviewbodyblocconsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state is SigninSuccess) {
          Navigator.pushNamed(context, MainView.routeName);
        }
        if (state is SigninFailure) {
          showMassgeBar(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomProgresHUD(
          isLoading: state is SigninLoading ? true : false,
          child: SigninViewBody(),
        );
      },
    );
  }
}
