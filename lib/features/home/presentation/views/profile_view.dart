import 'package:e_commerce/features/profile/presentation/views/widgets/profile_view_body.dart';
import 'package:e_commerce/features/theme/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>.value(
      value: BlocProvider.of<ThemeCubit>(
        context,
      ), // Pass the existing ThemeCubit
      child: const Scaffold(body: ProfileViewBody()),
    );
  }
}
