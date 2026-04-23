import '../../../../core/error/exceptions.dart';
import '../../../../core/network/http_client.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import '../models/user_model.dart';
import '../models/person_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(LoginRequestModel request);
  Future<UserModel> getCurrentUser(String token);

  Future<LoginResponseModel> register({
    required String nombreUsuario,
    required String password,
    required String rol,
    required String estadoCuenta,
    required String fechaRegistro,
    required String fotoPerfil,
  });

  Future<PersonModel> createPerson({
    required String nombre,
    required String apellidoP,
    required String apellidoM,
    required String idSexo,
    required String correoElectronico,
    required String telefono,
    required String fechaNacimiento,
  });
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

  @override
  Future<LoginResponseModel> register({
    required String nombreUsuario,
    required String password,
    required String rol,
    required String estadoCuenta,
    required String fechaRegistro,
    required String fotoPerfil,
  }) async {
    try {
      final response = await httpClient.post(
        endpoint: '/auth/register',
        body: {
          'nombreUsuario': nombreUsuario,
          'password': password,
          'rol': rol,
          'estadoCuenta': estadoCuenta,
          'fechaRegistro': fechaRegistro,
          'fotoPerfil': fotoPerfil,
        },
      );
      return LoginResponseModel.fromJson(response);
    } catch (e, stack) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<PersonModel> createPerson({
    required String nombre,
    required String apellidoP,
    required String apellidoM,
    required String idSexo,
    required String correoElectronico,
    required String telefono,
    required String fechaNacimiento,
  }) async {
    try {
      final response = await httpClient.post(
        endpoint: '/person/create',
        body: {
          'nombre': nombre,
          'apellidoP': apellidoP,
          'apellidoM': apellidoM,
          'idSexo': idSexo,
          'correoElectronico': correoElectronico,
          'telefono': telefono,
          'fechaNacimiento': fechaNacimiento,
        },
      );
      return PersonModel.fromJson(response);
    } catch (e, stack) {
      throw ServerException(e.toString());
    }
  }
}
