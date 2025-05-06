import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/helper_funcations/show_error_bar.dart';
import 'package:e_commerce/core/widgets/custom_button.dart';
import 'package:e_commerce/core/widgets/password_field.dart';
import 'package:e_commerce/core/widgets/role_dropdown_field.dart';
import 'package:e_commerce/core/widgets/custom_text_field.dart';
import 'package:e_commerce/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:e_commerce/features/auth/presentation/views/widgets/haveanaccount.dart';
import 'package:e_commerce/features/auth/presentation/views/widgets/terms_and_conditions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  late String email, password, userName, phoneNumber;
  String role = 'Customer'; // تهيئة role بقيمة افتراضية
  late bool isTermsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: KHorizontalPadding),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            autovalidateMode: _autovalidateMode,
            child: Column(
              children: [
                SizedBox(height: 24),
                CustomTextFieldForm(
                  onSaved: (value) {
                    userName = value!;
                  },
                  labelText: 'Full Name',
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 16),
                CustomTextFieldForm(
                  onSaved: (value) {
                    email = value!.trim();
                  },
                  labelText: 'Email',
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),
                CustomTextFieldForm(
                  onSaved: (value) {
                    phoneNumber = value!.trim();
                  },
                  labelText: 'Phone Number',
                  textInputType: TextInputType.phone,
                ),
                SizedBox(height: 16),
                PasswordField(
                  onSaved: (value) {
                    password = value!;
                  },
                ),
                SizedBox(height: 16),
                RoleDropdownField(
                  labelText: 'Role',
                  onChanged: (value) {
                    role = value!;
                  },
                ),
                SizedBox(height: 16),
                TermsAndConditions(
                  onChanged: (value) {
                    isTermsAccepted = value;
                  },
                ),
                SizedBox(height: 30),
                CustomButton(
                  text: 'Sign Up',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // إذا كانت البيانات صحيحة
                      formKey.currentState!.save();
                      // اكتب الكود الخاص بالتسجيل هنا
                      if (isTermsAccepted) {
                        context
                            .read<SignupCubit>()
                            .createUserWithEmailAndPassword(
                              email, // تأكد من تمرير البريد الإلكتروني الصحيح
                              password, // تأكد من تمرير كلمة المرور الصحيحة
                              userName,
                              role,
                              phoneNumber,
                            );
                      } else {
                        showMassgeBar(
                          context,
                          'You must accept the terms and conditions',
                        );
                      }
                    } else {
                      // إذا كانت البيانات غير صحيحة
                      setState(() {
                        _autovalidateMode = AutovalidateMode.always;
                      });
                    }
                  },
                ),
                SizedBox(height: 26),
                HaveAnAccountWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
