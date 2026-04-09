import '../entities/image_file.dart';

abstract class CameraRepository {
  Future<ImageFile?> capturePhoto();
  Future<ImageFile?> pickFromGallery();
  Future<List<ImageFile>> pickMultipleFromGallery();
  Future<void> deleteTemporaryImage(String path);
}