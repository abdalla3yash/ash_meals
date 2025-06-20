
import 'package:ash_cart/features/cart/presentation/view/cart_screen.dart';
import 'package:ash_cart/features/products/presentation/view/products_screen.dart';
import 'package:flutter/material.dart';
import '../view/view/undefined_route_screen.dart';
import 'navigation.dart';

class RouteGenerator {
  static Route onGenerateRoute(RouteSettings settings) {
    // final Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;
    switch (settings.name) {
      case Routes.mainScreen:
        return platformPageRoute(const ProductsScreen());
      case Routes.cartScreen:
        return platformPageRoute(const CartScreen());
      default:
        return platformPageRoute(const UndefinedRouteScreen());
    }
  }
}
