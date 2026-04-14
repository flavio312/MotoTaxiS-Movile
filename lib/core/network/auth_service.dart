import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthService {
  static const _tokenKey = 'auth_token';

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  /// 🔥 NUEVO: validar si el token expiró
  Future<bool> isTokenExpired() async {
    final token = await getToken();
    if (token == null) return true;

    return JwtDecoder.isExpired(token);
  }

  /// 🔥 NUEVO: obtener rol desde el token
  Future<String?> getRole() async {
    final token = await getToken();
    if (token == null) return null;

    final decoded = JwtDecoder.decode(token);
    return decoded['rol'];
  }

  /// 🔥 NUEVO: sesión válida
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    if (token == null) return false;

    return !JwtDecoder.isExpired(token);
  }
}