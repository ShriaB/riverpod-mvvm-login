import 'package:flutter/material.dart';
import 'package:riverpod_mvvm_login/data/network/base_api_services.dart';
import 'package:riverpod_mvvm_login/data/network/network_api_services.dart';
import 'package:riverpod_mvvm_login/repository/login_repository.dart';
import 'package:riverpod_mvvm_login/repository/login_repository_impl.dart';
import 'package:riverpod_mvvm_login/utils/routes/route_names.dart';
import 'package:riverpod_mvvm_login/utils/routes/routes.dart';
import 'package:riverpod_mvvm_login/view_model/login_view_model.dart';
import 'package:riverpod_mvvm_login/view_model/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Provider
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RouteNames.loading,
      onGenerateRoute: Routes.generateRoutes,
    );
  }
}
