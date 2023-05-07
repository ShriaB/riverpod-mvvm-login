import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_mvvm_login/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserViewModel {
  UserModel? user;
  bool isUserLoggedIn = false;

  Future<void> saveUser(UserModel user) async {
    this.user = user;
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("token", user.token.toString());
    isUserLoggedIn = true;
  }

  Future<bool> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");
    if (token != null) {
      user = UserModel(token);
      isUserLoggedIn = true;
    }
    return isUserLoggedIn;
  }

  Future<void> clearUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    isUserLoggedIn = false;
  }
}

final userViewModelProvider = Provider<UserViewModel>((ref) => UserViewModel());
