import 'package:riverpod_mvvm_login/model/user_model.dart';

/// Interface for repository
abstract class LoginRepository {
  Future<UserModel> loginApi(dynamic data);
  Future<dynamic> registerApi(dynamic data);
}
