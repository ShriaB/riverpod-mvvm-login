import 'package:flutter/material.dart';
import 'package:riverpod_mvvm_login/utils/routes/route_names.dart';
import 'package:riverpod_mvvm_login/view_model/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  /// Returns a text and the logout Button in a column
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userViewModel = ref.read(userViewModelProvider);
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Home Screen"),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
                onPressed: () {
                  /// On logout clear the saved authentication token
                  /// and navigate back to login screen
                  userViewModel.clearUser();
                  Navigator.pushReplacementNamed(context, RouteNames.login);
                },
                child: const Text("Logout"))
          ],
        ),
      )),
    );
  }
}
