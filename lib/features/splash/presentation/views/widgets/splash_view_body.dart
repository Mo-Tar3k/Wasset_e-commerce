import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/services/shared_preferences_singleton.dart';
import 'package:e_commerce/core/services/user_local_service.dart';
import 'package:e_commerce/core/utils/app_images.dart';
import 'package:e_commerce/features/auth/presentation/views/signin_view.dart';
import 'package:e_commerce/features/home/presentation/views/main_view.dart';
import 'package:e_commerce/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:flutter/material.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      excuteNavigation(context);
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.assetsImagesAppLogo),
            const SizedBox(height: 20),
            const Text('Loading...', style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }

  void excuteNavigation(BuildContext context) async {
    bool isOnBoardingViewSeen = Prefs.getBool(kIsOnBoardingViewSeen);

    await Future.delayed(const Duration(seconds: 1));

    if (isOnBoardingViewSeen) {
      final user = await UserLocalService.loadUser();
      // bool isLoggedIn = FirebaseAuthService().isLoggedIn();

      // if (user != null && isLoggedIn) {
      if (user != null) {
        // المستخدم مسجل دخول وعنده بيانات محفوظة
        Navigator.pushReplacementNamed(context, MainView.routeName);
      } else {
        // مش مسجل أو معندوش بيانات
        Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
      }
    } else {
      Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
    }
  }
}
