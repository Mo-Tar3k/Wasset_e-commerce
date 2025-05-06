//import 'package:e_commerce/generated/l10n.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:intl/intl.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/helper_funcations/on_generate_routes.dart';
import 'package:e_commerce/core/services/custom_bloc_observer.dart';
import 'package:e_commerce/core/services/get_it_service.dart';
import 'package:e_commerce/core/services/shared_preferences_singleton.dart';
import 'package:e_commerce/core/services/supabase_stoarge.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/features/home/presentation/views/cubits/cart_cubit/cart_cubit.dart';
import 'package:e_commerce/features/home/repos/cart_repo_impl.dart';
import 'package:e_commerce/firebase_options.dart';
import 'package:e_commerce/generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/features/splash_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:e_commerce/features/theme/cubit/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseStoargeService.initSupabase();
  await SupabaseStoargeService.createBucket(kSupabaseBucket);
  Bloc.observer = CustomBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Prefs.init();

  setupGetIt();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CartCubit>(
          create: (context) => CartCubit(CartRepoImpl())..loadCart(),
        ),
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
      ],
      child: const Wasset(),
    ),
  );
}

class Wasset extends StatelessWidget {
  const Wasset({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkTheme) {
        return MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primaryColor,
            ).copyWith(secondary: Colors.blueGrey),
            scaffoldBackgroundColor: const Color(0xFFF9F9F9),
          ),
          darkTheme: ThemeData.dark(),
          themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: const Locale('en'),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: onGenerateRoutes,
          initialRoute: SplashView.routeName,
        );
      },
    );
  }
}
