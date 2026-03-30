import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class HttpClient {
  final String baseUrl;

  HttpClient({required this.baseUrl});

  Future<Map<String, dynamic>> post({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.post(
      url,
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
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
    String fileField = 'image',
    String method = 'POST',
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final request = http.MultipartRequest(method, url);

    request.fields.addAll(fields);

    if (file != null) {
      request.files.add(
        await http.MultipartFile.fromPath(fileField, file.path),
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
    final response = await http.get(url, headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception("GET Error: ${response.statusCode} - ${response.body}");
    }
  }
}
