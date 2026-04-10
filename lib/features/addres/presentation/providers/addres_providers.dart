import 'package:flutter/material.dart';
import '../../domain/usecases/register_addres.dart';

class AddresProvider extends ChangeNotifier {
  final RegisterAddres registerAddresUseCase;

  AddresProvider({required this.registerAddresUseCase});

  bool _isLoading = false;
  String? _errorMessage;
  bool _success = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get success => _success;

  Future<void> saveAddress({
    required Map<String, dynamic> data,
    required String token,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    _success = false;
    notifyListeners();

    try {
      await registerAddresUseCase.call(data: data, token: token);
      _success = true;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
