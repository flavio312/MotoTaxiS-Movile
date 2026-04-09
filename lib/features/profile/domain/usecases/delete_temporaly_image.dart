import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/camera_repository.dart';

class DeleteTemporaryImage {
  final CameraRepository repository;
  DeleteTemporaryImage(this.repository);
  Future<Either<Failure, void>> call(String path) async {
    try {
      await repository.deleteTemporaryImage(path);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Error al eliminar imagen: $e'));
    }
  }
}