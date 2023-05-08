import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:riverpod_mvvm_login/data/api_exceptions.dart';
import 'package:riverpod_mvvm_login/data/network/network_api_services.dart';
import 'package:riverpod_mvvm_login/model/user_model.dart';
import 'package:riverpod_mvvm_login/repository/login_repository.dart';
import 'package:riverpod_mvvm_login/utils/resources/api_endpoints.dart';

class LoginRepositoryImpl extends LoginRepository {
  final Ref ref;

  LoginRepositoryImpl(this.ref);

  /// Takes the data that is to be posted to server
  /// If successful Returns the UserModel containing the aunthorisation token
  @override
  Future<UserModel> loginApi(dynamic data) async {
    try {
      dynamic response = await ref
          .read(apiServiceProvider)
          .postData(ApiEndpoints.LOGIN_URL, body: data);
      print("In repository data: $response");
      return UserModel(response['token']);
    } on SocketException {
      rethrow;
    } on UnauthorisedException {
      rethrow;
    } on ServerError {
      rethrow;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  /// Takes the data that is to be posted to server
  /// If successful returns else throws error
  @override
  Future<void> registerApi(dynamic data) async {
    try {
      dynamic response = await ref
          .read(apiServiceProvider)
          .postData(ApiEndpoints.REGISTER_URL, body: data);
    } on SocketException {
      rethrow;
    } on ServerError {
      rethrow;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}

/// Provider-----------------------------------------------------

final loginRepositoryProvider =
    Provider<LoginRepository>((ref) => LoginRepositoryImpl(ref));

/// ---------------------------------------------------------------
