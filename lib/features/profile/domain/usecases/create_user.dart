import 'dart:io';
import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class CreateUser {
  final ProfileRepository repository;

  CreateUser({required this.repository});

  Future<String> call({required Profile profile, File? fotoPerfil}) {
    return repository.createUser(profile: profile, fotoPerfil: fotoPerfil);
  }
}