import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

abstract class LocalDataSource {
  Future<UserModel?> getLastUser();
  Future<void> saveUser(UserModel user);
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences _sharedPreferences;

  LocalDataSourceImpl({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  @override
  Future<UserModel?> getLastUser() async {
    final user = _sharedPreferences.getString('user');
    return user != null
        ? UserModel.fromJson(jsonDecode(user) as Map<String, dynamic>)
        : null;
  }

  @override
  Future<void> saveUser(UserModel user) {
    return _sharedPreferences.setString('user', user.toRawJson());
  }
}
