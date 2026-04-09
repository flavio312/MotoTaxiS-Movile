import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../domain/entities/image_file.dart';
import '../../domain/repositories/camera_repository.dart';
import '../../../../core/error/exceptions.dart';

class CameraDatasource implements CameraRepository {
  final ImagePicker _picker;

  CameraDatasource({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  @override
  Future<ImageFile?> capturePhoto() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 1080,
        maxWidth: 1080,
        imageQuality: 90,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (image == null) return null;

      return await _convertXFileToImageFile(image);
    } catch (e) {
      throw CacheException('Error al capturar foto: $e');
    }
  }

  @override
  Future<ImageFile?> pickFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 1080,
        maxWidth: 1080,
        imageQuality: 90,
      );

      if (image == null) return null;

      return await _convertXFileToImageFile(image);
    } catch (e) {
      throw CacheException('Error al seleccionar imagen: $e');
    }
  }

  @override
  Future<List<ImageFile>> pickMultipleFromGallery() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(
        maxHeight: 1080,
        maxWidth: 1080,
        imageQuality: 90,
      );

      final List<ImageFile> imageFiles = [];
      for (final image in images) {
        final imageFile = await _convertXFileToImageFile(image);
        imageFiles.add(imageFile);
      }

      return imageFiles;
    } catch (e) {
      throw CacheException('Error al seleccionar múltiples imágenes: $e');
    }
  }

  @override
  Future<void> deleteTemporaryImage(String path) async {
    try {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      throw CacheException('Error al eliminar imagen temporal: $e');
    }
  }

  Future<ImageFile> _convertXFileToImageFile(XFile xFile) async {
    final file = File(xFile.path);
    final size = await file.length();

    return ImageFile(
      path: xFile.path,
      name: xFile.name,
      size: size,
      capturedAt: DateTime.now(),
    );
  }
}