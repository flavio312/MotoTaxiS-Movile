import 'package:dartz/dartz.dart';
import '../entities/auth.dart';
import '../repositories/auth.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class AuthLogin implements UseCase<Auth, AuthParams>{
  final AuthRepository repository;

  AuthLogin(this.repository);

  @override
  Future<Either<Failure, Auth>> call (AuthParams params) async {
    return await repository.login(params.nombreUsuario, params.password);
  }
}

class AuthParams{
  final String nombreUsuario;
  final String password;

  AuthParams({required this.nombreUsuario, required this.password});
}