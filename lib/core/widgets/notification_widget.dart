import 'package:e_commerce/core/utils/app_images.dart';
import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: ShapeDecoration(
        color: const Color.fromARGB(255, 248, 221, 215),
        shape: OvalBorder(),
      ),
      child: Image.asset(Assets.assetsImagesNotification),
    );
  }
}
