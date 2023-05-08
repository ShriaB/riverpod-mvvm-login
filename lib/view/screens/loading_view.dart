import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:riverpod_mvvm_login/utils/routes/route_names.dart';
import 'package:riverpod_mvvm_login/view_model/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingView extends ConsumerStatefulWidget {
  const LoadingView({super.key});

  @override
  ConsumerState<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends ConsumerState<LoadingView> {
  /// Checks if user is logged in
  /// If user logged in redirects to home screen
  /// Else to login screen
  Future<void> isUserLoggedIn() async {
    await Future.delayed(const Duration(seconds: 2));
    ref.watch(getUserProvider.future).then((value) {
      if (context.mounted) {
        if (value) {
          Navigator.of(context).pushReplacementNamed(RouteNames.home);
        } else {
          Navigator.of(context).pushReplacementNamed(RouteNames.login);
        }
      }
    });
  }

  @override
  void initState() {
    /// We can call async functions only in the initState function not in the build function
    /// And the function should be called before super.initState()
    isUserLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// While it checks if user is logged in or not a spinner is displayed
    return const Scaffold(
        body: Center(
            child: SpinKitFadingCube(
      color: Colors.blue,
      size: 50.0,
    )));
  }
}
