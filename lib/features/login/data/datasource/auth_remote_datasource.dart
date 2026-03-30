import '../../../../core/error/exceptions.dart';
import '../../../../core/network/http_client.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(LoginRequestModel request);
  Future<void> logout();
  Future<UserModel> getCurrentUser(String token);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final HttpClient httpClient;

  AuthRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    try {
      final response = await httpClient.post(
        endpoint: '/auth/login',
        body: request.toJson(),
      );

      final loginResponse = LoginResponseModel.fromJson(response);
      if (loginResponse.user == null && loginResponse.token.isNotEmpty) {
        final user = await getCurrentUser(loginResponse.token);
        return LoginResponseModel(
          token: loginResponse.token,
          user: user,
          message: loginResponse.message,
        );
      }
      return loginResponse;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await httpClient.post(endpoint: '/auth/logout', body: {});
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> getCurrentUser(String token) async {
    try {
      final response = await httpClient.get(
        endpoint: '/auth/user',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      return UserModel.fromJson(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}