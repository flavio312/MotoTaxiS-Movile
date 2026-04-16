import 'package:flutter/material.dart';
import '../../domain/usecases/register_propietario.dart';

class PropietarioProvider extends ChangeNotifier {
  final RegisterPropietario registerProietarioUseCase;

  PropietarioProvider({required this.registerProietarioUseCase});

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => error;

  Future<void>register({
    required Map<String, dynamic>data,
    required String token,
  }) async{
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await registerProietarioUseCase(
        data: data,
        token: token,
      );
    }catch(e){
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
