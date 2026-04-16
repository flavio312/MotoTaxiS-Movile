import 'package:flutter/material.dart';
import 'package:viajeseguro/features/conductor/domain/entities/conductor.dart';
import '../../domain/usecase/register_conductor.dart';

class ConductorProvider extends ChangeNotifier {
  final RegisterConductor registerConductorUseCase;

  ConductorProvider({required this.registerConductorUseCase});

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> register({
    required Conductor conductor,
    required String token,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await registerConductorUseCase(
          conductor: conductor,
          token: token);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}