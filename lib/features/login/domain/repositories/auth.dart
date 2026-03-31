import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/person.dart';
import '../entities/auth.dart';

abstract class AuthRepository{
  Future<Either<Failure, Auth>> login(String nombreUsuario, String password);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, Auth>> getCurrentUser();
  Future<Either<Failure, bool>> isAuthenticated();
  Future<Either<Failure, Auth>> register(
      String nombreUsuario,
      String password,
      String rol,
      String estadoCuenta,
      String fechaRegistro,
      String fotoPerfil);
  Future<Either<Failure, Person>> createPerson(
      String nombre,
      String apellidoP,
      String apellidoM,
      String idSexo,
      String correoElectronico,
      String telefono,
      String fechaNacimiento);
}