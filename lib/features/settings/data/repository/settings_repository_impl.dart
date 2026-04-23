import '../../domain/repository/settings_repository.dart';
import '../../data/datasource/settings_datasource.dart';
import '../../domain/entities/user_profile.dart';

class SettingsRepositoryImpl implements SettingsRepository{
  final SettingsDatasource datasource;

  SettingsRepositoryImpl({required this.datasource});

  @override
  Future<UserProfile> getMe(String token) {
    return datasource.getMe(token);
  }
}