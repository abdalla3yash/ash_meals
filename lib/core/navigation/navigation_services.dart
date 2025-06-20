import 'package:flutter/widgets.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  static Future<dynamic> push(String route, {Map<String, dynamic>? arguments}) async => await navigationKey.currentState?.pushNamed(route, arguments: arguments);

  static Future<dynamic> pushReplacement(String route, { Map<String, dynamic>? arguments}) async => await navigationKey.currentState?.pushReplacementNamed(route, arguments: arguments);

  static Future<dynamic> pushReplacementAll( String route, {Map<String, dynamic>? arguments}) async =>  await navigationKey.currentState?.pushNamedAndRemoveUntil( route, (route) => false, arguments: arguments);

  static dynamic goBack([Object? result]) => navigationKey.currentState?..pop(result);
}
