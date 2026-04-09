import '../../../../core/network/http_client.dart';

class PersonDatasource {
  final HttpClient httpClient;

  PersonDatasource({required this.httpClient});

  Future<void> registerPerson({
    required Map<String, dynamic> data,
    required String token,
  }) async {
    await httpClient.post(
      endpoint: '/usuarios/persona',
      body: data,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
  }
}