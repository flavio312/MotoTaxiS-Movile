import 'dart:io';
import 'package:flutter/material.dart';
import '../../domain/entities/profile.dart';
import '../../domain/usecases/create_user.dart';

class ProfileProvider extends ChangeNotifier {
  final CreateUser createUserUseCase;

  ProfileProvider({required this.createUserUseCase});

  bool _isLoading = false;
  String? _error;
  String? _token;
  File? _selectedImage;

  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get token => _token;
  File? get selectedImage => _selectedImage;

  /// Permite actualizar la imagen seleccionada desde cámara o galería
  void setImage(File? image) {
    _selectedImage = image;
    notifyListeners();
  }

  Future<void> register({
    required String nombreUsuario,
    required String password,
    required String rol,
    File? foto,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final profile = Profile(
        nombreUsuario: nombreUsuario,
        password: password,
        rol: rol.toLowerCase(),
      );

      final result = await createUserUseCase(
        profile: profile,
        foto: _selectedImage,
      );

      _token = result;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
  void reset() {
    _isLoading = false;
    _error = null;
    _token = null;
    _selectedImage = null;
    notifyListeners();
  }
}