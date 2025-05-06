import 'package:e_commerce/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/core/widgets/build_app_bar.dart';

class AboutUsViewBody extends StatelessWidget {
  const AboutUsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'About Us', showNotification: false),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFDEFEF), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // الصورة الرمزية
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  Assets.assetsImagesAboutUs, // تأكد أنها موجودة
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

              // العنوان الرئيسي
              Text(
                'Welcome to Our Platform',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),

              // البوكس الداخلي
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Text(
                  '''
We simplify and enhance the connection between customers and service providers by offering an accessible, reliable, and versatile platform.

We aim to support small businesses and freelancers, enabling them to thrive online by expanding their reach and facilitating quality interactions with customers across various industries.
                  ''',
                  style: TextStyle(
                    fontSize: 15.5,
                    height: 1.7,
                    fontFamily: 'Cairo',
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),

              const SizedBox(height: 32),

              // جملة الشكر
              RichText(
                text: const TextSpan(
                  text: 'Thank you ',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  children: [
                    TextSpan(
                      text: 'for choosing us!',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
