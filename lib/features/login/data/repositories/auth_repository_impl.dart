import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/auth.dart';
import '../../domain/entities/person.dart';
import '../../domain/repositories/auth.dart';
import '../datasource/auth_local_datasource.dart';
import '../datasource/auth_remote_datasource.dart';
import '../models/login_request_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, Auth>> login(String nombreUsuario, String password) async {
    try {
      final request = LoginRequestModel(
        nombreUsuario: nombreUsuario,
        password: password,
      );

      print('Repository: Intentando login...');
      final response = await remoteDataSource.login(request);

      print('Repository: Login exitoso, guardando token y usuario...');
      await localDataSource.cacheToken(response.token);
      await localDataSource.cacheUser(response.user);

      print('Repository: Usuario guardado: ${response.user.nombreUsuario}');
      return Right(response.user);
    } on ServerException catch (e) {
      print('Repository: Error de servidor: ${e.message}');
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      print('Repository: Error de red: ${e.message}');
      return Left(NetworkFailure(e.message));
    } catch (e) {
      print('Repository: Error inesperado: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      await localDataSource.clearToken();
      await localDataSource.clearUser();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Auth>> getCurrentUser() async {
    try {
      // Primero intentar obtener del caché
      final cachedUser = await localDataSource.getCachedUser();
      if (cachedUser != null) {
        print('Repository: Usuario obtenido del caché');
        return Right(cachedUser);
      }

      // Si no hay caché, intentar obtener del servidor
      final token = await localDataSource.getToken();
      if (token == null) {
        print('Repository: No hay token');
        return const Left(CacheFailure('No token found'));
      }

      print('Repository: Obteniendo usuario del servidor...');
      final user = await remoteDataSource.getCurrentUser(token);
      await localDataSource.cacheUser(user);

      return Right(user);
    } on ServerException catch (e) {
      print('Repository: Error obteniendo usuario: ${e.message}');
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      print('Repository: Error de caché: ${e.message}');
      return Left(CacheFailure(e.message));
    } catch (e) {
      print('Repository: Error inesperado: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final token = await localDataSource.getToken();
      return Right(token != null && token.isNotEmpty);
    } catch (e) {
      return const Right(false);
    }
  }

  @override
  Future<Either<Failure, Auth>> register(
      String nombreUsuario,
      String password,
      String rol,
      String estadoCuenta,
      String fechaRegistro,
      String fotoPerfil) async {
    try {
      final response = await remoteDataSource.register(
        nombreUsuario: nombreUsuario,
        password: password,
        rol: rol,
        estadoCuenta: estadoCuenta,
        fechaRegistro: fechaRegistro,
        fotoPerfil: fotoPerfil,
      );

      await localDataSource.cacheToken(response.token);

      return Right(response.user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Person>> createPerson(
      String nombre,
      String apellidoP,
      String apellidoM,
      String idSexo,
      String correoElectronico,
      String telefono,
      String fechaNacimiento) async {
    try {
      final response = await remoteDataSource.createPerson(
        nombre: nombre,
        apellidoP: apellidoP,
        apellidoM: apellidoM,
        idSexo: idSexo,
        correoElectronico: correoElectronico,
        telefono: telefono,
        fechaNacimiento: fechaNacimiento,
      );

      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}