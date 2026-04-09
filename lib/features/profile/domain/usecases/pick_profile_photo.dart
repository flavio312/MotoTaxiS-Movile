import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/image_file.dart';
import '../repositories/camera_repository.dart';

class PickProductPhoto {
  final CameraRepository repository;
  PickProductPhoto(this.repository);
  Future<Either<Failure, ImageFile?>> call() async {
    try {
      final image = await repository.pickFromGallery();
      return Right(image);
    } catch (e) {
      return Left(CacheFailure('Error al seleccionar foto: $e'));
    }
  }
}