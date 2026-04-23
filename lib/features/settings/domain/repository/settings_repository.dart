import '../entities/user_profile.dart';

abstract class SettingsRepository {
  Future<UserProfile> getMe(String token);
}