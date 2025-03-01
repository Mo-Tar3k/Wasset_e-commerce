//import 'package:e_commerce/generated/l10n.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:intl/intl.dart';
import 'package:e_commerce/core/helper_funcations/on_generate_routes.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/features/splash_view.dart';

void main() {
  runApp(const Wasset());
}

class Wasset extends StatelessWidget {
  const Wasset({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoutes,
      initialRoute: SplashView.routeName,
    );
  }
}
