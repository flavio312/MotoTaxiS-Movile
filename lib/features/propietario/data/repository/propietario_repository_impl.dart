import 'package:viajeseguro/features/propietario/data/models/vehiculo_model.dart';
import '../../domain/repository/propietario_repository.dart';
import '../datasource/propietario_datasource.dart';

class PropietarioRepositoryImpl implements PropietarioRepository{
  final PropietarioDatasource datasource;

  PropietarioRepositoryImpl({required this.datasource});

  @override
  Future<void> registerPropietario({
    required Map<String, dynamic> data,
    required String token,
  }){
    return datasource.registerPropietario(data: data, token: token);
  }
  @override
  Future<void> registerVehiculo({
    required Map<String, dynamic> data,
    required String token,
  }){
    return datasource.registerVehiculo(data: data, token: token);
  }

  @override
  Future<List<VehiculoModel>> getVehiculos(String token) {
    return datasource.getVehiculos(token);
  }

  @override
  Future<void> updateVehiculo({
    required int idVehiculo,
    required Map<String, dynamic> data,
    required String token,
  }) {
    return datasource.updateVehiculo(
      idVehiculo: idVehiculo,
      data: data,
      token: token,
    );
  }

  @override
  Future<void> changeVehiculoStatus({
    required int idVehiculo,
    required String token,
  }) {
    return datasource.changeVehiculoStatus(
      idVehiculo: idVehiculo,
      token: token,
    );
  }
}
