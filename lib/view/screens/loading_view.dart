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
  /// Checks if user is already logged in using UserViewModel
  /// If user logged in then redirects to home page
  /// Else goes to login page with a delay of 2 seconds
  Future<void> isUserLoggedIn() async {
    var userViewModel = ref.read(userViewModelProvider);
    bool isUserLoggedIn = await userViewModel.getUser();

    Future.delayed(const Duration(seconds: 2));

    if (context.mounted) {
      if (isUserLoggedIn) {
        Navigator.of(context).pushReplacementNamed(RouteNames.home);
      } else {
        Navigator.of(context).pushReplacementNamed(RouteNames.login);
      }
    }
  }

  @override
  void initState() {
    isUserLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// While it checks if user is logged in or not a spinner is displayed
    return const Scaffold(
      body: Center(
        child: SpinKitFoldingCube(
          color: Colors.blue,
          size: 50.0,
        ),
      ),
    );
  }
}
