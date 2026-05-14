import 'package:viajeseguro/features/conductor/data/models/qr_conductor_model.dart';
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

  Future<Map<String, dynamic>> getQrConductor(String token) async {
   final response = await httpClient.get(
       endpoint: '/usuarios/conductor/qr',
       headers: {
         'Authorization': 'Bearer $token'
       },
   );
   return response as Map<String, dynamic>;
  }
}