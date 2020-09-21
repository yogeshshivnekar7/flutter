import 'package:flutter/widgets.dart';

class NoomiKeys {
  static final GlobalKey<NavigatorState> navKey =
  new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navKey.currentState.pushNamed(routeName);
  }
}

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
  new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }
}