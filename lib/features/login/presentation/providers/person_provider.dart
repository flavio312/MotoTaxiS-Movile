import 'package:flutter/material.dart';
import '../../domain/usecase/register_person.dart';

class PersonProvider extends ChangeNotifier {
  final RegisterPerson registerPersonUseCase;

  PersonProvider({required this.registerPersonUseCase});

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> register({
    required Map<String, dynamic> data,
    required String token,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await registerPersonUseCase(
        data: data,
        token: token,
      );
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}