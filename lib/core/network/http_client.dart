import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'auth_service.dart';
import 'package:http_parser/http_parser.dart';

class HttpClient {
  final String baseUrl;
  final AuthService _authService = AuthService();

  HttpClient({required this.baseUrl});

  Future<Map<String, dynamic>> post({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final token = await _authService.getToken();

    final response = await http.post(
      url,
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
        if(token != null) 'Authorization': 'Bearer $token',
        ...?headers,
      },
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        throw Exception("Respuesta vacía del servidor");
      }
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception("Error ${response.statusCode}: ${response.body}");
    }
  }

  Future<dynamic> multipart({
    required String endpoint,
    required Map<String, String> fields,
    required File? file,
    String fileField = 'fotoPerfil',
    String method = 'POST',
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final request = http.MultipartRequest(method, url);

    request.fields.addAll(fields);

    if (file != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
            fileField,
            file.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );
    }

    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Multipart Error: ${response.statusCode} - ${response.body}");
    }
  }

  Future<Map<String, dynamic>> put({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final token = await _authService.getToken();

    final response = await http.put(
      url,
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
        if(token != null) 'Authorization': 'Bearer $token',
        ...?headers,
      },
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        throw Exception("Respuesta vacía del servidor");
      }
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception("Error ${response.statusCode}: ${response.body}");
    }
  }

  Future<void> delete({required String endpoint}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.delete(url);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception("DELETE Error: ${response.statusCode} - ${response.body}");
    }
  }

  Future<dynamic> get({
    required String endpoint,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');

    final token = await _authService.getToken();

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
        ...?headers,
      },
    );

    if (response.statusCode == 401) {
      await _authService.clearSession();
      throw Exception('SESSION_EXPIRED');
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception("GET Error: ${response.statusCode} - ${response.body}");
    }
  }
}
