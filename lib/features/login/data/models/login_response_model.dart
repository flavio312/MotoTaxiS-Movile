import 'user_model.dart';

class LoginResponseModel {
  final String token;
  final UserModel user;
  final String? message;

  LoginResponseModel({
    required this.token,
    required this.user,
    this.message,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['token'] ?? '',
      message: json['msg'] ?? json['message'],
      user: UserModel.fromJson(json),
    );
  }
}