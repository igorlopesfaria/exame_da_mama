import 'package:commons_navigation/commons_navigation.dart';
import 'package:feature_initialization/presentation/screen/initialization_screen.dart';
import 'package:feature_register/presentation/screen/register_screen.dart';
import 'package:feature_splash/presentation/screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppRouter {
  AppRouter._();

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppPaths.splashRoute:
        return _buildRoute(
          view: const SplashScreen(),
          settings: settings,
        );

      case AppPaths.initializationRoute:
        return _buildRoute(
          view: const InitializationScreen(),
          settings: settings,
        );
      case AppPaths.registerRoute:
        return _buildRoute(
          view: const RegisterScreen(),
          settings: settings,
        );

      case AppPaths.loginRoute:
        return _buildRoute(
          view: const Scaffold(
            body: Center(child: Text('Login')),
          ),
          settings: settings,
        );

      default:
        return _buildRoute(
          view: Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
          settings: settings,
        );
    }
  }

  static PageRoute _buildRoute({
    required Widget view,
    required RouteSettings settings,
  }) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoPageRoute(
        builder: (_) => view,
        settings: settings,
      );
    }
    return MaterialPageRoute(
      builder: (_) => view,
      settings: settings,
    );
  }
}
