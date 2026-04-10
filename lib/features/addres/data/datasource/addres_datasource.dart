import 'dart:io';
import '../../../../core/network/http_client.dart';
import '../../../../core/error/exceptions.dart';

class AddresDatasource{
  final HttpClient httpClient;

  AddresDatasource({required this.httpClient});

  Future<void> registerAddres({
    required Map<String, dynamic> data,
    required String token,
  })async{
    await httpClient.post(
      endpoint: '/servicio/direccion',
      body: data,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
  }
}