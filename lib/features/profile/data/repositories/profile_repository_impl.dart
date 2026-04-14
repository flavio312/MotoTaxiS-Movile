import 'dart:io';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasource/profile_datasource.dart';
import '../models/profile_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDatasource datasource;

  ProfileRepositoryImpl({required this.datasource});

  @override
  Future<String> createUser({required Profile profile, File? fotoPerfil}) async {
    final model = ProfileModel(
      nombreUsuario: profile.nombreUsuario,
      password: profile.password,
      rol: profile.rol,
    );
    return datasource.createUser(model, fotoPerfil);
  }
}