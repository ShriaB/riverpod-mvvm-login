import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvvm_login/data/api_exceptions.dart';
import 'package:riverpod_mvvm_login/model/user_model.dart';
import 'package:riverpod_mvvm_login/repository/login_repository_impl.dart';

class LoginViewModel {
  final Ref ref;

  LoginViewModel(this.ref);

  Future<UserModel> login(Map<String, String> data) async {
    print("In viewModel login");
    try {
      UserModel user = await ref.read(loginRepositoryProvider).loginApi(data);
      print("In viewModel data: ${user.token}");
      return user;
    } on SocketException {
      rethrow;
    } on UnauthorisedException {
      rethrow;
    } on ServerError {
      rethrow;
    } on Exception {
      rethrow;
    }
  }

  Future<void> signup(data) async {
    try {
      return await ref.read(loginRepositoryProvider).registerApi(data);
    } on SocketException {
      rethrow;
    } on UnauthorisedException {
      rethrow;
    } on ServerError {
      rethrow;
    } on Exception {
      rethrow;
    }
  }
}

final loginViewModelProvider =
    Provider<LoginViewModel>((ref) => LoginViewModel(ref));
final loginDataProvider =
    FutureProvider.family<UserModel, Map<String, String>>((ref, data) {
  return ref.read(loginViewModelProvider).login(data);
});
final signupDataProvider =
    FutureProvider.family<void, Map<String, String>>((ref, data) {
  return ref.read(loginViewModelProvider).signup(data);
});
