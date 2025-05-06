import 'package:e_commerce/core/widgets/build_app_bar.dart';
import 'package:e_commerce/features/profile/presentation/views/widgets/edit_profile_view_body.dart';
import 'package:flutter/material.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  static const routeName = 'edit-profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: 'Edit Profile',
        showNotification: false,
      ),
      body: EditProfileViewBody(),
    );
  }
}
