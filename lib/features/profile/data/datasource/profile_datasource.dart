import 'dart:io';
import '../../../../core/network/http_client.dart';
import '../models/profile_model.dart';

class ProfileDatasource {
  final HttpClient httpClient;

  ProfileDatasource({required this.httpClient});

  Future<String> createUser(ProfileModel model, File? fotoPerfil) async {
    final response = await httpClient.multipart(
      endpoint: '/usuarios/registro',
      fields: model.toFields(),
      file: fotoPerfil,
      fileField: 'fotoPerfil',
      method: 'POST',
    );

    final token = response['token'] as String?;
    if (token == null) throw Exception('Token no recibido del servidor');
    return token;
  }
}