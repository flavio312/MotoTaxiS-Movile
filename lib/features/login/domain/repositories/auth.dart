import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/auth.dart';

abstract class AuthRepository{
  Future<Either<Failure, Auth>> login(String nombreUsuario, String password);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, Auth>> getCurrentUser();
  Future<Either<Failure, bool>> isAuthenticated();
}