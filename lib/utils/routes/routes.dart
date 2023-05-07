import 'package:flutter/material.dart';
import 'package:riverpod_mvvm_login/utils/routes/route_names.dart';
import 'package:riverpod_mvvm_login/view/screens/home_view.dart';
import 'package:riverpod_mvvm_login/view/screens/loading_view.dart';
import 'package:riverpod_mvvm_login/view/screens/login_view.dart';
import 'package:riverpod_mvvm_login/view/screens/signup_view.dart';

class Routes {
  /// Generates the routes
  /// Returns the Routes for respective route names
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case RouteNames.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginView());
      case RouteNames.signup:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpView());
      case RouteNames.loading:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoadingView());
      default:
        {
          return MaterialPageRoute(builder: (_) {
            return const Scaffold(
              body: Center(child: Text("Page not found")),
            );
          });
        }
    }
  }
}
