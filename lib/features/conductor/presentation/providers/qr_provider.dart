import 'package:flutter/material.dart';
import '../../domain/usecase/qr_conductor_usecase.dart';
import '../../domain/entities/qr_conductor.dart';

class QrConductorProvider extends ChangeNotifier {
  final GetQrConductorUseCase getQrConductorUseCase;

  QrConductorProvider({required this.getQrConductorUseCase});

  QrConductorEntity? qrConductor;
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadQr(String token) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      qrConductor = await getQrConductorUseCase(token);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
