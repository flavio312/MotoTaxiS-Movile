import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';
import 'dart:convert';

abstract class AuthLocalDataSource {
  Future<void> cacheToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> clearUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  static const String TOKEN_KEY = 'cached_token';
  static const String USER_KEY = 'cached_user';

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheToken(String token) async {
    try {
      await sharedPreferences.setString(TOKEN_KEY, token);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<String?> getToken() {
    return Future.value(sharedPreferences.getString(TOKEN_KEY));
  }

  @override
  Future<void> clearToken() async {
    try {
      await sharedPreferences.remove(TOKEN_KEY);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      final jsonString = json.encode(user.toJson());
      await sharedPreferences.setString(USER_KEY, jsonString);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCachedUser() async {
    try {
      final jsonString = sharedPreferences.getString(USER_KEY);
      if (jsonString != null) {
        final jsonMap = json.decode(jsonString);
        return UserModel.fromJson(jsonMap);
      }
      return null;
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<void> clearUser() async {
    try {
      await sharedPreferences.remove(USER_KEY);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}