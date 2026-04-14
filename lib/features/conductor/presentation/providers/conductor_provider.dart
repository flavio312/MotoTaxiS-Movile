import 'package:flutter/material.dart';
import '../../domain/entities/conductor.dart';
import '../../domain/usecase/register_conductor.dart';

class ConductorProvider extends ChangeNotifier {
  final RegisterConductor registerConductor;

  ConductorProvider({required this.registerConductor});

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> register(Conductor conductor, String token) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
     // await registerConductor(conductor, token);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}