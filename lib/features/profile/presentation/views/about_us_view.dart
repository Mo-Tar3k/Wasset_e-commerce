import 'package:e_commerce/features/profile/presentation/views/widgets/about_us_view_body.dart';
import 'package:flutter/material.dart';

class AboutUsView extends StatelessWidget {
  static const routeName = 'about-us';

  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AboutUsViewBody());
  }
}
