import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'http_client.dart';

class ApiConfig {
  static HttpClient httpClient = HttpClient(
    baseUrl: dotenv.env['API_BASE_URL']!,
  );
}
