import 'dart:io';
import '../entities/profile.dart';

abstract class ProfileRepository {
  Future<String> createUser({
    required Profile profile,
    File? fotoPerfil,
  });
}