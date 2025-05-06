import 'dart:io';

import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/utils/app_images.dart';
import 'package:e_commerce/core/widgets/custom_button.dart';
import 'package:e_commerce/core/widgets/custom_text_field.dart';
import 'package:e_commerce/core/widgets/password_field.dart';
import 'package:e_commerce/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:e_commerce/features/auth/presentation/views/widgets/donthaveanaccountwidget.dart';
import 'package:e_commerce/features/auth/presentation/views/widgets/or_divider.dart';
import 'package:e_commerce/features/auth/presentation/views/widgets/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninViewBody extends StatefulWidget {
  const SigninViewBody({super.key});

  @override
  State<SigninViewBody> createState() => _SigninViewBodyState();
}

class _SigninViewBodyState extends State<SigninViewBody> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email, password;
  String role = 'Customer'; // تهيئة role بقيمة افتراضية
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: KHorizontalPadding),
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              SizedBox(height: 24),
              CustomTextFieldForm(
                onSaved: (value) {
                  email = value!;
                },
                labelText: 'Email',
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              PasswordField(
                onSaved: (value) {
                  password = value!;
                },
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot your password ?',
                    style: TextStyle(
                      color: AppColors.lightPrimaryColor,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 33),
              CustomButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    context.read<SigninCubit>().signin(email, password, role);
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
                text: 'Login',
              ),
              SizedBox(height: 33),
              const DontHaveAnAccountWidget(),
              SizedBox(height: 33),
              OrDivider(),
              SizedBox(height: 16),
              SocialLoginButton(
                image: Assets.assetsImagesGoogleIcon,
                title: 'Continue with Google',
                onPressed: () {
                  context.read<SigninCubit>().signWithGoogle();
                },
              ),
              SizedBox(height: 16),
              Platform.isIOS
                  ? Column(
                    children: [
                      SocialLoginButton(
                        image: Assets.assetsImagesAppleIcon,
                        title: 'Continue with Apple',
                        onPressed: () {},
                      ),
                      SizedBox(height: 16),
                    ],
                  )
                  : SizedBox(),
              SocialLoginButton(
                image: Assets.assetsImagesFacebookIcon,
                title: 'Continue with Facebook',
                onPressed: () {
                  context.read<SigninCubit>().signWithFacebook();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
