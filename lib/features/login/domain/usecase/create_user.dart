import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth.dart';
import '../repositories/auth.dart';

class RegisterUser implements UseCase<Auth, RegisterParams>{
  final AuthRepository repository;

  RegisterUser(this.repository);

  @override
  Future<Either<Failure, Auth>> call (RegisterParams params) async{
    return await repository.register(
        params.nombreUsuario,
        params.password,
        params.rol,
        params.estadoCuenta,
        params.fechaRegistro,
        params.fotoPerfil
    );
  }
}

class RegisterParams{
  final String nombreUsuario;
  final String password;
  final String rol;
  final String estadoCuenta;
  final String fechaRegistro;
  final String fotoPerfil;

  RegisterParams({
    required this.nombreUsuario,
    required this.password,
    required this.rol,
    required this.estadoCuenta,
    required this.fechaRegistro,
    required this.fotoPerfil
  });
}