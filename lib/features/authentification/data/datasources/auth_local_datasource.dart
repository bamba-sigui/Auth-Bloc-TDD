import "dart:convert";

import "package:auth_bloc/core/error/failures.dart";
import "package:auth_bloc/features/authentification/data/models/auth_model.dart";
import "package:hive_flutter/hive_flutter.dart";

import "../../../../core/providers/hive_helper.dart";
import "../../../../core/utils/app_constants.dart";

abstract class AuthLocalDataSource {
  Future<UserModel> getUserFromLocal();
  Future<TokenModel> getTokenFromLocal();
  Future<void> cacheUser(UserModel user);
  Future<void> cacheToken(TokenModel token);
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final HiveInterface hive;
  AuthLocalDataSourceImpl({required this.hive});

  @override
  Future<void> cacheToken(TokenModel token) async {
    try {
      HiveHelper hiveHelper = HiveHelper(hive: hive);
      final String tokenString = json.encode(token);
      await hiveHelper.setValue(AppConstants.tokenKey, tokenString);
    } catch (e) {
      print(e);
      throw CacheFailure(message: e.toString());
    }
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      HiveHelper hiveHelper = HiveHelper(hive: hive);
      final String userString = json.encode(user);
      await hiveHelper.setValue(AppConstants.userKey, userString);
    } catch (e) {
      print(e);
      throw CacheFailure(message: e.toString());
    }
  }

  @override
  Future<TokenModel> getTokenFromLocal() async {
    try {
      HiveHelper hiveHelper = HiveHelper(hive: hive);
      final String resultString = hiveHelper.getValue(AppConstants.tokenKey);
      final String result = json.decode(resultString);
      final TokenModel tokenModel = TokenModel.fromCache(result);
      return tokenModel;
    } catch (e) {
      print(e);
      throw CacheFailure(message: e.toString());
    }
  }

  @override
  Future<UserModel> getUserFromLocal() async {
    try {
      HiveHelper hiveHelper = HiveHelper(hive: hive);
      final String resultString = hiveHelper.getValue(AppConstants.userKey);
      final String result = json.decode(resultString);
      final UserModel userModel = UserModel.fromCache(result);
      return userModel;
    } catch (e) {
      throw CacheFailure(message: e.toString());
    }
  }
}