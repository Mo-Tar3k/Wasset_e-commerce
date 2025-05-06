import 'package:e_commerce/features/profile/presentation/views/widgets/contact_us_view_body.dart';
import 'package:flutter/material.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  static const routeName = 'contact-us';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ContactUsViewBody());
  }
}
