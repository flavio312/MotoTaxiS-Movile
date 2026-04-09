import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/image_file.dart';
import '../repositories/camera_repository.dart';

class CaptureProductPhoto {
  final CameraRepository repository;
  CaptureProductPhoto(this.repository);
  Future<Either<Failure, ImageFile?>> call() async {
    try {
      final image = await repository.capturePhoto();
      return Right(image);
    } catch (e) {
      return Left(CacheFailure('Error al capturar foto: $e'));
    }
  }
}