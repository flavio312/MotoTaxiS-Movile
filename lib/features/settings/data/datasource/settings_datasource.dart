import '../../domain/entities/user_profile.dart';
import 'package:viajeseguro/core/network/http_client.dart';
import '../models/user_profile_model.dart';

class SettingsDatasource {
  final HttpClient httpClient;

  SettingsDatasource({required this.httpClient});

  Future<UserProfile> getMe(String token) async {
    final response = await httpClient.get(
      endpoint: '/auth/me',
      headers: {'Authorization': 'Bearer $token'},
    );

    return UserProfileModel.fromJson(response as Map<String, dynamic>);
  }
}