import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_manager.dart';
import 'strings_manager.dart';

class Routes {
  static String splashRoute = "/";
  static const String introductionRoute = "/introduction_screen";
  static const String mainRoute = "/main_screen";
  static const String homeRoute = "/home_screen";

  // static const String instructionsRoute = "/iInstructionsScreen";

  static Map<String, dynamic> routesList = {};

  static Scaffold get unDefinedRoute {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: ColorManager.white),
        title: const Text(AppStrings.locGeneralError),
      ),
      body: const Center(child: Text(AppStrings.locLocationError)),
    );
  }
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    if (settings.name != null) {
      try {
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => Routes.routesList[settings.name]);
      } on Exception {
        return _unDefinedRoute();
      }
    } else {
      return _unDefinedRoute();
    }
  }

  static MaterialPageRoute _unDefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => Routes.unDefinedRoute,
    );
  }
}
