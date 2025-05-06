import 'package:e_commerce/core/entities/product_entity.dart';
import 'package:e_commerce/features/auth/presentation/views/signin_view.dart';
import 'package:e_commerce/features/auth/presentation/views/signup_view.dart';
import 'package:e_commerce/features/best_selling_products/presentation/views/best_selling_view.dart';
import 'package:e_commerce/features/checkout/presentation/views/checkout_view.dart';
import 'package:e_commerce/features/home/models/cart_model.dart';
import 'package:e_commerce/features/product_details/presentation/views/product_details_view.dart';
import 'package:e_commerce/features/product_details/presentation/views/product_reviews_view.dart';
import 'package:e_commerce/features/profile/presentation/views/about_us_view.dart';
import 'package:e_commerce/features/profile/presentation/views/edit_profile_view.dart';
import 'package:e_commerce/features/profile/presentation/views/contact_us_view.dart';
import 'package:e_commerce/features/search/presentation/views/search_view.dart';
import 'package:e_commerce/features/home/presentation/views/main_view.dart';
import 'package:e_commerce/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:e_commerce/features/splash_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case MainView.routeName:
      return MaterialPageRoute(builder: (_) => const MainView());
    case CheckoutView.routeName:
      return MaterialPageRoute(
        builder:
            (_) =>
                CheckoutView(cartItems: settings.arguments as List<CartModel>),
      );
    case BestSellingView.routeName:
      return MaterialPageRoute(builder: (_) => const BestSellingView());
    case ProductDetailsView.routeName:
      return MaterialPageRoute(
        builder:
            (_) => ProductDetailsView(
              product: settings.arguments as ProductEntity,
            ),
      );
    case ProductReviewsView.routeName:
      final productId = settings.arguments as int;
      return MaterialPageRoute(
        builder: (_) => ProductReviewsView(productId: productId),
      );
    case EditProfileView.routeName:
      return MaterialPageRoute(builder: (_) => const EditProfileView());
    case ContactUsView.routeName:
      return MaterialPageRoute(builder: (_) => const ContactUsView());
    case AboutUsView.routeName:
      return MaterialPageRoute(builder: (_) => const AboutUsView());
    case SearchView.routeName:
      return MaterialPageRoute(builder: (_) => const SearchView());
    case SplashView.routeName:
      return MaterialPageRoute(builder: (_) => const SplashView());
    case SigninView.routeName:
      return MaterialPageRoute(builder: (_) => const SigninView());
    case SignupView.routeName:
      return MaterialPageRoute(builder: (_) => const SignupView());
    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (_) => const OnBoardingView());
    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}
