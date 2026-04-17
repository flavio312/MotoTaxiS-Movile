import '../../../../core/network/http_client.dart';

class ConductorDatasource {
  final HttpClient httpClient;

  ConductorDatasource({required this.httpClient});

  Future<void> registerConductor({
    required Map<String, dynamic> data,
    required String token,
  }) async {
    await httpClient.post(
      endpoint: '/usuarios/conductor',
      body: data,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
  }
}