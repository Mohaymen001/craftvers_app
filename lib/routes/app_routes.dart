import 'package:flutter/material.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/catalog/catalog_screen.dart';
import '../screens/product/product_details_screen.dart';
import '../screens/payment/payment_screen.dart';
import '../models/product.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String catalog = '/catalog';
  static const String productDetails = '/product-details';
  static const String payment = '/payment';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return _fadeRoute(const LoginScreen(), settings);
      case signup:
        return _fadeRoute(const SignupScreen(), settings);
      case home:
        return _fadeRoute(const HomeScreen(), settings);
      case catalog:
        return _slideRoute(const CatalogScreen(), settings);
      case productDetails:
        final product = settings.arguments as Product;
        return _slideRoute(ProductDetailsScreen(product: product), settings);
      case payment:
        final args = settings.arguments as Map<String, dynamic>;
        return _slideRoute(PaymentScreen(product: args['product'], quantity: args['quantity'] ?? 1), settings);
      default:
        return _fadeRoute(const LoginScreen(), settings);
    }
  }

  static PageRouteBuilder _fadeRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  static PageRouteBuilder _slideRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        final tween = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeOutCubic));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 350),
    );
  }
}
