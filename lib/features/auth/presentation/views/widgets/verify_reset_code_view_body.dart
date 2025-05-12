import 'package:e_commerce/core/helper_funcations/show_error_bar.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/features/auth/presentation/cubits/reset_password_cubit/reset_password_cubit.dart';

class VerifyResetCodeViewBody extends StatefulWidget {
  const VerifyResetCodeViewBody({super.key});

  @override
  State<VerifyResetCodeViewBody> createState() =>
      _VerifyResetCodeViewBodyState();
}

class _VerifyResetCodeViewBodyState extends State<VerifyResetCodeViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String code = ''; // Initialize with an empty value
  List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 24),
            SizedBox(
              width: 342,
              child: Text(
                'Enter the 6-digit code sent to your email',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF616A6B),
                  fontSize: 16,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                  height: 1.40,
                ),
              ),
            ),
            const SizedBox(height: 29),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 40,
                  child: TextFormField(
                    controller: controllers[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    style: TextStyle(
                      fontSize: 24, // زيادة حجم الأرقام
                      fontWeight: FontWeight.w500, // جعل الأرقام غامقة
                      color: Colors.black, // تغيير اللون إذا أردت
                    ),
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      code =
                          controllers
                              .map((controller) => controller.text)
                              .join();
                      if (value.isNotEmpty && index < 5) {
                        FocusScope.of(context).nextFocus();
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 29),
            CustomButton(
              text: 'Verify Code',
              onPressed: () {
                if (code.length == 6) {
                  context.read<ResetPasswordCubit>().verifyResetCode(code);
                } else {
                  showMassgeBar(context, 'Please enter all 6 digits');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
