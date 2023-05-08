import 'dart:io';

import 'package:flutter/material.dart';
import 'package:riverpod_mvvm_login/data/api_exceptions.dart';
import 'package:riverpod_mvvm_login/utils/routes/route_names.dart';
import 'package:riverpod_mvvm_login/utils/utils.dart';
import 'package:riverpod_mvvm_login/utils/validators.dart';
import 'package:riverpod_mvvm_login/view/styles/styles.dart';
import 'package:riverpod_mvvm_login/view_model/login_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  /// TextEditingControllers for TextFormFields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  /// Focus nodes for TextFormFields
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  final _isEmailValid = StateProvider<bool>((ref) => true);
  final _isPasswordValid = StateProvider<bool>((ref) => true);
  final _isConfirmPasswordValid = StateProvider<bool>((ref) => true);
  final _obscurePassword = StateProvider<bool>((ref) => true);
  final _obscureConfirmPassword = StateProvider<bool>((ref) => true);

  void signup() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    ref
        .read(_isEmailValid.notifier)
        .update((state) => Validators.isEmailFormatValid(email));
    ref
        .read(_isPasswordValid.notifier)
        .update((state) => Validators.isPasswordValid(password));

    ref.read(_isConfirmPasswordValid.notifier).update((state) =>
        Validators.isConfirmPasswordValid(password, confirmPassword));

    /// Checks if email and password have a valid format and if confirm password matches password
    /// If not valid then display error messages automatically due to changed state
    if (ref.read(_isEmailValid) &&
        ref.read(_isPasswordValid) &&
        ref.read(_isConfirmPasswordValid)) {
      Map<String, String> data = {"email": email, "password": password};

      /// If valid then calls the signup() of viewModel
      ref.watch(signupDataProvider(data).future).then((value) {
        /// If request is successful then navigates to Login screen
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, RouteNames.login);
        }
      }).onError((error, stackTrace) {
        /// Else displays snackbars to give feedback to the user that request failed
        if (error is SocketException) {
          Utils.showRedSnackBar(
              context, "You are offline! Please check internet connection.");
        } else {
          Utils.showRedSnackBar(
              context, "Some error occured! Please try after some time.");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        /// Appbar
        appBar: AppBar(
          title: const Text("Sign up"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Email text field
              TextFormField(
                controller: _emailController,
                focusNode: _emailFocusNode,
                onFieldSubmitted: (value) {
                  Utils.changeFocus(
                      context, _emailFocusNode, _passwordFocusNode);
                },
                decoration: InputDecoration(
                    border: textInputDecorationBorder,
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.email),

                    /// Listening to [_isEmailValid] for displaying error messages
                    errorText: ref.watch(_isEmailValid)
                        ? null
                        : "Please enter a valid email address: example@domain.com"),
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(
                height: 20.0,
              ),

              /// Password text field
              TextFormField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                decoration: InputDecoration(
                  border: textInputDecorationBorder,
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: InkWell(
                    onTap: () {
                      ref
                          .read(_obscurePassword.notifier)
                          .update((state) => !state);
                    },
                    child: (ref.watch(_obscurePassword))
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),

                  /// Listening to [_isPasswordValid] for displaying error message in password is invalid
                  errorText: ref.watch(_isPasswordValid)
                      ? null
                      : "Password should contain atleat 6 characters",
                ),

                /// Listening to [_obscurePassword] for hidding and showing the password
                obscureText: ref.watch(_obscurePassword),
              ),

              const SizedBox(
                height: 20.0,
              ),

              /// Confirm Password text field
              TextFormField(
                controller: _confirmPasswordController,
                focusNode: _confirmPasswordFocusNode,
                decoration: InputDecoration(
                  border: textInputDecorationBorder,
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: InkWell(
                    onTap: () {
                      ref
                          .read(_obscureConfirmPassword.notifier)
                          .update((state) => !state);
                    },
                    child: (ref.watch(_obscureConfirmPassword))
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),

                  /// Listening to [_isPasswordValid] for displaying error message in password is invalid
                  errorText: ref.watch(_isConfirmPasswordValid)
                      ? null
                      : "Confirm Password should match the password",
                ),

                /// Listening to [_obscurePassword] for hidding and showing the password
                obscureText: ref.watch(_obscureConfirmPassword),
              ),

              const SizedBox(
                height: 20.0,
              ),

              /// Signup Button
              ElevatedButton.icon(
                  style: textButtonStyle,
                  onPressed: () {
                    signup();
                  },
                  icon: const Icon(
                    Icons.login,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Signup",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  )),

              const SizedBox(
                height: 20.0,
              ),

              /// Sign Up text
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, RouteNames.login);
                },
                child: const Center(
                    child: Text("Already have an account? Login.")),
              )
            ],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }
}
