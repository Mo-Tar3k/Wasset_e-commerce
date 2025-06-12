import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CustomProgresHUDDashboard extends StatelessWidget {
  const CustomProgresHUDDashboard({
    super.key,
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      opacity: 0.5,
      progressIndicator: const CircularProgressIndicator(),
      inAsyncCall: isLoading,
      child: child,
    );
  }
}
