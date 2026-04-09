import 'dart:io';
import 'package:equatable/equatable.dart';

class ImageFile extends Equatable {
  final String path;
  final String name;
  final int size;
  final DateTime capturedAt;

  const ImageFile({
    required this.path,
    required this.name,
    required this.size,
    required this.capturedAt,
  });

  File get file => File(path);

  ImageFile copyWith({
    String? path,
    String? name,
    int? size,
    DateTime? capturedAt,
  }) {
    return ImageFile(
      path: path ?? this.path,
      name: name ?? this.name,
      size: size ?? this.size,
      capturedAt: capturedAt ?? this.capturedAt,
    );
  }

  @override
  List<Object?> get props => [path, name, size, capturedAt];

  @override
  String toString() {
    return 'ImageFile(path: $path, name: $name, size: $size, capturedAt: $capturedAt)';
  }
}