import 'package:e_commerce/core/services/get_it_service.dart';
import 'package:e_commerce/core/widgets/custom_app_bar.dart';
import 'package:e_commerce/features/auth/presentation/views/widgets/signup_view_body_bloc_consumer.dart';
import 'package:e_commerce/features/auth/data/domain/repos/auth_repo.dart';
import 'package:e_commerce/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});
  static const routeName = 'signup';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(getIt<AuthRepo>()),
      child: Scaffold(
        appBar: CustomBuildAppBar(
          context,
          title: "Signup",
          showNotification: false,
        ),
        body: SignupViewBodyBlocConsumer(),
      ),
    );
  }
}
