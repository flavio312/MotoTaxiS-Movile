import 'package:viajeseguro/core/network/http_client.dart';
import 'package:viajeseguro/features/propietario/data/models/vehiculo_model.dart';

class PropietarioDatasource {
  final HttpClient httpClient;

  PropietarioDatasource({required this.httpClient});

  Future<void> registerPropietario({
    required Map<String, dynamic> data,
    required String token,
  })async{
    await httpClient.post(
      endpoint: '/usuarios/propietarios',
      body: data,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<void> registerVehiculo({
    required Map<String, dynamic> data,
    required String token,
  })async{
    await httpClient.post(
      endpoint: '/usuarios/vehiculos/propietario',
      body: data,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<List<VehiculoModel>> getVehiculos(String token) async {
    final response = await httpClient.get(
      endpoint: '/usuarios/vehiculos/propietario',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    final List data = response as List;

    return data
        .map((e) => VehiculoModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> updateVehiculo({
    required int idVehiculo,
    required Map<String, dynamic> data,
    required String token,
  }) async {
    await httpClient.put(
      endpoint: '/usuarios/vehiculos/$idVehiculo',
      body: data,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<void> changeVehiculoStatus({
    required int idVehiculo,
    required String token,
  }) async {
    await httpClient.put(
      endpoint: '/usuarios/vehiculos/$idVehiculo/status',
      body: {
        "estatus": "inactivo",
        "descripcion": "Eliminado desde app"
      },
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
  }
}