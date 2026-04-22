import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../domain/entities/auth.dart';
import '../../domain/usecase/login_user.dart';
import '../../domain/usecase/logout_user.dart';
import '../../domain/usecase/get_current.dart';
import '../../../../core/usecases/usecase.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthProvider with ChangeNotifier {

  final AuthLogin loginUseCase;
  final LogoutUser logoutUseCase;
  final GetCurrentUser getCurrentUserUseCase;

  AuthProvider({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.getCurrentUserUseCase,
  }) {
    _checkAuthStatus();
  }

  String? _token;
  String? _rol;

  String? get token => _token;
  String? get rol => _rol;

  AuthStatus _status = AuthStatus.initial;
  Auth? _auth;
  String? _errorMessage;

  AuthStatus get status => _status;
  Auth? get user => _auth;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _status == AuthStatus.authenticated;
  bool get isLoading => _status == AuthStatus.loading || _status == AuthStatus.initial;

  Future<void> _checkAuthStatus() async {
    _status = AuthStatus.loading;
    notifyListeners();

    final result = await getCurrentUserUseCase(NoParams());

    result.fold(
          (failure) {
        _status = AuthStatus.unauthenticated;
        _auth = null;
        notifyListeners();
      },
          (user) {
        _status = AuthStatus.authenticated;
        _auth = user;
        _rol = user.rol;
        notifyListeners();
      },
    );
  }

  Future<bool> login(String nombreUsuario, String password) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await loginUseCase(
      AuthParams(nombreUsuario: nombreUsuario, password: password),
    );

    return result.fold(
          (failure) {
        _status = AuthStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
        return false;
      }, (user) {
        _status = AuthStatus.authenticated;
        _auth = user;
        _rol = user.rol;
        _errorMessage = null;
        notifyListeners();
        return true;
      },
    );
  }

  Future<void> logout() async {
    _status = AuthStatus.loading;
    notifyListeners();

    await logoutUseCase(NoParams());

    _status = AuthStatus.unauthenticated;
    _auth = null;
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}