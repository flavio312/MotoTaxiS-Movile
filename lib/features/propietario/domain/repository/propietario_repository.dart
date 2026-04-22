import 'package:viajeseguro/features/propietario/data/models/vehiculo_model.dart';

abstract class PropietarioRepository{
  Future<void> registerPropietario({
    required Map<String, dynamic> data,
    required String token,
  });
  Future<void> registerVehiculo({
    required Map<String, dynamic> data,
    required String token,
  });

  Future<List<VehiculoModel>> getVehiculos(String token);

  Future<void> updateVehiculo({
    required int idVehiculo,
    required Map<String, dynamic> data,
    required String token,
  });
  Future<void> changeVehiculoStatus({
    required int idVehiculo,
    required String token,
  });
}

