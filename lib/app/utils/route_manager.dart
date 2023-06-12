import 'package:earnipay_task/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';

import '../../presentation/splash/splash_view.dart';
class Routes {
  static const String splashRoute = "/";
  static const String homeRoute = "/dashboard";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (context) {
          return const HomeScreen();
        }
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text("No route found"),
          ),
          body: const Center(child: Text("No route found")),
        ));
  }
}
