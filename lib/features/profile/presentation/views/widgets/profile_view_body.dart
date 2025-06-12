import 'package:e_commerce/core/services/get_it_service.dart';
import 'package:e_commerce/core/services/user_local_service.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/features/add_products/add_product/presentation/views/add_product_dashboard_view.dart';
import 'package:e_commerce/features/auth/data/domain/repos/auth_repo.dart';
import 'package:e_commerce/features/auth/data/model/user_model.dart';
import 'package:e_commerce/features/auth/presentation/views/signin_view.dart';
import 'package:e_commerce/features/profile/presentation/views/about_us_view.dart';
import 'package:e_commerce/features/profile/presentation/views/edit_profile_view.dart';
import 'package:e_commerce/features/profile/presentation/views/contact_us_view.dart';
import 'package:e_commerce/features/profile/presentation/views/widgets/profile_header.dart';
import 'package:e_commerce/features/profile/presentation/views/widgets/profile_section.dart';
import 'package:flutter/material.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  UserModel? _user;

  Future<void> loadUser() async {
    final userEntity = await UserLocalService.loadUser();
    if (userEntity != null) {
      setState(() => _user = UserModel.fromEntity(userEntity));
    }
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (_user != null)
                  ProfileHeader(user: _user!), // تمرير البيانات
                const SizedBox(height: 16),
                ProfileSection(
                  title: 'General',
                  items: [
                    {
                      'icon': Icons.person,
                      'label': 'Profile',
                      'onTap': () async {
                        final result = await Navigator.pushNamed(
                          context,
                          EditProfileView.routeName,
                        );

                        if (result == true) {
                          loadUser(); // يعيد تحميل البيانات بعد التعديل
                        }
                      },
                    },

                    if (_user?.role == 'serviceProvider')
                      {
                        'icon': Icons.add_business_outlined,
                        'label': 'Add Products',
                        'onTap': () {
                          Navigator.pushNamed(
                            context,
                            AddProductDashboardView.routeName,
                          );
                        },
                      },

                    const {'icon': Icons.shopping_bag, 'label': 'Orders'},
                    const {'icon': Icons.settings, 'label': 'Mode'},
                  ],
                ),
                const SizedBox(height: 16),
                ProfileSection(
                  title: 'Help',
                  items: [
                    {
                      'icon': Icons.info,
                      'label': 'About Us',
                      'onTap':
                          () => Navigator.pushNamed(
                            context,
                            AboutUsView.routeName,
                          ),
                    },
                    {
                      'icon': Icons.mail,
                      'label': 'Contact Us',
                      'onTap':
                          () => Navigator.pushNamed(
                            context,
                            ContactUsView.routeName,
                          ),
                    },
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: AppColors.lightPrimaryColor.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: AppColors.primaryColor),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () async {
                try {
                  await getIt<AuthRepo>().logout();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    SigninView.routeName,
                    (route) => false,
                  );
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Logout failed: $e')));
                }
              },

              icon: Icon(Icons.logout, color: AppColors.primaryColor),
              label: Text(
                'Logout',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
