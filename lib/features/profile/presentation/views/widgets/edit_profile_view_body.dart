import 'package:e_commerce/features/auth/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/core/services/user_local_service.dart';
import 'edit_profile_form.dart';

class EditProfileViewBody extends StatelessWidget {
  const EditProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFDEFEF), Color(0xFFFFFFFF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: FutureBuilder(
            future: UserLocalService.loadUser(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return EditProfileForm(
                user: UserModel.fromEntity(snapshot.data!),
              );
            },
          ),
        ),
      ),
    );
  }
}
