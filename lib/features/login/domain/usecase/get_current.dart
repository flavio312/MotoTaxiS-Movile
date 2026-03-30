import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth.dart';
import '../repositories/auth.dart';

class GetCurrentUser implements UseCase<Auth, NoParams>{
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  @override
  Future<Either<Failure, Auth>> call(NoParams params) async{
    return await repository.getCurrentUser();
  }
}