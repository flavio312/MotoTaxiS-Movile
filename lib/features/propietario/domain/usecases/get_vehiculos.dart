import 'package:viajeseguro/features/propietario/data/models/vehiculo_model.dart';
import '../repository/propietario_repository.dart';

class GetVehiculos {
  final PropietarioRepository repository;

  GetVehiculos(this.repository);

  Future<List<VehiculoModel>> call(String token) {
    return repository.getVehiculos(token);
  }
}