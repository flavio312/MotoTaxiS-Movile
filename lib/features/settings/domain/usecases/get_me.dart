import '../entities/user_profile.dart';
import '../repository/settings_repository.dart';

class GetMe {
  final SettingsRepository repository;

  GetMe(this.repository);

  Future<UserProfile> call(String token) {
    return repository.getMe(token);
  }
}