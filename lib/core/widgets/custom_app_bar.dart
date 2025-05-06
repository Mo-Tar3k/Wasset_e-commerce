import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/widgets/notification_widget.dart';
import 'package:flutter/material.dart';

AppBar CustomBuildAppBar(
  context, {
  required String title,
  bool showBackButton = true,
  bool showNotification = true,
}) {
  return AppBar(
    backgroundColor: AppColors.white(context),
    actions: [
      Visibility(
        visible: showNotification,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: NotificationWidget(),
        ),
      ),
    ],
    leading: Visibility(
      visible: showBackButton,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back_ios, color: AppColors.blac(context)),
      ),
    ),
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
        color: AppColors.blac(context),
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
